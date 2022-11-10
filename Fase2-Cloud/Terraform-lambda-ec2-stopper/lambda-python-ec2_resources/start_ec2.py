import boto3
region = 'eu-west-1'
instances = ['i-0213ec06a6be0c8ec']
ec2 = boto3.client('ec2', region_name=region)
def lambda_handler(event, context):
    ec2.start_instances(InstanceIds=instances)
    print('started your instances: '+ str(instances))