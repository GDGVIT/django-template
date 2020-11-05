from django.db import models


class Note(models.Model):
    title = models.CharField(max_length=50)
    body = models.TextField()
    is_favorite = models.BooleanField(default=False)

    def __str__(self):
        return self.title
