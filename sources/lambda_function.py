import boto3 # type: ignore

# Initialise le client CloudWatch
cloudwatch = boto3.client('cloudwatch')

def lambda_handler(event, context):
    # Liste des noms d'alarmes à arrêter
    alarm_names_to_stop = []

    # Mots-clés à rechercher dans les noms d'alarmes
    #keywords_to_search = ['']
    keywords_to_search = event.get("keywords")
    event_s = event.get("status")
    print(event_s)
    # Initialisation du jeton pour pagination
    next_token = ''
    stop_var= 'stop'
    start_var= 'start'

    while True:
        # Obtient la liste de toutes les alarmes avec pagination
        response = cloudwatch.describe_alarms(NextToken=next_token)

        # Filtrer les alarmes qui contiennent l'un des mots-clés
        for alarm in response['MetricAlarms']:
            for keyword in keywords_to_search:
                if keyword in alarm['AlarmName']:
                    alarm_names_to_stop.append(alarm['AlarmName'])

        # Si la réponse a un jeton suivant, continuez la pagination
        next_token = response.get('NextToken')
        if not next_token:
            break
    print(alarm_names_to_stop)
    # Appel à la fonction pour arrêter chaque alarme
    for alarm_name in alarm_names_to_stop:
        if event_s == stop_var:
            stop_alarm(alarm_name)
            print("Stop Alarmes OK",alarm_name)
        elif event_s == start_var:
            start_alarm(alarm_name)
            print("Start Alarmes OK",alarm_name)
        else:
            print("Lambda KO",alarm_name)

            

    return {
        'statusCode': 200,
        'body': 'Alarmes contenant les mots-clés arrêtées avec succès.'
    }

# Fonction pour arrêter une alarme
def stop_alarm(alarm_name):
    # Paramètres pour arrêter l'alarme
    params = {
        'AlarmNames': [alarm_name]
    }

    # Appel à l'API CloudWatch pour arrêter l'alarme
    cloudwatch.disable_alarm_actions(**params)

# Fonction pour start une alarme
def start_alarm(alarm_name):
    # Paramètres pour arrêter l'alarme
    params = {
        'AlarmNames': [alarm_name]
    }

    # Appel à l'API CloudWatch pour arrêter l'alarme
    cloudwatch.enable_alarm_actions(**params)