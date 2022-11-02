import boto3
s3_client = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('user')
def lambda_handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    csv_file_name = event['Records'][0]['s3']['object']['key']
    csv_object = s3_client.get_object(Bucket=bucket,Key=csv_file_name)
    file_reader = csv_object['Body'].read().decode("utf-8")
    print(file_reader)
    users = file_reader.split("\n")
    users = list(filter(None, users))
    for user in users:
        user_data = user.split(",")
        table.put_item(Item = {
            "id" : user_data[0],
            "name" : user_data[1],
            "salary" : user_data[2]
        })
    return 'success'