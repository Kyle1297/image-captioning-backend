from channels.generic.websocket import AsyncWebsocketConsumer
from .utils import create_subscription, delete_subscription
import json

class CaptionSNSConsumer(AsyncWebsocketConsumer):
	async def connect(self):
		# create channel group
		self.uuid = self.scope['url_route']['kwargs']['uuid']
		await self.channel_layer.group_add(
			self.uuid,
			self.channel_name,
		)

		# accept websocket
		await self.accept()

		# subscribe to lambda sns topic to receive generate caption
		self.subscription_arn = create_subscription(self.uuid)

	async def disconnect(self, close_code):
		# unsubscribe from lambda topic
		delete_subscription(self.subscription_arn)

		# remove channel group
		await self.channel_layer.group_discard(
			self.uuid,
			self.channel_name,
		)

	async def caption(self, event):
		caption = event['caption']
		await self.send(text_data=json.dumps({
			'caption': caption,
		}))
		self.close()