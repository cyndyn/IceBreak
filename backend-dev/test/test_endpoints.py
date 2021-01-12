from django.test import TestCase
from rest_framework.test import APIRequestFactory, force_authenticate
import json
from api.views.questions import UsersOwnQuestionView
from api.management.commands.generate_sample_data import (
    generate_users,
    generate_questions,
)


class TestUserOwnQuestions(TestCase):
    def setUp(self) -> None:
        self.factory = APIRequestFactory()
        self.API_VERSION = "v1"

        # getting a user and generating 10 questions
        self.user = generate_users(num_users=1)[0]
        self.questions = generate_questions(
            [self.user], questions_per_user=10
        )

    def test_own_questions(self):
        request_url = f"/api/{self.API_VERSION}/user/questions"

        # Creating request
        r = self.factory.get(request_url)

        # authenticating
        force_authenticate(r, user=self.user.user)

        # getting response
        view = UsersOwnQuestionView.as_view()  # must be a view
        response = view(r)  # executing view
        response.render()  # rendering response so we can read it
        data = json.loads(response.content)  # getting data  from response in JSON

        assert isinstance(data, list)
        for x in data:
            assert x['asker']['id'] == self.user.id
        assert len(data) == 10
