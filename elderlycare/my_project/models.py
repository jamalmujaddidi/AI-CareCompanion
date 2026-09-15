from django.db import models

# Create your models here.
class Login(models.Model):
    username=models.CharField(max_length=100)
    password=models.CharField(max_length=100)
    type=models.CharField(max_length=100)

class Doctor(models.Model):
    Doctor_name=models.CharField(max_length=100)
    gender=models.CharField(max_length=100)
    DOB=models.DateField()
    place = models.CharField(max_length=100)
    post= models.CharField(max_length=100)
    country= models.CharField(max_length=100)
    photo=models.CharField(max_length=100,default="")
    qualification = models.CharField(max_length=100)
    specialization= models.CharField(max_length=100)
    LOGIN= models.ForeignKey(Login,on_delete=models.CASCADE)
    status=models.CharField(max_length=100,default="")
    Email=models.CharField(max_length=100,default="")
    phone=models.CharField(max_length=100,default="")
    Experience=models.CharField(max_length=100,default="")

class Caretaker(models.Model):
    caretaker_Name=models.CharField(max_length=100)
    gender=models.CharField(max_length=100)
    phone=models.CharField(max_length=100)
    email=models.CharField(max_length=100,default="")
    photo=models.CharField(max_length=100,default="")
    pin = models.CharField(max_length=10,default="")
    DOB=models.DateField()
    place = models.CharField(max_length=100)
    country=models.CharField(max_length=100,default="")
    district=models.CharField(max_length=100,default="")
    post=models.CharField(max_length=100,default="")
    LOGIN = models.ForeignKey(Login,on_delete=models.CASCADE)


class Complaint(models.Model):
    Date=models.DateField()
    Status=models.CharField(max_length=100)
    complaint=models.CharField(max_length=100)
    reply= models.CharField(max_length=100)
    CARETAKER = models.ForeignKey(Caretaker, on_delete=models.CASCADE)

class Patient(models.Model):
    patient_Name=models.CharField(max_length=100)
    gender=models.CharField(max_length=100)
    DOB=models.DateField()
    place = models.CharField(max_length=100)
    Country = models.CharField(max_length=100)
    pin = models.BigIntegerField()
    district = models.CharField(max_length=100)
    phone=models.CharField(max_length=100,default="")
    email=models.CharField(max_length=100,default="")
    image=models.CharField(max_length=200,default="")
    LOGIN = models.ForeignKey(Login, on_delete=models.CASCADE)
    CARETAKER = models.ForeignKey(Caretaker, on_delete=models.CASCADE)

class Feedback(models.Model):
    Date=models.DateField(default="2001-01-01")
    Feedback=models.CharField(max_length=100)
    CARETAKER = models.ForeignKey(Caretaker, on_delete=models.CASCADE)


class Patient_report(models.Model):
    Date=models.CharField(max_length=100)
    report=models.CharField(max_length=500)
    PATIENT = models.ForeignKey(Patient, on_delete=models.CASCADE)


class Puzzle(models.Model):
    Photo=models.CharField(max_length=500)
    Title=models.CharField(max_length=100)
    level=models.CharField(max_length=100,default="")

class Word_List(models.Model):
    word=models.CharField(max_length=100)
    Level=models.CharField(max_length=100,default="")
    Rearrange_word=models.CharField(max_length=100,default="")


class Video(models.Model):
    Title=models.CharField(max_length=100)
    video=models.CharField(max_length=500)

class Patient_Activity(models.Model):
    PATIENT = models.ForeignKey(Patient, on_delete=models.CASCADE)
    Status=models.CharField(max_length=100)
    Date=models.CharField(max_length=100)
    type = models.CharField(max_length=100)

class Schedule(models.Model):
    From_time = models.TimeField()
    To_time = models.TimeField()
    Date = models.DateField()
    DOCTOR = models.ForeignKey(Doctor, on_delete=models.CASCADE)


class Appointment(models.Model):
    Date=models.DateField()
    Time=models.CharField(max_length=100)
    Status=models.CharField(max_length=100)
    SCHEDULE = models.ForeignKey(Schedule, on_delete=models.CASCADE)
    PATIENT = models.ForeignKey(Patient, on_delete=models.CASCADE)


class Fall_notification(models.Model):
    date=models.DateField()
    time=models.CharField(max_length=100)
    photo=models.CharField(max_length=100)
    notification = models.CharField(max_length=100)
    PATIENT = models.ForeignKey(Patient, on_delete=models.CASCADE)

class Photo(models.Model):
    date=models.DateField()
    time=models.TimeField()
    photo=models.CharField(max_length=500)
    title=models.CharField(max_length=100, default="")
    PATIENT = models.ForeignKey(Patient, on_delete=models.CASCADE)

class Pill_time(models.Model):
    time=models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    pill=models.CharField(max_length=100)
    PATIENT = models.ForeignKey(Patient, on_delete=models.CASCADE)

class Pill_notification(models.Model):
    time=models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    notification=models.CharField(max_length=100)
    PATIENT = models.ForeignKey(Patient, on_delete=models.CASCADE)


class Emotion(models.Model):
    date = models.DateField()
    name=models.CharField(max_length=100)
    PATIENT = models.ForeignKey(Patient, on_delete=models.CASCADE)

class Progress(models.Model):
    title = models.CharField(max_length=100)
    date = models.DateField()
    time = models.CharField(max_length=100)
    result = models.CharField(max_length=100)
    PATIENT = models.ForeignKey(Patient, on_delete=models.CASCADE)

class motion_task(models.Model):
    task_name=models.CharField(max_length=100)
    image=models.CharField(max_length=100)
    PATIENT = models.ForeignKey(Patient, on_delete=models.CASCADE)