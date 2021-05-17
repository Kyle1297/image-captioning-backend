import boto3
from django.conf import settings

sns_client = boto3.client("sns",
                         region_name=settings.AWS_DEFAULT_REGION,
                         aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
                         aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
                        )

# create subscription
def create_subscription(uuid):
	response = sns_client.subscribe(TopicArn=settings.CAPTION_TOPIC_ARN, 
									Protocol="HTTPS", 
									Endpoint=f"https://{settings.ALLOWED_HOSTS[0]}/api_v1/utils/caption-sns/{uuid}/",
									ReturnSubscriptionArn=True)
	return response["SubscriptionArn"]

# delete subscription
def delete_subscription(subscription_arn):
	sns_client.unsubscribe(SubscriptionArn=subscription_arn)