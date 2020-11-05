from rest_framework import viewsets

from .serializers import NoteSerializer
from .models import Note


class NoteViewSet(viewsets.ModelViewSet):
    queryset = Note.objects.all().order_by('title')
    serializer_class = NoteSerializer
