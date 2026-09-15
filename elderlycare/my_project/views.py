import re

from django.core.files.storage import FileSystemStorage
from django.db.models import Sum
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect

# Create your views here.
from my_project.models import Login, Doctor, Patient_Activity, Caretaker, Complaint, Feedback, Patient, Puzzle, \
    Word_List, Video, Schedule, Appointment, Photo, Fall_notification, Pill_time, Emotion, Progress, motion_task


def logout(request):
    request.session['lid'] = ''

    return redirect("/my_project/login_get/")
def login_get(request):
    return render(request,"login_index.html")
def login_post(request):
    uname=request.POST['textfield']
    upassword=request.POST['textfield2']

    l=Login.objects.filter(username=uname,password=upassword)
    if l.exists():
        ll=Login.objects.get(username=uname,password=upassword)
        request.session['lid']=ll.id
        if ll.type=="Admin":
            return HttpResponse('''<script>alert("Login Successful");window.location='/my_project/Admin_home_get/'</script>''')
        elif ll.type=='doctor':
            return HttpResponse('''<script>alert("Login Successful");window.location='/my_project/doctor_home_page_get/'</script>''')

        else:
            return HttpResponse('''<script>alert("User Not Found");window.location='/my_project/login_get/'</script>''')


    return HttpResponse('ok')



def Change_password_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request,"Admin/change password.html")

def Change_password_post(request):
    Current_Password=request.POST['textfield']
    New_Password=request.POST['textfield2']
    Confirm_Password=request.POST['textfield3']
    lid=request.session['lid']
    c=Login.objects.filter(password=Current_Password,id=lid)
    if c.exists():
        c = Login.objects.get(password=Current_Password, id=lid)
        if New_Password==Confirm_Password:
            Login.objects.filter(id=lid).update(password=Confirm_Password)
            return HttpResponse('<script>alert("Password updated");window.location="/my_project/login_get/"</script>')
        else:
            return HttpResponse('<script>alert("Password mismatched");window.location="/my_project/Change_password/"</script>')
    else:
        return HttpResponse('<script>alert("Password mismatched");window.location="/my_project/Change_password/"</script>')




def Admin_home_get(request):
    if request.session['lid'] == '':
        return HttpResponse(
            '''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request,"Admin/home.html")

def add_caretaker_get(request):
    return render(request, "Admin/add caretaker.html")
def add_caretaker_post(request):
    name=request.POST['textfield']
    place=request.POST['textfield2']
    post=request.POST['textfield3']
    pin=request.POST['textfield4']
    Country=request.POST['textfield13']
    district=request.POST['textfield5']
    phone=request.POST['textfield6']
    email=request.POST['textfield7']
    dob=request.POST['textfield8']
    photo=request.FILES['textfield9']

    fs=FileSystemStorage()
    from datetime import datetime
    date=datetime.now().strftime('%Y%m%d-%H%M%S')+".jpg"
    fs.save(date,photo)
    path=fs.url(date)

    Gender=request.POST['gender']

    l=Login()
    l.username=email
    l.password=phone
    l.type='caretaker'
    l.save()



    z=Caretaker()
    z.caretaker_Name=name
    z.gender=Gender
    z.phone=phone
    z.email=email
    z.photo=path
    z.DOB=dob
    z.place=place
    z.country=Country
    z.district=district
    z.post=post
    z.pin=pin
    z.LOGIN=l
    z.save()


    return HttpResponse('''<script>alert("Information is added Successfully");window.location='/my_project/Admin_home_get/'</script>''')

def add_puzzle_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request, "Admin/add puzzle.html")
def add_puzzle_post(request):
    photo=request.FILES['textfield']
    title=request.POST['textfield2']
    level=request.POST['level']

    fs = FileSystemStorage()
    from datetime import datetime
    date = datetime.now().strftime('%Y%m%d-%H%M%S') + ".jpg"
    fs.save(date, photo)
    path = fs.url(date)

    p=Puzzle()
    p.Photo=path
    p.Title=title
    p.level=level
    p.save()

    return HttpResponse('''<script>alert("Puzzle is added Successfully");window.location='/my_project/add_puzzle_get/'</script>''')


def add_video_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request, "Admin/add video.html")
def add_video_post(request):
    title=request.POST['textfield']
    video=request.FILES['textfield1']

    fs = FileSystemStorage()
    from datetime import datetime
    date = datetime.now().strftime('%Y%m%d-%H%M%S') + ".mp4"
    fs.save(date, video)
    path = fs.url(date)

    v=Video()
    v.Title=title
    v.video=path
    v.save()


    return HttpResponse('''<script>alert("Video is added Successfully");window.location='/my_project/add_video_get/#ec'</script>''')

def add_word_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request, "Admin/add word.html")
def add_word_post(request):
    word=request.POST['textfield']
    level=request.POST['level']
    Rearrange_word=request.POST['textfield2']

    w=Word_List()
    w.word=word
    w.Level=level
    w.Rearrange_word=Rearrange_word
    w.save()

    return HttpResponse('''<script>alert("Word is added Successfully");window.location='/my_project/add_word_get/'</script>''')

# def change_password_get(request):
#     return render(request, "Admin/change password.html")
# def change_password_post(request):
#     current_password=request.POST['textfield']
#     new_password=request.POST['textfield2']
#     confirm_password=request.POST['textfield3']
#     return HttpResponse('ok')

def edit_caretaker_get(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    a=Caretaker.objects.get(id=id)
    return render(request, "Admin/edit caretaker.html",{'data': a})
def edit_caretaker_post(request):
    id=request.POST['id']
    name=request.POST['textfield']
    place= request.POST['textfield2']
    phone = request.POST['textfield3']
    email = request.POST['textfield4']
    post = request.POST['textfield5']
    pin = request.POST['textfield6']
    district= request.POST['textfield7']
    dob = request.POST['textfield8']
    country=request.POST['textfield13']
    gender=request.POST['gender']

    a=Caretaker.objects.get(id=id)

    if 'textfield9' in request.FILES:
        photo = request.FILES['textfield9']
        fs = FileSystemStorage()
        from datetime import datetime
        date = datetime.now().strftime('%Y%m%d-%H%M%S') + ".jpg"
        fs.save(date, photo)
        path = fs.url(date)
        a.photo=path
        a.save()


    a.caretaker_Name=name
    a.phone=phone
    a.email=email
    a.pin=pin
    a.DOB=dob
    a.place=place
    a.country=country
    a.district=district
    a.post=post
    a.gender=gender
    a.save()

    return HttpResponse(
        '''<script>alert("Information is Changed Successfully");window.location='/my_project/view_caretaker_get/'</script>''')


def edit_video_get(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    v=Video.objects.get(id=id)
    return render(request, "Admin/edit video.html", {'data' :v})
def edit_video_post(request):
    title=request.POST['textfield']
    id = request.POST['id']

    v=Video.objects.get(id=id)

    if 'textfield1' in request.FILES:
        video = request.FILES['textfield1']
        if video != "":
            fs = FileSystemStorage()
            from datetime import datetime
            date = datetime.now().strftime('%Y%m%d-%H%M%S') + ".mp4"
            fs.save(date, video)
            path = fs.url(date)
            v.video = path
    v.Title=title
    v.save()

    return HttpResponse(
        '''<script>alert("Video is Changed Successfully");window.location='/my_project/view_video_get/#ec'</script>''')


def edit_word_get(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    w=Word_List.objects.get(id=id)
    return render(request, "Admin/edit word.html", {'data': w})
def edit_word_post(request):
    word=request.POST['textfield']
    level=request.POST['level']
    rearrange_word=request.POST['textfield2']
    id=request.POST['id']

    w=Word_List.objects.get(id=id)
    w.word=word
    w.Level=level
    w.Rearrange_word=rearrange_word
    w.save()
    return HttpResponse(
        '''<script>alert("Word Edited Successfully");window.location='/my_project/view_word_get/#ec'</script>''')

def edit_puzzle_get(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    p=Puzzle.objects.get(id=id)
    return render(request, "Admin/edit puzzle.html",{'data' : p})
def edit_puzzle_post(request):
    title=request.POST['textfield2']
    level=request.POST['level']
    id=request.POST['id']

    p=Puzzle.objects.get(id=id)

    if 'textfield' in request.FILES:
        photo = request.FILES['textfield']
        if photo!="":
            fs = FileSystemStorage()
            from datetime import datetime
            date = datetime.now().strftime('%Y%m%d-%H%M%S') + ".jpg"
            fs.save(date, photo)
            path = fs.url(date)
            p.Photo = path

    p.Title=title
    p.level=level
    p.save()

    return HttpResponse('''<script>alert("Puzzle Edited Successfully");window.location='/my_project/view_puzzle_get/'</script>''')



def send_reply_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request, "Admin/send reply.html")
def send_reply_post(request):
    reply=request.POST['textfield']
    return HttpResponse('ok')

def View_doctor_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    a=Doctor.objects.filter(status='pending')
    return render(request, "Admin/verify doctor.html",{'data':a})
def View_doctor_post(request):
    search=request.POST['textfield']
    a = Doctor.objects.filter(status='pending',Doctor_name__icontains=search)
    return render(request, "Admin/verify doctor.html",{'data':a})



def accept_doctor(request,id):
    a = Doctor.objects.filter(LOGIN_id=id).update(status='Accepted')
    Login.objects.filter(id=id).update(type='doctor')
    return HttpResponse('''<script>alert("Doctor Is Accepted");window.location='/my_project/View_doctor_get/'</script>''')

def reject_doctor(request,id):
    a= Doctor.objects.filter(LOGIN=id).update(status='Rejected')
    return HttpResponse('''<script>alert("Doctor Is Rejected");window.location='/my_project/View_doctor_get/'</script>''')


def view_accepted_doctor_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    a=Doctor.objects.filter(status='Accepted')
    return render(request,"Admin/view accepted doctors.html",{'data': a})

def view_accepted_doctor_post(request):
    search=request.POST['textfield']
    a = Doctor.objects.filter(status='Accepted',Doctor_name__icontains=search)
    return render(request, "Admin/view accepted doctors.html", {'data': a})

def view_rejected_doctor_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    a=Doctor.objects.filter(status='Rejected')
    return render(request, "Admin/view rejected doctors.html",{'data':a})

def view_rejected_doctor_post(request):
    Search=request.POST['textfield']
    a = Doctor.objects.filter(status='Rejected',Doctor_name__icontains=Search)
    return render(request, "Admin/view rejected doctors.html", {'data': a})


def view_activity_of_patient_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    a=Patient_Activity.objects.all()
    return render(request, "Admin/view activity of patient.html",{'data':a})
def view_activity_of_patient_post(request):
    Search=request.POST['textfield']
    return HttpResponse('ok')

def view_caretaker_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    a=Caretaker.objects.all()
    return render(request, "Admin/view caretaker.html",{'data': a})
def view_caretaker_post(request):
    Search=request.POST['textfield']
    a = Caretaker.objects.filter(caretaker_Name__icontains=Search)
    return render(request, "Admin/view caretaker.html", {'data': a})


def delete_caretaker_get(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    Caretaker.objects.filter(LOGIN_id=id).delete()
    Login.objects.filter(id=id).delete()
    return redirect('/my_project/view_caretaker_get/')




def view_complaint_get(request):
    a=Complaint.objects.all()
    return render(request,"Admin/view complaint and send reply.html",{'data' :a})
def view_complaint_post(request):
    From=request.POST['textfield']
    To=request.POST['textfield2']
    a = Complaint.objects.filter(Date__range=[From,To])
    return render(request,"Admin/view complaint and send reply.html",{'data' :a})


def view_sendreply_get(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    a=Complaint.objects.get(id=id)
    return render(request,"Admin/send reply.html",{'data' :a})
def view_sendreply_post(request):
    From=request.POST['id']
    To=request.POST['textfield']
    a = Complaint.objects.filter(id=From).update(reply=To,Status='replied')
    return HttpResponse ('''<script>alert("Replied");window.location='/my_project/view_complaint_get/'</script>''')






def view_feedback_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    a=Feedback.objects.all()
    return render(request,"Admin/view Feedback.html",{'data':a })

def view_feedback_post(request):
    From=request.POST['textfield']
    To=request.POST['textfield2']
    a=Feedback.objects.filter(Date__range=[From,To])
    return render(request,"Admin/view Feedback.html",{'data':a })




def view_patient_report_get(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    data=Progress.objects.filter(PATIENT_id=id)
    request.session['a_pid']=id
    return render(request, "Admin/view patient reprt.html",{'data':data})
def view_patient_report_post(request):
    From_date=request.POST['textfield']
    To_date=request.POST['textfield2']
    data = Progress.objects.filter(PATIENT_id=request.session['a_pid'],date__range=[From_date,To_date])
    return render(request, "Admin/view patient reprt.html", {'data': data})




def view_patient_get(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    a=Patient.objects.filter(CARETAKER_id=id)
    return render(request, "Admin/view patient.html",{'data': a})
def view_patient_post(request):
    Search=request.POST['textfield']
    a=Patient.objects.filter(patient_Name__icontains=Search)
    return render(request, "Admin/view patient.html",{'data': a})




def view_puzzle_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    p=Puzzle.objects.all()
    return render(request,"Admin/view puzzle.html",{'data':p})
def view_puzzle_post(request):
    Search=request.POST['textfield']
    p=Puzzle.objects.filter(Title__icontains=Search)
    return render(request, "Admin/view puzzle.html", {'data': p})


def delete_Puzzle_get(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    Puzzle.objects.filter(id=id).delete()
    return redirect('/my_project/view_puzzle_get/')





def view_video_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    v=Video.objects.all()
    return render(request, "Admin/view video.html", {'data':v})
def view_video_post(request):
    Search=request.POST['textfield']
    v=Video.objects.filter(Title__icontains=Search)
    return render(request, "Admin/view video.html", {'data':v})

def delete_Video_get(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    Video.objects.filter(id=id).delete()
    return redirect('/my_project/view_video_get/')


   # return HttpResponse('ok')

def view_word_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    w=Word_List.objects.all()
    return render(request, "Admin/view word.html",{'data': w})

def view_word_post(request):
    Search=request.POST['textfield']
    w=Word_List.objects.filter(word__icontains=Search)
    return render(request, "Admin/view word.html",{'data': w})

def delete_word_list_get(request,id):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    Word_List.objects.filter(id=id).delete()
    return redirect('/my_project/view_word_get/#ec')


def view_appointment_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request,"Admin/view appointment.html")
def view_appointment_post(request):
    Search=request.POST['textfield']
    return HttpResponse('ok')

def view_schedule_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request,"Admin/view schedule.html")
def view_schedule_post(request):
    From=request.POST['textfield']
    To=request.POST['textfield2']
    return HttpResponse('ok')

def view_pill_time_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request,"Admin/view pill time.html")
def view_pill_time_post(request):
    From=request.POST['textfield']
    To=request.POST['textfield2']
    return HttpResponse('ok')

def view_pill_notification_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request,"Admin/view pill notification.html")
def view_pill_notification_post(request):
    From=request.POST['textfield']
    To=request.POST['textfield2']
    return HttpResponse('ok')

def view_photo_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request,"Admin/view photo.html")
def view_photo_post(request):
    Search=request.POST['textfield']
    return HttpResponse('ok')

def view_fall_notification_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request,"Admin/view fall notification.html")

def view_fall_notification_post(request):
    Forom=request.POST['textfield']
    To=request.POST['textfield2']
    return HttpResponse('ok')

def view_emotion_get(request):
    if request.session['lid'] == '':
        return HttpResponse('''<script>alert('session expired...please login!!!');window.location='/my_project/login_get/'</script>''')
    return render(request,"Admin/view emotion.html")
def view_emotion_post(request):
    Search=request.POST['textfield']
    return HttpResponse('ok')


#==========Doctor==========

def doctor_home_page_get(request):
    return render(request,'Doctor/home.html')


def doc_registration_get(request):
    return render(request,"Doctor/signup index.html")
def doc_registration_post(request):
    name=request.POST['textfield']
    gender=request.POST['RadioGroup1']
    DOB=request.POST['textfield2']
    place=request.POST['textfield3']
    post=request.POST['textfield4']
    country=request.POST['textfield5']
    phone=request.POST['textfield6']
    email=request.POST['textfield7']
    qualification=request.POST['textfield8']
    specialization=request.POST['textfield9']
    password=request.POST['textfield10']
    confirm_password=request.POST['textfield11']
    experience=request.POST['textfield13']
    photo=request.FILES['textfield19']

    if password==confirm_password:


        l=Login()

        l = Login()
        l.username = email
        l.password = confirm_password
        l.type = 'pending'
        l.save()
        d=Doctor()
        d.Doctor_name=name
        d.gender=gender
        d.DOB=DOB
        d.place=place
        d.post=post
        d.country=country
        d.phone=phone
        d.Email=email
        d.qualification=qualification
        d.specialization=specialization
        d.Experience=experience

        fs = FileSystemStorage()
        from datetime import datetime
        date = datetime.now().strftime('%Y%m%d-%H%M%S') + ".jpg"
        fs.save(date, photo)
        path = fs.url(date)
        d.photo = path
        d.status='pending'
        d.LOGIN=l
        d.save()
        return HttpResponse ('''<script>alert("Successfully Rigisterd ");window.location='/my_project/doc_registration_get/'</script>''')
    else:
        return HttpResponse ('''<script>alert("Password must be Same  ");window.location='/my_project/doc_registration_get/'</script>''')




def doc_add_schedule_get(request):
    return render(request,"Doctor/add schedule.html")
def doc_add_schedule_post(request):
    date=request.POST['textfield2']
    from_time=request.POST['textfield4']
    to_time=request.POST['textfield3']

    s=Schedule()
    s.Date=date
    s.From_time=from_time
    s.To_time=to_time
    s.DOCTOR=Doctor.objects.get(LOGIN_id=request.session['lid'])
    s.save()

    return HttpResponse(
        '''<script>alert("New Schedule is added ");window.location='/my_project/doc_add_schedule_get/#ec'</script>''')


def doc_change_password_get(request):
    return render(request,"Doctor/change password.html")
def doc_change_password_post(request):
    Current_Password = request.POST['textfield']
    New_Password = request.POST['textfield2']
    Confirm_Password = request.POST['textfield3']
    lid = request.session['lid']
    c = Login.objects.filter(password=Current_Password, id=lid)
    if c.exists():
        c = Login.objects.get(password=Current_Password, id=lid)
        if New_Password == Confirm_Password:
            Login.objects.filter(id=lid).update(password=Confirm_Password)
            return HttpResponse('<script>alert("Password updated");window.location="/my_project/login_get/"</script>')
        else:
            return HttpResponse(
                '<script>alert("Password mismatched");window.location="/my_project/doc_change_password_get/"</script>')
    else:
        return HttpResponse(
            '<script>alert("Password mismatched");window.location="/my_project/doc_change_password_get/"</script>')


def doc_chat_with_pathient_get(request):
    return render(request,"Doctor/chat with patient.html")
def doc_chat_with_pathient_post(request):
    return HttpResponse('ok')

def doc_edit_profile_get(request):
    data=Doctor.objects.get(LOGIN_id=request.session['lid'])
    return render(request,"Doctor/edit profile.html",{'data':data})
def doc_edit_profile_post(request):
    name = request.POST['textfield']
    gender = request.POST['RadioGroup1']
    DOB = request.POST['textfield2']
    place = request.POST['textfield3']
    post = request.POST['textfield4']
    country = request.POST['textfield5']
    phone = request.POST['textfield6']
    email = request.POST['textfield7']
    qualification = request.POST['textfield8']
    specialization = request.POST['textfield9']
    experience = request.POST['textfield18']

    d = Doctor.objects.get(LOGIN_id=request.session['lid'])
    if 'textfield19' in request.FILES:
        photo = request.FILES['textfield19']
        if photo !="":
            fs = FileSystemStorage()
            from datetime import datetime
            date = datetime.now().strftime('%Y%m%d-%H%M%S') + ".jpg"
            fs.save(date, photo)
            path = fs.url(date)
            d.photo = path

    d.Doctor_name = name
    d.gender = gender
    d.DOB = DOB
    d.place = place
    d.post = post
    d.country = country
    d.phone = phone
    d.Email = email
    d.qualification = qualification
    d.specialization = specialization
    d.Experience = experience
    d.save()
    return HttpResponse(
        '''<script>alert("The page is Edited ");window.location='/my_project/doc_view_profile_get/#ec'</script>''')




def doc_edit_scedule_get(request,id):
    s= Schedule.objects.get(id=id)
    return render(request,"Doctor/edit schedule.html",{'data': s})
def doc_edit_schedule_post(request):
    From_time=request.POST['textfield']
    to_time=request.POST['textfield3']
    date=request.POST['textfield4']
    id=request.POST['id']

    s= Schedule.objects.get(id=id)
    s.From_time=From_time
    s.To_time=to_time
    s.Date=date
    s.save()
    return HttpResponse(
    '''<script>alert("The page is Edited ");window.location='/my_project/doc_view_schedule_get/#ec'</script>''')

def delete_schedule_get(request,id):
    Schedule.objects.filter(id=id).delete()
    return redirect('/my_project/doc_view_schedule_get/')





def doc_view_activity_of_patient_get(request,id):
    data=Progress.objects.filter(PATIENT_id=id)
    request.session['p_pid']=id
    return render(request,"Doctor/view activity of patient.html",{'data': data})


def doc_view_activity_of_patient_post(request):
    fdate = request.POST['textfield']
    tdate = request.POST['textfield2']
    data = Progress.objects.filter(PATIENT_id=request.session['p_pid'],date__range=[fdate,tdate])
    return render(request, "Doctor/view activity of patient.html", {'data': data})



def doc_view_appointment_get(request,id):
    a=Appointment.objects.filter(SCHEDULE_id=id)
    request.session['sid']=id
    return render(request,"Doctor/view appointment.html",{'data':a})
def doc_view_appointment_post(request):
    Search=request.POST['textfield']
    a = Appointment.objects.filter(SCHEDULE_id=request.session['sid'],PATIENT__patient_Name__icontains=Search)
    return render(request, "Doctor/view appointment.html", {'data': a})


def doc_view_fall_notification_get(request):
    d=Fall_notification.objects.all()
    return render(request,"Doctor/view fall notification.html",{'data':d})

def doc_view_fall_notification_post(request):
    return HttpResponse('ok')



def doc_view_patient_get(request):
    # Get all appointments for the logged-in doctor
    appointments = Appointment.objects.filter(SCHEDULE__DOCTOR__LOGIN_id=request.session['lid'])

    # Use a set to track unique patient IDs
    unique_patients = set()
    unique_patient_data = []

    for app in appointments:
        if app.PATIENT.id not in unique_patients:
            unique_patients.add(app.PATIENT.id)
            unique_patient_data.append(app.PATIENT)

    return render(request, "Doctor/view patient.html", {'patients': unique_patient_data})


# def doc_view_patient_get(request):
#     data=Appointment.objects.filter(SCHEDULE__DOCTOR__LOGIN_id=request.session['lid'])
#
#     return render(request,"Doctor/view patient.html")
def doc_view_patient_post(request):
    search=request.POST['textfield']

    appointments = Appointment.objects.filter(SCHEDULE__DOCTOR__LOGIN_id=request.session['lid'],PATIENT__patient_Name__icontains=search)

    # Use a set to track unique patient IDs
    unique_patients = set()
    unique_patient_data = []

    for app in appointments:
        if app.PATIENT.id not in unique_patients:
            unique_patients.add(app.PATIENT.id)
            unique_patient_data.append(app.PATIENT)

    return render(request, "Doctor/view patient.html", {'patients': unique_patient_data})

def doc_view_profile_get(request):
    data=Doctor.objects.get(LOGIN_id=request.session['lid'])
    return render(request,"Doctor/view profile.html",{'data' : data})
def doc_view_profile_post(request):
    return HttpResponse('ok')

def doc_view_schedule_get(request):
    s=Schedule.objects.filter(DOCTOR__LOGIN_id=request.session['lid'])
    print(s)
    return render(request,"Doctor/view schedule.html",{'data': s})
def doc_view_schedule_post(request):
    fdate=request.POST['textfield']
    tdate=request.POST['textfield2']
    print(request.POST)
    s=Schedule.objects.filter(DOCTOR__LOGIN_id=request.session['lid'],Date__range=[fdate,tdate])
    return render(request, "Doctor/view schedule.html", {'data': s})



#=====================caretaker===================


def and_login_post(request):
    u=request.POST['user_name']
    p=request.POST['password']

    l = Login.objects.filter(username=u, password=p)
    if l.exists():
        ll = Login.objects.get(username=u, password=p)
        if ll.type == "caretaker":
            return JsonResponse ({'status':'ok','type':ll.type,'lid':ll.id})
        elif ll.type == 'patient':
            return JsonResponse({'status':'ok','type':ll.type,'lid':ll.id})

        else: JsonResponse({'status':'no'})
    else:
        return JsonResponse({'status': 'no'})




def caretaker_change_password_post(request):
    c=request.POST['current_password']
    n= request.POST['new_password']
    p= request.POST['confirm_password']
    lid=request.POST['lid']

    cc=Login.objects.filter(password=c,id=lid)
    if cc.exists():
        if n==p:
            Login.objects.filter(id=lid).update(password=p)
            return JsonResponse({'status':'ok'})
        else:
            return JsonResponse({'status':'no'})
    else:
        return JsonResponse({'status':'no'})




def caretaker_view_proile(request):
    lid = request.POST['lid']
    v=Caretaker.objects.get(LOGIN_id=lid)
    return JsonResponse({'status': 'ok','name':v.caretaker_Name,
                         'gender':v.gender,'phone':v.phone,
                         'email':v.email, 'photo': v.photo,
                         'pin': v.pin, 'Dob': v.DOB,
                         'place': v.place, 'country': v.country,
                         'district': v.district, 'post': v.post,})


                #================done




def caretaker_add_patient_post(request):
    lid = request.POST['lid']
    n=request.POST['patient_Name']
    g=request.POST['gender']
    d=request.POST['DOB']
    p=request.POST['place']
    c=request.POST['Country']
    pin=request.POST['pin']
    dis=request.POST['district']
    ph=request.POST['phone']
    em=request.POST['email']
    im=request.POST['image']


    from datetime import datetime
    date=datetime.now().strftime('%Y%m%d-%H%M%S')+'.jpg'
    import base64
    a=base64.b64decode(im)
    fh=open('C:\\Users\\user\\PycharmProjects\\elderlycare\\media\\user\\'+date,'wb')
    path='/media/user/'+date
    fh.write(a)
    fh.close()


    l=Login()
    l.username=em
    l.password=ph
    l.type='patient'
    l.save()

    pp=Patient()
    pp.patient_Name=n
    pp.gender=g
    pp.DOB=d
    pp.place=p
    pp.Country=c
    pp.pin=pin
    pp.district=dis
    pp.phone=ph
    pp.email=em
    pp.image=path
    pp.LOGIN=l
    pp.CARETAKER=Caretaker.objects.get(LOGIN_id=lid)
    pp.save()
    return JsonResponse({'status':'ok'})
#===

def caretaker_delete_patient_post(request):
    id = request.POST['id1']
    print(id)

    Patient.objects.get(LOGIN_id=id).delete()
    Login.objects.get(id=id).delete()


    return JsonResponse({'status':'ok'})


def caretaker_view_patient_post(request):
    lid = request.POST['lid']
    l=[]
    p=Patient.objects.filter(CARETAKER__LOGIN_id=lid)
    for i in p:
        l.append({
            'id':i.id,
            'id1':i.LOGIN.id,
            'patient_Name':i.patient_Name,
            'gender':i.gender,
            'DOB':i.DOB,
            'place':i.place,
            'Country': i.Country,
            'pin': i.pin,
            'district': i.district,
            'phone': i.phone,
            'email': i.email,
            'image':i.image,
        })
    print(l)

    return JsonResponse({'status':'ok','data':l})

def caretaker_view_patient_getss(request):
    pid = request.POST['pid']
    print("pid",pid)
    i = Patient.objects.get(id=pid)
    print()
    return JsonResponse({'status': 'ok','patient_Name': i.patient_Name,
            'gender': i.gender,
            'DOB': i.DOB,
            'place': i.place,
            'Country': i.Country,
            'pin': i.pin,
            'district': i.district,
            'phone': i.phone,
            'email': i.email,
            'image': i.image,})





def careteker_edit_patient_post(request):
    id=request.POST['pid']
    n = request.POST['patient_Name']
    g = request.POST['gender']
    d = request.POST['DOB']
    p = request.POST['place']
    c = request.POST['Country']
    pin = request.POST['pin']
    dis = request.POST['district']
    ph = request.POST['phone']
    em = request.POST['email']
    im = request.POST['image']


    # l = Login()
    # l.username = em
    # l.password = ph
    # l.type = 'patient'
    # l.save()

    pp = Patient.objects.get(id=id)
    if len(im)>0:
        from datetime import datetime
        date = datetime.now().strftime('%Y%m%d-%H%M%S') + '.jpg'
        import base64
        a = base64.b64decode(im)
        fh = open('C:\\Users\\user\\PycharmProjects\\elderlycare\\media\\user\\' + date, 'wb')
        path = '/media/user/' + date
        fh.write(a)
        fh.close()
        pp.image = path

    pp.patient_Name = n
    pp.gender = g
    pp.DOB = d
    pp.place = p
    pp.Country = c
    pp.pin = pin
    pp.district = dis
    pp.phone = ph
    pp.email = em
    pp.save()
    return JsonResponse({'status': 'ok'})


           #======done

def caretaker_view_doctor_post(request):
    s=Doctor.objects.filter(status='Accepted')
    l=[]
    for i in s:
        l.append({
            'id':i.id,
            'Doctor_name':i.Doctor_name,
            'gender':i.gender,
            'place':i.place,
            'photo':i.photo,
            'qualification':i.qualification,
            'specialization':i.specialization,
            'experience':i.Experience,
            'phone':i.phone,
            'email':i.Email,
        })
    return JsonResponse ({'status':'ok','data':l})







def caretaker_view_schedule_post(request):
    id=request.POST['id']
    pid=request.POST['pid']
    s=Schedule.objects.filter(DOCTOR_id=id)



    l=[]
    for i in s:
        if Appointment.objects.filter(SCHEDULE_id=i.id,PATIENT_id=pid).exists():
            l.append({
                'id': i.id,
                'start': i.From_time,
                'end': i.To_time,
                'date': i.Date,
                'yes':'yes'

            })
        else:
            l.append({
                'id': i.id,
                'start': i.From_time,
                'end': i.To_time,
                'date': i.Date,
                'yes': 'no'

            })
    # print(l)
    return JsonResponse ({'status:': 'ok','data':l})




def caretaker_make_appointment_post(request):
    id=request.POST['id']
    pid=request.POST['pid']
    from datetime import datetime

    a=Appointment()
    from xmlrpc.client import DateTime
    a.Date=datetime.now().date()
    a.Time=datetime.now().time()
    a.Status='pending'
    a.SCHEDULE=Schedule.objects.get(id=id)
    a.PATIENT=Patient.objects.get(id=pid)
    a.save()
    return JsonResponse ({'status': 'ok'})



def caretaker_view_previous_booking_post(request):
    pid=request.POST['pid']
    from datetime import datetime
    l=[]
    p=Appointment.objects.filter(PATIENT_id=pid,SCHEDULE__Date__lt=datetime.now().today())

    for i in p:
        l.append({
            'id': i.id,
            'Date': i.Date,
            'Time': i.Time,
            's_stime':i.SCHEDULE.From_time,
            's_etime':i.SCHEDULE.To_time,
            's_date':i.SCHEDULE.Date,
            'dname':i.SCHEDULE.DOCTOR.Doctor_name,
            'dqualification':i.SCHEDULE.DOCTOR.qualification,
            'dphone':i.SCHEDULE.DOCTOR.phone,
        })

    # print(l)
    return JsonResponse ({'status':'ok', 'data':l})


def caretaker_add_photo_post(request):
    pid=request.POST['pid']
    photo=request.POST['photo']
    title=request.POST['title']
    from datetime import datetime
    date = datetime.now().strftime('%Y%m%d-%H%M%S') + '.jpg'
    import base64
    a = base64.b64decode(photo)
    fh = open('C:\\Users\\user\\PycharmProjects\\elderlycare\\media\\photo\\' + date, 'wb')
    path = '/media/photo/' + date
    fh.write(a)
    fh.close()

    p=Photo()
    p.date=datetime.now().today()
    p.time=datetime.now().time()
    p.photo=path
    p.title=title
    p.PATIENT=Patient.objects.get(id=pid)

    p.save()

    return JsonResponse ({'status': 'ok'})

def caretaker_add_task_post(request):
    pid=request.POST['pid']
    task_name=request.POST['task_name']
    image=request.POST['image']


    from datetime import datetime
    date = datetime.now().strftime('%Y%m%d-%H%M%S') + '.jpg'
    import base64
    a = base64.b64decode(image)
    fh = open('C:\\Users\\user\\PycharmProjects\\elderlycare\\media\\photo\\' + date, 'wb')
    path = '/media/photo/' + date
    fh.write(a)
    fh.close()

    p = motion_task()

    p.image = path
    p.task_name = task_name
    p.PATIENT = Patient.objects.get(id=pid)

    p.save()

    return JsonResponse({'status':'ok'})






def caretaker_view_photo_post(request):
    pid=request.POST['pid']
    l=[]
    p=Photo.objects.filter(PATIENT_id=pid)
    for i in p:
        l.append({
            'id': i.id,
            'date': i.date,
            'time': i.time,
            'photo':i.photo,
            'title': i.title
        })

    return JsonResponse ({'status': 'ok','data': l})


def caretaker_view_task_post(request):
    pid=request.POST['pid']
    l=[]
    p=motion_task.objects.filter(PATIENT_id=pid)
    for i in p:
        l.append({
            'id': i.id,
            'task_name': i.task_name,
            'image': i.image,

        })

    return JsonResponse ({'status': 'ok','data': l})



def caretaker_delete_photo_post(request):
    id=request.POST['id']
    Photo.objects.filter(id=id).delete()
    return JsonResponse ({'status': 'ok'})

def caretaker_delete_task_post(request):
    id=request.POST['id']
    motion_task.objects.filter(id=id).delete()
    return JsonResponse ({'status': 'ok'})






def caretaker_view_fall_notification_and_its_photo_post(request):
    fid=request.POST['fid']
    l = []
    f=Fall_notification.objects.filter(PATIENT_id=fid)

    for i in f:
        l.append({
            'id': i.id,
            'date': i.date,
            'time': i.time,
            'photo': i.photo,
            'notification': i.notification,
        })

    return JsonResponse({'status': 'ok'})




def caretaker_add_pill_time_post(request):
    pid=request.POST['pid']
    time=request.POST['time']
    date=request.POST['date']
    pill=request.POST['pill']
    p=Pill_time()
    p.time=time
    p.date=date
    p.pill=pill
    p.PATIENT=Patient.objects.get(id=pid)
    p.save()

    return JsonResponse ({'status': 'ok'})


def caretaker_view_pill_time_post(request):
    pid=request.POST['pid']
    print(pid)
    l = []
    p = Pill_time.objects.filter(PATIENT_id=pid)

    for i in p:
        l.append({
            'id': i. id,
            'time': i.time,
            'date': i.date,
            'pill': i.pill,
        })
    return JsonResponse({'status': 'ok', 'data': l})


def delete_pill_post(request):
    id=request.POST['id']
    Pill_time.objects.get(id=id).delete()
    return JsonResponse({'status': 'ok'})



def caretaker_edit_pill_time_post(request):
    id=request.POST['id']
    return JsonResponse ({})


def caretaker_view_fall_notification_post(request):
    fid = request.POST['fid']
    l = []
    f =Fall_notification.objects.filter(PATIENT_id=fid)

    for i in f:
        l.append({
            'id': i.id,
            'date': i.date,
            'time': i.time,
            'photo': i.photo,
            'notification': i.notification,
        })

    return JsonResponse ({})


def caretaker_view_emotion_graph_of_patient_post(request):
    id=request.POST['id']
    e=Emotion.objects.get(id=id)
    return JsonResponse ({'status': "ok", 'name': e.name})


def caretaker_send_complaints_post(request):
    lid=request.POST['lid']
    complaint=request.POST['complaint']
    from datetime import datetime
    c=Complaint()
    c.Date=datetime.now().date()
    c.Status='pending'
    c.complaint=complaint
    c.reply='pending'
    c.CARETAKER=Caretaker.objects.get(LOGIN_id=lid)
    c.save()
    return JsonResponse ({'status': 'ok',})



def caretaker_view_reply_post(request):
    lid=request.POST['lid']
    l = []
    r = Complaint.objects.filter(CARETAKER__LOGIN_id=lid)

    for i in r:
        l.append({
            'id': i.id,
            'date': i.Date,
            'status': i.Status,
            'complaint': i.complaint,
            'reply': i.reply,

        })

    return JsonResponse({'status': 'ok','data':l})




def caretaker_monitor_activity_of_patient_post(request):
        id = request.POST['id']
        p=Patient_Activity.objects.get(id=id)
        return JsonResponse ({'status': 'ok', 'Status': p.Status,
                              'date': p.Date, 'type': p.type})




def caretaker_send_Feedback_post(request):
        lid=request.POST['lid']
        feedback=request.POST['Feedback']
        from datetime import datetime
        f=Feedback()
        f.Date = datetime.now().date()
        f.Feedback = feedback
        f.CARETAKER=Caretaker.objects.get(LOGIN_id=lid)
        f.save()
        return JsonResponse ({'status': 'ok'})


def caretaker_view_Feedback_post(request):
    l = []
    a= Feedback.objects.all()
    for i in a:
        l.append({
            'id': i.id,
           'Date':i.Date,
            'Feedback': i.Feedback

                    })

    return JsonResponse({'status': 'ok','data':l })


def caretaker_view_patient_activity_post(request):
    pid=request.POST['pid']
    l=[]
    p=Progress.objects.filter(PATIENT_id=pid)
    for i in p:
        l.append({

            'id': i.id,
            'title': i.title,
            'date': i.date,
            'time': i.time,
            'result': i.result,
        })

    return JsonResponse({'status': 'ok', 'data': l})








#########################Patient#############################


def patient_change_password_post(request):
    c = request.POST['current_password']
    n = request.POST['new_password']
    p = request.POST['confirm_password']
    lid = request.POST['lid']

    cc = Login.objects.filter(password=c, id=lid)
    if c.exists():
        ccc = Login.objects.get(password=c, id=lid)
        if n == p:
            Login.objects.filter(id=lid).update(password=p)
            return JsonResponse({'status': 'ok'})
        else:
            return JsonResponse({'status': 'no'})
    else:
        return JsonResponse({'status': 'no'})




def patient_view_profile_post(request):
    lid = request.POST['lid']
    v = Patient.objects.get(LOGIN_id=lid)
    return JsonResponse({'status': 'ok', 'name': v.patient_Name,
                         'gender': v.gender, 'phone': v.phone,
                         'email': v.email, 'image': v.image,
                         'pin': v.pin, 'Dob': v.DOB,
                         'place': v.place, 'country': v.Country,
                         'district': v.district, })


def patient_emotion_recognition_post(request):
    return JsonResponse({'status': 'ok'})




def patient_view_puzzle_post(request):
    l = []
    a = Puzzle.objects.all()
    for i in a:
        l.append({
            'id': i.id,
            'Photo': i.Photo,
            'Title': i.Title,
            'level': i.level,

        })

    return JsonResponse({'status': 'ok', 'data': l})


def patient_view_videos_post(request):
    l = []
    a = Video.objects.all()
    for i in a:
        l.append({
            'id': i.id,
            'Title': i.Title,
            'video': i.video,

        })

    return JsonResponse({'status': 'ok', 'data': l})






def patient_word_pronounciation_post(request):
    return JsonResponse({'status': 'ok'})




def patient_object_recognition_post(request):
    lid=request.POST['lid']
    l=[]
    a = Photo.objects.filter(PATIENT__LOGIN=lid)
    for i in a:
        l.append({
            'id': i.id,
            'date': i.date,
            'time': i.time,
            'photo': i.photo,
            'title': i.title,

        })
    print(l)
    return JsonResponse({'status': 'ok', 'data': l})








def patient_view_reminder_post(request):
    lid = request.POST['lid']
    l = []
    a = Pill_time.objects.filter(PATIENT__LOGIN=lid)
    for i in a:
        l.append({
            'id': i.id,
            'time': i.time,
            'date': i.date,
            'pill': i.pill,


        })

    return JsonResponse({'status': 'ok', 'data': l})



def patient_recognize_person_post(request):
    return JsonResponse({'status': 'ok'})




def patient_handwriting_analysis_post(request):
    return JsonResponse({'status': 'ok'})


def patient_progress_post(request):
    lid = request.POST['lid']
    print(lid)
    time=request.POST['progress']
    result=request.POST['res']
    from datetime import datetime
    p=Progress()
    p.date = datetime.now().date()
    p.title='puzzle'
    p.result=result
    p.time=time
    p.PATIENT = Patient.objects.get(LOGIN_id=lid)
    p.save()
    return JsonResponse({'status': 'ok'})
def patient_progress_fail(request):
    lid = request.POST['lid']
    print(lid)
    time=request.POST['progress']
    result=request.POST['res']
    from datetime import datetime
    p=Progress()
    p.date = datetime.now().date()
    p.title='puzzle'
    p.result='Fail'
    p.time=time
    p.PATIENT = Patient.objects.get(LOGIN_id=lid)
    p.save()
    return JsonResponse({'status': 'ok'})


def patient_view_Word_List_post(request):
    lvl=request.POST['lvl']
    l = []
    data=Word_List.objects.filter(Level=lvl)
    for i in data:
        l.append({
            'id': i.id,
            'word': i.word,
            'Level': i.Level,
            'Rearrange_word': i.Rearrange_word,

        })

    return JsonResponse({'status': 'ok', 'data': l})

def ana_progress_solve(request):
    lid=request.POST['lid']
    time=request.POST['time']
    qa = Progress()
    qa.title = 'Anagram'
    qa.result = 'solved'
    qa.time=time
    qa.PATIENT = Patient.objects.get(LOGIN=lid)
    from datetime import datetime
    qa.date = datetime.now().date()
    qa.save()
    return JsonResponse({'status': 'ok'})


def ana_progress_fail(request):
    lid = request.POST['lid']
    time=request.POST['time']
    qa = Progress()
    qa.title = 'Anagram'
    qa.result = 'failed'
    qa.time = time
    qa.PATIENT = Patient.objects.get(LOGIN=lid)
    from datetime import datetime
    qa.date = datetime.now().date()
    qa.save()
    return JsonResponse({'status': 'ok'})


def handwriting(request):
    lid = request.POST['lid']
    tid = request.POST['type']
    import base64
    image = request.POST['image']
    s = request.POST['inum']
    print(s)
    a = base64.b64decode(image)
    fh = open("C:\\Users\\user\\PycharmProjects\\elderlycare\\media\\test.bmp", "wb")
    fh.write(a)
    fh.close()
    print("helllo")
    from . import scan
    s1 = scan.predict()
    print("output - ", s1)
    res1 = {}
    s=''
    if s1:
        if s1 == 3349:
            s = u'ക'
        elif s1 == 3333:
            s = u'അ'
        elif s1 == 3334:
            s = u'ആ'
        elif s1 == 3335:
            s = u'ഇ'
        elif s1 == 3337:
            s = u'ഉ'
        elif s1 == 3342:
            s = u'എ'
        elif s1 == 3343:
            s = u'ഏ'
        elif s1 == 3346:
            s = u'ഒ'
        elif s1 == 3349:
            s = u'ക'
        elif s1 == 3350:
            s = u'ഖ'
        elif s1 == 3351:
            s = u'ഗ'
        elif s1 == 3352:
            s = u'ഘ'
        elif s1 == 3353:
            s = u'ങ'
        elif s1 == 3354:
            s = u'ച'
        elif s1 == 3355:
            s = u'ഛ'
        elif s1 == 3356:
            s = u'ജ'
        elif s1 == 3357:
            s = u'ഝ'
        elif s1 == 3358:
            s = u'ഞ'
        elif s1 == 3359:
            s = u'ട'
        elif s1 == 3360:
            s = u'ഠ'
        elif s1 == 3361:
            s = u'ഡ'
        elif s1 == 3362:
            s = u'ഢ'
        elif s1 == 3363:
            s = u'ണ'
        elif s1 == 3364:
            s = u'ത'
        elif s1 == 3365:
            s = u'ഥ'
        elif s1 == 3366:
            s = u'ദ'
        elif s1 == 3367:
            s = u'ധ'
        elif s1 == 3368:
            s = u'ന'
        elif s1 == 3370:
            s = u'പ'
        elif s1 == 3371:
            s = u'ഫ'
        elif s1 == 3372:
            s = u'ബ'
        elif s1 == 3373:
            s = u'ഭ'
        elif s1 == 3374:
            s = u'മ'
        elif s1 == 3375:
            s = u'യ'
        elif s1 == 3376:
            s = u'ര'
        elif s1 == 3377:
            s = u'റ'
        elif s1 == 3378:
            s = u'ല'
        elif s1 == 3379:
            s = u'ള'
        elif s1 == 3380:
            s = u'ഴ'
        elif s1 == 3381:
            s = u'വ'
        elif s1 == 3382:
            s = u'ശ'
        elif s1 == 3383:
            s = u'ഷ'
        elif s1 == 3384:
            s = u'സ'
        elif s1 == 3385:
            s = u'ഹ'
        else:
            s = '[]'
    #     p = Progress()
    #     p.activity = tid
    #     p.CHILDREN = Children.objects.get(LOGIN_id=lid)
    #     p.status = "pass"
    #     p.date=datetime.now().today()
    #     p.save()
    #     return JsonResponse({'status':'ok','output':s,'code':str(s1)})
    # else:
    #     p = Progress()
    #     p.activity = tid
    #     p.CHILDREN = Children.objects.get(PARENT__LOGIN_id=lid)
    #     p.status = "fail"
    #     p.date=datetime.now().today()
    #     p.save()
        return JsonResponse({'status': 'ok', 'output': s, 'code': str(s1)})

            #     return JsonResponse({'status':'ok'})




def handwritingpass(request):
    lid = request.POST['lid']
    tid = request.POST['type']
    time=request.POST['time']
    from datetime import datetime

    p = Progress()
    p.title = tid
    p.time = time
    p.result = 'pass'
    p.PATIENT = Patient.objects.get(LOGIN_id=lid)
    p.date=datetime.now().today()
    p.save()
    return JsonResponse({'status':'ok'})



def handwritingfail(request):
    lid = request.POST['lid']
    tid = request.POST['type']
    time=request.POST['time']
    from datetime import datetime

    p = Progress()
    p.title = tid
    p.PATIENT = Patient.objects.get(LOGIN_id=lid)
    p.result = 'fail'
    p.date=datetime.now().today()
    p.time=time
    p.save()
    return JsonResponse({'status':'ok'})

def person_detection_post(request):
    import base64
    import io
    import os
    from PIL import Image
    from datetime import datetime
    from django.http import JsonResponse
    import subprocess
    from .models import Emotion, Progress, Patient

    try:
        # Fetch POST data
        name = request.POST.get('name')
        status = request.POST.get('status')
        lid = request.POST.get('lid')
        imid = request.POST.get('imid')
        photo = request.POST.get('photo')
        time = request.POST.get('time')

        # Validate required fields
        if not all([name, status, lid, imid, photo, time]):
            return JsonResponse({'status': 'error', 'message': 'Missing required fields'})

        # Decode and save image
        image_data = base64.b64decode(photo)
        image_pil = Image.open(io.BytesIO(image_data)).convert("RGB")
        image_pil = image_pil.rotate(90, expand=True)

        filename = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
        save_dir = r"C:\Users\user\PycharmProjects\elderlycare\media\emotion"
        os.makedirs(save_dir, exist_ok=True)
        save_path = os.path.join(save_dir, filename)
        image_pil.save(save_path)

        # Run the external emotion detection script
        command = [
            'C:\\Python38\\python.exe',
            'C:\\Users\\user\\PycharmProjects\\elderlycare\\my_project\\detection_emotion.py',
            save_path
        ]

        result = subprocess.run(
            command,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True
        )

        print("Subprocess STDOUT:", repr(result.stdout))
        print("Subprocess STDERR:", repr(result.stderr))

        ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
        output_cleaned = ansi_escape.sub('', result.stdout).strip()
        output_lines = output_cleaned.splitlines()
        detected_emotion = output_lines[-1].strip() if output_lines else ''

        # output_lines = result.stdout.strip().splitlines()
        # detected_emotion = output_lines[-1].strip() if output_lines else ''

        if not detected_emotion:
            return JsonResponse({'status': 'error', 'message': 'No emotion detected'})

        if detected_emotion.lower() in ['error', 'no_face']:
            return JsonResponse({'status': 'error', 'message': 'Face not detected or processing failed'})

        # Save emotion and progress to database
        patient = Patient.objects.get(LOGIN_id=lid)

        Emotion.objects.create(
            date=datetime.now().date(),
            name=detected_emotion,
            PATIENT=patient
        )

        Progress.objects.create(
            title="Object Detection",
            PATIENT=patient,
            result=status,
            date=datetime.now().date(),
            time=time
        )

        print(f"Detected emotion: {detected_emotion}")
        return JsonResponse({'status': 'ok', 'emotion': detected_emotion})

    except Exception as e:
        print(f"Exception occurred: {e}")
        return JsonResponse({'status': 'error', 'message': str(e)})


# def person_detection_post(request):
#     import base64
#     import io
#     import os
#     import numpy as np
#     from PIL import Image
#     from datetime import datetime
#     from django.http import JsonResponse
#     import subprocess
#     from .models import Emotion, Progress, Patient
#
#     try:
#         name = request.POST.get('name')
#         status = request.POST.get('status')
#         lid = request.POST.get('lid')
#         imid = request.POST.get('imid')
#         photo = request.POST.get('photo')
#         time = request.POST.get('time')
#
#         if not all([name, status, lid, imid, photo, time]):
#             return JsonResponse({'status': 'error', 'message': 'Missing required fields'})
#
#         # Decode and save the image
#         image_data = base64.b64decode(photo)
#         image_pil = Image.open(io.BytesIO(image_data)).convert("RGB")
#         image_pil = image_pil.rotate(90, expand=True)
#
#         filename = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
#         save_dir = r"C:\Users\user\PycharmProjects\elderlycare\media\emotion"
#         os.makedirs(save_dir, exist_ok=True)
#         save_path = os.path.join(save_dir, filename)
#         image_pil.save(save_path)
#
#         # Call the external emotion detection script using Python 3.8
#         command = [
#             'C:\\Python38\\python.exe',
#             'C:\\Users\\user\\PycharmProjects\\elderlycare\\my_project\\detection_emotion.py',
#             save_path
#         ]
#
#         result = subprocess.run(
#             command,
#             stdout=subprocess.PIPE,
#             stderr=subprocess.PIPE,
#             universal_newlines=True
#         )
#
#         print("Subprocess STDOUT:", result.stdout)
#         print("Subprocess STDERR:", result.stderr)
#
#         output_lines = result.stdout.strip().splitlines()
#         detected_emotion = output_lines[-1].strip() if output_lines else 'error'
#
#         if detected_emotion in ['error', 'no_face']:
#             return JsonResponse({'status': 'error', 'message': 'Face not detected or processing failed'})
#
#         # Save emotion and progress to the database
#         patient = Patient.objects.get(LOGIN_id=lid)
#
#         Emotion.objects.create(
#             date=datetime.now().date(),
#             name=detected_emotion,
#             PATIENT=patient
#         )
#
#         Progress.objects.create(
#             title="Object Detection",
#             PATIENT=patient,
#             result=status,
#             date=datetime.now().date(),
#             time=time
#         )
#
#         print(f"Detected emotion: {detected_emotion}")
#         return JsonResponse({'status': 'ok', 'emotion': detected_emotion})
#
#     except Exception as e:
#         print(f"Exception occurred: {e}")
#         return JsonResponse({'status': 'error', 'message': str(e)})


# def person_detection_post(request):
#     import base64
#     import io
#     import os
#     import numpy as np
#     from PIL import Image
#     from datetime import datetime
#     from django.http import JsonResponse
#     import subprocess
#     from .models import Emotion, Progress, Patient
#
#     try:
#         name = request.POST.get('name')
#         status = request.POST.get('status')
#         lid = request.POST.get('lid')
#         imid = request.POST.get('imid')
#         photo = request.POST.get('photo')
#         time = request.POST.get('time')
#
#         if not all([name, status, lid, imid, photo, time]):
#             return JsonResponse({'status': 'error', 'message': 'Missing required fields'})
#
#         # Save the image
#         image_data = base64.b64decode(photo)
#         image_pil = Image.open(io.BytesIO(image_data)).convert("RGB")
#         image_pil = image_pil.rotate(90, expand=True)
#
#         filename = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
#         save_dir = r"C:\Users\user\PycharmProjects\elderlycare\media\emotion"
#         os.makedirs(save_dir, exist_ok=True)
#         save_path = os.path.join(save_dir, filename)
#         image_pil.save(save_path)
#
#         # Run subprocess to detect emotion using Python 3.8
#         result = subprocess.run(
#             ['C:\\Python38\\python.exe',
#              'C:\\Users\\user\\PycharmProjects\\elderlycare\\my_project\\detection_emotion.py',
#              save_path],
#             stdout=subprocess.PIPE,
#             stderr=subprocess.PIPE,
#             universal_newlines=True
#         )
#
#         output_lines = result.stdout.strip().splitlines()
#         detected_emotion = output_lines[-1] if output_lines else 'error'
#
#         if detected_emotion in ['error', 'no_face']:
#             return JsonResponse({'status': 'error', 'message': 'Face not detected or processing failed'})
#
#         # Save to DB
#         patient = Patient.objects.get(LOGIN_id=lid)
#
#         Emotion.objects.create(
#             date=datetime.now().date(),
#             name=detected_emotion,
#             PATIENT=patient
#         )
#
#         Progress.objects.create(
#             title="Object Detection",
#             PATIENT=patient,
#             result=status,
#             date=datetime.now().date(),
#             time=time
#         )
#
#         print(detected_emotion)
#         print("eeeeeeeeeeeeeeeeeee")
#
#         return JsonResponse({'status': 'ok', 'emotion': detected_emotion})
#
#     except Exception as e:
#         print(f"Exception occurred: {e}")
#         return JsonResponse({'status': 'error', 'message': str(e)})


# def person_detection_post(request):
#     import base64
#     import io
#     import os
#     import numpy as np
#     import cv2
#     from PIL import Image
#     from datetime import datetime
#     from django.http import JsonResponse
#     import tensorflow as tf
#     from keras.models import Sequential
#     from keras.layers import Conv2D, MaxPooling2D, Dropout, Flatten, Dense
#     from keras import backend as K
#
#     try:
#         # Get data from POST request
#         name = request.POST.get('name')
#         status = request.POST.get('status')
#         lid = request.POST.get('lid')
#         imid = request.POST.get('imid')
#         photo = request.POST.get('photo')
#         time = request.POST.get('time')
#
#         if not all([name, status, lid, imid, photo, time]):
#             return JsonResponse({'status': 'error', 'message': 'Missing required fields'})
#
#         # Decode and process image
#         image_data = base64.b64decode(photo)
#         image_pil = Image.open(io.BytesIO(image_data)).convert("RGB")
#         image_pil = image_pil.rotate(90, expand=True)
#
#         filename = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
#         save_dir = r"C:\Users\user\PycharmProjects\elderlycare\media\emotion"
#         os.makedirs(save_dir, exist_ok=True)
#         save_path = os.path.join(save_dir, filename)
#         image_pil.save(save_path)
#
#         frame = cv2.cvtColor(np.array(image_pil), cv2.COLOR_RGB2BGR)
#         gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
#
#         face_cascade = cv2.CascadeClassifier(
#             r'C:\Users\user\PycharmProjects\elderlycare\my_project\static\emo\haarcascade_frontalface_default.xml'
#         )
#         faces = face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5)
#
#         if len(faces) == 0:
#             return JsonResponse({'status': 'error', 'message': 'No face detected'})
#
#         # Create emotion model and load weights
#         model = Sequential()
#         model.add(Conv2D(32, kernel_size=(3, 3), activation='relu', input_shape=(48, 48, 1)))
#         model.add(Conv2D(64, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Dropout(0.25))
#         model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Dropout(0.25))
#         model.add(Flatten())
#         model.add(Dense(1024, activation='relu'))
#         model.add(Dropout(0.5))
#         model.add(Dense(7, activation='softmax'))
#
#         graph = tf.compat.v1.get_default_graph()  # Get the default graph
#         with graph.as_default():
#             model.load_weights(
#                 r'C:\Users\user\PycharmProjects\elderlycare\my_project\emo_model_full.h5'
#             )
#
#             emotion_dict = {
#                 0: "Angry", 1: "Disgusted", 2: "Fearful",
#                 3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"
#             }
#
#             for (x, y, w, h) in faces:
#                 roi_gray = gray[y:y + h, x:x + w]
#                 roi_resized = cv2.resize(roi_gray, (48, 48))
#                 roi_expanded = np.expand_dims(np.expand_dims(roi_resized, -1), 0).astype('float32') / 255.0
#                 prediction = model.predict(roi_expanded)
#                 detected_emotion = emotion_dict[int(np.argmax(prediction))]
#                 break
#
#         # Save to database
#         patient = Patient.objects.get(LOGIN_id=lid)
#
#         emotion = Emotion()
#         emotion.date = datetime.now().date()
#         emotion.name = detected_emotion
#         emotion.PATIENT = patient
#         emotion.save()
#
#         progress = Progress()
#         progress.title = "Object Detection"
#         progress.PATIENT = patient
#         progress.result = status
#         progress.date = datetime.now().date()
#         progress.time = time
#         progress.save()
#
#         return JsonResponse({'status': 'ok', 'emotion': detected_emotion})
#
#     except Exception as e:
#         print(f"Exception occurred: {e}")
#         return JsonResponse({'status': 'error', 'message': str(e)})

def viewNotification(request):
    # lid = request.POST['lid']
    nid = request.POST['nid']

    # obj = Caretaker.objects.filter(LOGIN_id=lid)
    i = Fall_notification.objects.filter(id__gt=nid)

    if i.exists():
        i = i[0]
        print(i.PATIENT.patient_Name)
        return JsonResponse({'status': 'ok', "id":i.id, 'nid': str(i.id), 'message': i.PATIENT.patient_Name + ' Has been fallen'})
    else:
        return JsonResponse({'status': 'no'})

def viewfallnotification(request):
    lid = request.POST['lid']
    # nid = request.POST['nid']
    obj = Fall_notification.objects.filter(PATIENT__CARETAKER__LOGIN_id=lid)
    l=[]
    for i in obj:
        l.append({'message': i.PATIENT.patient_Name ,'image':i.photo, 'time':i.time,'date':i.date})

    # obj = Caretaker.objects.filter(LOGIN_id=lid)
    # i = Fall_notification.objects.filter(id__gt=nid, PATIENT__CARETAKER__LOGIN_id=lid)

    # if i.exists():
    #     i = i[0]
    #     print(i.PATIENT.patient_Name)
    return JsonResponse({'status': 'ok','data':l})


def newviewfallnotification(request):
    lid=request.POST['lid']
    nid=request.POST['nid']
    print(nid,"===================")
    if nid is None:
        nid=0
    try:
        h=int(nid)
    except:
        nid=0
    from datetime import datetime,timedelta
    today = datetime.now().date()  # Today's date
    two_days_later = today + timedelta(days=2)
    #print(two_days_later)
    dd=Fall_notification.objects.filter(PATIENT__CARETAKER__LOGIN_id=lid,date=today,id__gt=nid)
    if dd.exists():
        f=dd[0]
        #print(f.id)
        return JsonResponse({"status":"ok",'nid':f.id,'message': f.PATIENT.patient_Name +" has fallen"})
    else:
        return JsonResponse({"status": "no"})
#
# def view_Pill_notification(request):
#     from datetime import datetime
#     lid = request.POST['lid']
#     current_time = datetime.now().time()
#
#     pill_times = Pill_time.objects.filter(PATIENT__LOGIN_id=lid)
#
#     for i in pill_times:
#         pill_time = datetime.strptime(i.time, "%H:%M:%S").time()  # Convert string to time object
#         if pill_time >= current_time:
#             return JsonResponse({'status': 'ok', 'id': i.id, 'time': i.time, 'message': 'Time to take pills'})
#         print(i)
#     return JsonResponse({'status': 'no pills due'})
#

from datetime import datetime
from django.http import JsonResponse




from datetime import datetime
from django.http import JsonResponse

def view_Pill_notification(request):
    lid = request.POST.get('lid')

    if not lid:
        return JsonResponse({'status': 'error', 'message': 'Missing lid'})

    current_time = datetime.now().strftime("%I:%M %p")  # e.g., "07:45 AM"
    current_date = datetime.now().strftime("%Y-%m-%d")  # e.g., "2025-05-31"

    # Filter pills for this patient for current date and time
    pill_times = Pill_time.objects.filter(
        PATIENT__LOGIN_id=lid,
        date=current_date,
        time=current_time
    )

    pill_list = []
    for pill in pill_times:
        pill_list.append({
            'id': pill.id,
            'time': pill.time,
            'date': pill.date,
            'pill': pill.pill,
            'message': '⏰ Time to take your pill!'
        })

    if pill_list:
        print(pill_list)

        return JsonResponse({'status': 'ok', 'data': pill_list})
    else:
        return JsonResponse({'status': 'no pills due'})



# def viewfallnotification_new(request):
#     lid = request.POST['lid']
#     nid = request.POST['nid']
#     obj = Fall_notification.objects.filter(PATIENT__CARETAKER__LOGIN_id=lid)
#     l=[]
#     for i in obj:
#         l.append({'message': i.PATIENT.patient_Name ,'image':i.photo, 'time':i.time,'date':i.date})
#
#     # obj = Caretaker.objects.filter(LOGIN_id=lid)
#     # i = Fall_notification.objects.filter(id__gt=nid, PATIENT__CARETAKER__LOGIN_id=lid)
#
#     # if i.exists():
#     #     i = i[0]
#     #     print(i.PATIENT.patient_Name)
#     return JsonResponse({'status': 'ok','data':l})



from .models import Fall_notification

def viewfallnotification_new(request):
    lid = request.POST['lid']

    # Get the latest fall notification for the logged-in caretaker
    obj = Fall_notification.objects.filter(PATIENT__CARETAKER__LOGIN_id=lid).order_by('-id').first()

    l = []
    if obj:
        l.append({
            'message': obj.PATIENT.patient_Name + " is falling!",
            'time': str(obj.time),
            'date': str(obj.date),
            'id': obj.id
        })

    return JsonResponse({'status': 'ok', 'data': l})


# def viewfallnotification_new(request):
#     lid = request.POST['lid']
#     # nid = request.POST['nid']
#
#     # Get only new notifications (id > nid) for the caretaker
#     obj = Fall_notification.objects.filter(PATIENT__CARETAKER__LOGIN_id=lid).order_by('-id')
#
#     l = []
#     for i in obj:
#         l.append({
#             'message': i.PATIENT.patient_Name+"is falling",
#             'time': str(i.time),
#             'date': str(i.date),
#             'id': i.id  # send ID so frontend can track last received
#         })
#
#     return JsonResponse({'status': 'ok', 'data': l})


def patient_view_pill_notifications_post(request):
    lid = request.POST.get('lid')
    pill_times = Pill_time.objects.filter(
        PATIENT__LOGIN_id=lid,
        date__gte=datetime.now().date(),
    )

    pill_list = []
    for pill in pill_times:
        pill_list.append({
            'id': pill.id,
            'time': pill.time,
            'date': pill.date,
            'pill': pill.pill,
            'message': '⏰ Time to take your pill!'
        })
    return JsonResponse({'status': 'ok','data':pill_list})

# def view_Pill_notification(request):
#     lid = request.POST.get('lid')
#     nid = request.POST.get('nid')
#     current_time = datetime.now().strftime("%I:%M %p")  # Formatting current time to match stored format
#
#     pill_times = Pill_time.objects.filter(id__gt=nid,PATIENT__LOGIN_id=lid)
#     pill_list = []
#
#     for i in pill_times:
#         if i.time == current_time:  # Compare pill time with the formatted current time
#             pill_list.append({'id': i.id, 'time': i.time, 'message': 'Time to take pills'})
#
#     return JsonResponse({'status': 'ok', 'data': pill_list} if pill_list else {'status': 'no pills due'})
#
#
#
#
#
#     # else:
#     #     return JsonResponse({'status': 'no'})
# def person_detection_post(request):
#     import base64
#     import io
#     import os
#     import numpy as np
#     import cv2
#     from PIL import Image
#     from datetime import datetime
#     from django.http import JsonResponse
#     from keras.models import Sequential
#     from keras.layers import Conv2D, MaxPooling2D, Dropout, Flatten, Dense
#     from .models import Emotion, Patient, Progress  # Update to your actual model paths
#
#     try:
#         # Get data from POST request
#         name = request.POST.get('name')
#         status = request.POST.get('status')
#         lid = request.POST.get('lid')
#         imid = request.POST.get('imid')
#         photo = request.POST.get('photo')
#         time = request.POST.get('time')
#
#         # Validate inputs
#         if not all([name, status, lid, imid, photo]):
#             return JsonResponse({'status': 'error', 'message': 'Missing required fields'})
#
#         # Decode and process image
#         image_data = base64.b64decode(photo)
#         image_pil = Image.open(io.BytesIO(image_data)).convert("RGB")
#         image_pil = image_pil.rotate(90, expand=True)
#
#         # Save image
#         filename = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
#         save_dir = r"C:\Users\user\PycharmProjects\elderlycare\media\emotion"
#         os.makedirs(save_dir, exist_ok=True)
#         save_path = os.path.join(save_dir, filename)
#         image_pil.save(save_path)
#
#         # Convert to OpenCV
#         frame = cv2.cvtColor(np.array(image_pil), cv2.COLOR_RGB2BGR)
#         gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
#
#         # Detect faces
#         face_cascade = cv2.CascadeClassifier(
#             r'C:\Users\user\PycharmProjects\elderlycare\my_project\static\emo\haarcascade_frontalface_default.xml'
#         )
#         faces = face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5)
#
#         if len(faces) == 0:
#             return JsonResponse({'status': 'error', 'message': 'No face detected in the image'})
#
#         # Define and load emotion model
#         model = Sequential()
#         model.add(Conv2D(32, kernel_size=(3, 3), activation='relu', input_shape=(48, 48, 1)))
#         model.add(Conv2D(64, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Dropout(0.25))
#         model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Dropout(0.25))
#         model.add(Flatten())
#         model.add(Dense(1024, activation='relu'))
#         model.add(Dropout(0.5))
#         model.add(Dense(7, activation='softmax'))
#
#         model.load_weights(
#             r'C:\Users\user\PycharmProjects\elderlycare\my_project\emo_model_full.h5'
#         )
#
#         emotion_dict = {
#             0: "Angry", 1: "Disgusted", 2: "Fearful",
#             3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"
#         }
#
#         # Process the first detected face
#         for (x, y, w, h) in faces:
#             roi_gray = gray[y:y + h, x:x + w]
#             roi_resized = cv2.resize(roi_gray, (48, 48))
#             roi_expanded = np.expand_dims(np.expand_dims(roi_resized, -1), 0).astype('float32') / 255.0
#             prediction = model.predict(roi_expanded)
#             detected_emotion = emotion_dict[int(np.argmax(prediction))]
#             break
#
#         # Save emotion
#         try:
#             patient = Patient.objects.get(LOGIN_id=lid)
#         except Patient.DoesNotExist:
#             return JsonResponse({'status': 'error', 'message': 'Patient not found'})
#
#
#         print(detected_emotion)
#
#         emotion = Emotion()
#         emotion.date = datetime.now().date()
#         emotion.name = detected_emotion
#         emotion.PATIENT = patient
#         emotion.save()
#
#         # Save progress
#         progress = Progress()
#         progress.title = "Object Detection"
#         progress.PATIENT = patient
#         progress.result = status
#         progress.date = datetime.now().date()
#         progress.time = time
#         progress.save()
#
#         return JsonResponse({'status': 'ok', 'emotion': detected_emotion})
#
#     except Exception as e:
#         print(f"Exception occurred: {e}")
#         return JsonResponse({'status': 'error', 'message': str(e)})


# def person_detection_post(request):
#     import base64
#     import io
#     import os
#     import numpy as np
#     import cv2
#     from PIL import Image
#     from datetime import datetime
#     from django.http import JsonResponse
#     from keras.models import Sequential
#     from keras.layers import Conv2D, MaxPooling2D, Dropout, Flatten, Dense
#
#     try:
#         # Get data from POST request
#         name = request.POST.get('name')
#         status = request.POST.get('status')
#         lid = request.POST.get('lid')
#         imid = request.POST.get('imid')
#         photo = request.POST.get('photo')
#         time = request.POST.get('time')
#
#         # Validate inputs
#         if not all([name, status, lid, imid, photo]):
#             return JsonResponse({'status': 'error', 'message': 'Missing required fields'})
#
#         # Decode and process the image
#         image_data = base64.b64decode(photo)
#         image_pil = Image.open(io.BytesIO(image_data)).convert("RGB")
#         image_pil = image_pil.rotate(90, expand=True)
#
#         # Save the image to disk
#         filename = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
#         save_dir = r"C:\Users\user\PycharmProjects\elderlycare\media\emotion"
#         os.makedirs(save_dir, exist_ok=True)
#         save_path = os.path.join(save_dir, filename)
#         image_pil.save(save_path)
#
#         # Convert image to OpenCV format
#         frame = cv2.cvtColor(np.array(image_pil), cv2.COLOR_RGB2BGR)
#         gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
#
#         # Load Haar cascade for face detection
#         face_cascade = cv2.CascadeClassifier(
#             r'C:\Users\user\PycharmProjects\elderlycare\my_project\static\emo\haarcascade_frontalface_default.xml'
#         )
#         faces = face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5)
#
#         if len(faces) == 0:
#             return JsonResponse({'status': 'error', 'message': 'No face detected in the image'})
#
#         # Define and load emotion model
#         model = Sequential()
#         model.add(Conv2D(32, kernel_size=(3, 3), activation='relu', input_shape=(48, 48, 1)))
#         model.add(Conv2D(64, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Dropout(0.25))
#         model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Dropout(0.25))
#         model.add(Flatten())
#         model.add(Dense(1024, activation='relu'))
#         model.add(Dropout(0.5))
#         model.add(Dense(7, activation='softmax'))
#
#         model.load_weights(
#             r'C:\Users\user\PycharmProjects\elderlycare\my_project\emo_model_full.h5'
#         )
#
#         emotion_dict = {
#             0: "Angry", 1: "Disgusted", 2: "Fearful",
#             3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"
#         }
#
#         # Process the first detected face
#         for (x, y, w, h) in faces:
#             roi_gray = gray[y:y + h, x:x + w]
#             roi_resized = cv2.resize(roi_gray, (48, 48))
#             roi_expanded = np.expand_dims(np.expand_dims(roi_resized, -1), 0).astype('float32') / 255.0
#             prediction = model.predict(roi_expanded)
#             detected_emotion = emotion_dict[int(np.argmax(prediction))]
#             break  # Only process the first face
#
#         # Fetch patient object
#         try:
#             patient = Patient.objects.get(LOGIN_id=lid)
#         except Patient.DoesNotExist:
#             return JsonResponse({'status': 'error', 'message': 'Patient not found'})
#
#         # Save emotion
#         emotion = Emotion()
#         emotion.date = datetime.now().date()
#         emotion.name = detected_emotion
#         emotion.PATIENT = patient
#         emotion.save()
#
#         # Save progress
#         progress = Progress()
#         progress.title = "Object Detection"
#         progress.PATIENT = patient
#         progress.result = status
#         progress.date = datetime.now().date()
#         progress.time = time
#         progress.save()
#
#         return JsonResponse({'status': 'ok', 'emotion': detected_emotion})
#
#     except Exception as e:
#         print(f"Exception occurred: {e}")
#         return JsonResponse({'status': 'error', 'message': str(e)})



# def person_detection_post(request):
#     import base64
#     import io
#     import os
#     import numpy as np
#     import cv2
#     from PIL import Image
#     from datetime import datetime
#     from django.http import JsonResponse
#     from keras.models import Sequential
#     from keras.layers import Conv2D, MaxPooling2D, Dropout, Flatten, Dense
#     try:
#         # Get data from POST request
#         name = request.POST.get('name')
#         status = request.POST.get('status')
#         lid = request.POST.get('lid')
#         imid = request.POST.get('imid')
#         photo = request.POST.get('photo')
#         time = request.POST['time']
#
#         print(request.POST)
#
#         # Check for missing data
#         if not all([name, status, lid, imid, photo]):
#             return JsonResponse({'status': 'error', 'message': 'Missing required fields'})
#
#         # Decode base64 image
#         image_data = base64.b64decode(photo)
#         image_pil = Image.open(io.BytesIO(image_data)).convert("RGB")
#         image_pil = image_pil.rotate(90, expand=True)
#
#         # Save the image
#         filename = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
#         save_dir = r"C:\Users\user\PycharmProjects\elderlycare\media\emotion"
#         os.makedirs(save_dir, exist_ok=True)
#         save_path = os.path.join(save_dir, filename)
#         image_pil.save(save_path)
#
#         # Convert to OpenCV image
#         frame = cv2.cvtColor(np.array(image_pil), cv2.COLOR_RGB2BGR)
#         gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
#
#         # Detect face using Haar cascade
#         face_cascade = cv2.CascadeClassifier(
#             r'C:\Users\user\PycharmProjects\elderlycare\my_project\static\emo\haarcascade_frontalface_default.xml'
#         )
#         faces = face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5)
#
#         if len(faces) == 0:
#             return JsonResponse({'status': 'error', 'message': 'No face detected in the image'})
#
#         # Define and load emotion model
#         model = Sequential()
#         model.add(Conv2D(32, kernel_size=(3, 3), activation='relu', input_shape=(48, 48, 1)))
#         model.add(Conv2D(64, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Dropout(0.25))
#         model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Dropout(0.25))
#         model.add(Flatten())
#         model.add(Dense(1024, activation='relu'))
#         model.add(Dropout(0.5))
#         model.add(Dense(7, activation='softmax'))
#
#         model.load_weights(
#             r'C:\Users\user\PycharmProjects\elderlycare\my_project\emo_model_full.h5'
#         )
#
#         emotion_dict = {
#             0: "Angry", 1: "Disgusted", 2: "Fearful",
#             3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"
#         }
#         print("aaaaaaaaaaaaaaaaaaaa")
#         print(status)
#         print(time)
#
#         # Process the first face only
#         for (x, y, w, h) in faces:
#             roi_gray = gray[y:y + h, x:x + w]
#             roi_resized = cv2.resize(roi_gray, (48, 48))
#             roi_expanded = np.expand_dims(np.expand_dims(roi_resized, -1), 0).astype('float32') / 255.0
#             prediction = model.predict(roi_expanded)
#             detected_emotion = emotion_dict[int(np.argmax(prediction))]
#             print(f"Detected Emotion: {detected_emotion}")
#             break
#
#         # Save emotion to DB
#         try:
#             patient = Patient.objects.get(LOGIN_id=lid)
#         except Patient.DoesNotExist:
#             return JsonResponse({'status': 'error', 'message': 'Patient not found'})
#
#         e=Emotion
#         e.date=datetime.now().today()
#         e.name=detected_emotion
#         e.PATIENT=Patient.objects.get(LOGIN_id=lid)
#         e.save()
#
#         # Emotion.objects.create(
#         #     date=datetime.now().date(),
#         #     emotions=detected_emotion,
#         #     PATIENT=patient
#         # )
#
#         # Update image status
#         # d_Image.objects.filter(id=imid).update(status="Completed")
#         #
#         # # Save performance entry
#
#         p = Progress()
#         p.title = "Object Detection"
#         p.PATIENT = Patient.objects.get(LOGIN_id=lid)
#         p.result = status
#         p.date = datetime.now().today()
#         p.time = time
#         p.save()
#
#         # Performance.objects.create(
#         #     type="Person",
#         #     PATIENT=patient,
#         #     status=status,
#         #     name=name,
#         #     date=datetime.now().date()
#         # )
#
#         return JsonResponse({'status': 'ok', 'emotion': detected_emotion})
#
#     except Exception as e:
#         print(f"Exception occurred: {e}")
#         return JsonResponse({'status': 'error', 'message': str(e)})


# def person_detection_post(request):
#     try:
#         # Get data from POST request        name = request.POST.get('name')
#         status = request.POST.get('status')
#         lid = request.POST.get('lid')
#         imid = request.POST.get('imid')
#         photo = request.POST.get('photo')
#
#         # Check for missing data        if not all([name, status, lid, imid, photo]):
#             return JsonResponse({'status': 'error', 'message': 'Missing required fields'})
#
#         # Decode base64 image        image_data = base64.b64decode(photo)
#         image_pil = Image.open(io.BytesIO(image_data)).convert("RGB")
#         image_pil = image_pil.rotate(90, expand=True)
#
#         # Save the image        filename = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"        save_dir = r"C:\Users\HP\PycharmProjects\dementia\media\emotion"        os.makedirs(save_dir, exist_ok=True)
#         save_path = os.path.join(save_dir, filename)
#         image_pil.save(save_path)
#
#         # Convert to OpenCV image        frame = cv2.cvtColor(np.array(image_pil), cv2.COLOR_RGB2BGR)
#         gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
#
#         # Detect face using Haar cascade        face_cascade = cv2.CascadeClassifier(
#             r'C:\Users\HP\PycharmProjects\dementia\dementia_app\static\emo\haarcascade_frontalface_default.xml'        )
#         faces = face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5)
#
#         if len(faces) == 0:
#             return JsonResponse({'status': 'error', 'message': 'No face detected in the image'})
#
#         # Define and load emotion model        model = Sequential()
#         model.add(Conv2D(32, kernel_size=(3, 3), activation='relu', input_shape=(48, 48, 1)))
#         model.add(Conv2D(64, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Dropout(0.25))
#         model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
#         model.add(MaxPooling2D(pool_size=(2, 2)))
#         model.add(Dropout(0.25))
#         model.add(Flatten())
#         model.add(Dense(1024, activation='relu'))
#         model.add(Dropout(0.5))
#         model.add(Dense(7, activation='softmax'))
#
#         model.load_weights(
#             r'C:\Users\HP\PycharmProjects\dementia\dementia_app\static\emo\model.h5'        )
#
#         emotion_dict = {
#             0: "Angry", 1: "Disgusted", 2: "Fearful",
#             3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"        }
#
#         # Process the first face only        for (x, y, w, h) in faces:
#             roi_gray = gray[y:y + h, x:x + w]
#             roi_resized = cv2.resize(roi_gray, (48, 48))
#             roi_expanded = np.expand_dims(np.expand_dims(roi_resized, -1), 0).astype('float32') / 255.0            prediction = model.predict(roi_expanded)
#             detected_emotion = emotion_dict[int(np.argmax(prediction))]
#             print(f"Detected Emotion: {detected_emotion}")
#             break        # Save emotion to DB        try:
#             patient = Patient.objects.get(LOGIN_id=lid)
#         except Patient.DoesNotExist:
#             return JsonResponse({'status': 'error', 'message': 'Patient not found'})
#
#         Emotion.objects.create(
#             date=datetime.now().date(),
#             time=datetime.now().time(),
#             emotions=detected_emotion,
#             PATIENT=patient
#         )
#
#         # Update image status        d_Image.objects.filter(id=imid).update(status="Completed")
#
#         # Save performance entry
#         Performance.objects.create(
#             type="Person",
#             PATIENT=patient,
#             status=status,
#             name=name,
#             date=datetime.now().date()
#         )
#
#         return JsonResponse({'status': 'ok', 'emotion': detected_emotion})
#
#     except Exception as e:
#         print(f"Exception occurred: {e}")
#         return JsonResponse({'status': 'error', 'message': str(e)})

# import os
# import base64
# import subprocess
# from django.http import JsonResponse
# from django.views.decorators.csrf import csrf_exempt
# from django.conf import settings
#
# @csrf_exempt
# def compare_pose(request):
#     if request.method == 'POST':
#         try:
#             image_data = request.POST.get('image')
#             reference_path = request.POST.get('reference')  # full path or server path
#             image_id = request.POST.get('inum')  # used for filename
#
#             print(f"Image number: {image_id}")
#
#             # Save decoded image using `inum`
#             image_filename = f"captured_{image_id}.jpg"
#             image_path = os.path.join(settings.MEDIA_ROOT, image_filename)
#
#             with open(image_path, 'wb') as f:
#                 f.write(base64.b64decode(image_data))
#
#             # Call the subprocess
#             result = subprocess.run(
#                 ['python3.8', 'hand.py', image_path, reference_path],
#                 capture_output=True,
#                 text=True
#             )
#
#             output = result.stdout.strip().lower()
#             print("Subprocess output:", output)
#             matched = output == "match"
#
#             return JsonResponse({'status': 'ok', 'match': matched})
#
#         except Exception as e:
#             return JsonResponse({'status': 'error', 'error': str(e)})
#
#     return JsonResponse({'status': 'invalid_request'})
#
#


# import os
# import base64
# import subprocess
# from django.http import JsonResponse
# from django.views.decorators.csrf import csrf_exempt
# from django.conf import settings
#
# @csrf_exempt
# def compare_pose(request):
#     if request.method == 'POST':
#         try:
#             # Get base64 image and reference path
#             image_base64 = request.POST.get('image')
#             reference_path = request.POST.get('reference')
#
#             if not image_base64 or not reference_path:
#                 return JsonResponse({'status': 'error', 'message': 'Missing data'})
#
#             # Save as fixed filename (overwrite every time)
#             save_path = os.path.join(settings.MEDIA_ROOT, 'captured.jpg')
#             with open(save_path, "wb") as fh:
#                 fh.write(base64.b64decode(image_base64))
#
#             # Run comparison subprocess
#             result = subprocess.run(
#                 ['C:\\Python38\\python.exe', 'C:\\Users\\user\\PycharmProjects\\elderlycare\\my_project\\hand.py', save_path, reference_path],
#                 capture_output=True,
#                 text=True
#             )
#
#             output = result.stdout.strip().lower()
#             print("Subprocess output:", output)
#
#             match = output == "match"
#             return JsonResponse({'status': 'ok', 'match': match})
#
#         except Exception as e:
#             return JsonResponse({'status': 'error', 'message': str(e)})
#
#     return JsonResponse({'status': 'invalid_request'})


# import os
# import base64
# import subprocess
# from django.http import JsonResponse
# from django.views.decorators.csrf import csrf_exempt
# from django.conf import settings
#
# @csrf_exempt
# def compare_pose(request):
#     if request.method == 'POST':
#         try:
#             # Get base64 image and task ID
#             image_base64 = request.POST.get('image')
#             task_id = request.POST.get('id')
#
#             if not image_base64 or not task_id:
#                 return JsonResponse({'status': 'error', 'message': 'Missing image or task ID'})
#
#             # Fetch the task and reference image path
#             try:
#                 task = motion_task.objects.get(id=task_id)
#                 reference_filename = task.image.name  # assuming 'image' is an ImageField
#                 reference_path = os.path.join(settings.MEDIA_ROOT, reference_filename)
#             except motion_task.DoesNotExist:
#                 return JsonResponse({'status': 'error', 'message': 'Task not found'})
#
#             if not os.path.exists(reference_path):
#                 return JsonResponse({'status': 'error', 'message': 'Reference image not found'})
#
#             # Save uploaded image to a fixed path
#             captured_path = os.path.join(settings.MEDIA_ROOT, 'captured.jpg')
#             with open(captured_path, "wb") as fh:
#                 fh.write(base64.b64decode(image_base64))
#
#             # Run comparison subprocess
#             result = subprocess.run(
#                 ['C:\\Python38\\python.exe', 'C:\\Users\\user\\PycharmProjects\\elderlycare\\my_project\\hand.py', captured_path, reference_path],
#                 capture_output=True,
#                 text=True
#             )
#
#             output = result.stdout.strip().lower()
#             print("Subprocess output:", output)
#
#             match = output == "match"
#             return JsonResponse({'status': 'ok', 'match': match})
#
#         except Exception as e:
#             return JsonResponse({'status': 'error', 'message': str(e)})
#
#     return JsonResponse({'status': 'invalid_request'})


import os
import base64
import subprocess
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings

# @csrf_exempt
# # def compare_pose(request):
# #     if request.method == 'POST':
# #         try:
# #             image_base64 = request.POST.get('image')
# #             task_id = request.POST.get('id')
# #
# #             if not image_base64 or not task_id:
# #                 return JsonResponse({'status': 'error', 'message': 'Missing image or task ID'})
# #
# #             try:
# #                 task = motion_task.objects.get(id=task_id)
# #                 reference_filename = task.image  # Since it's a CharField
# #                 reference_path = os.path.join(settings.MEDIA_ROOT, reference_filename)
# #             except motion_task.DoesNotExist:
# #                 return JsonResponse({'status': 'error', 'message': 'Task not found'})
# #
# #             if not os.path.exists(reference_path):
# #                 return JsonResponse({'status': 'error', 'message': 'Reference image not found'})
# #
# #             # Save captured image
# #             captured_path = os.path.join(settings.MEDIA_ROOT, 'captured.jpg')
# #             with open(captured_path, "wb") as fh:
# #                 fh.write(base64.b64decode(image_base64))
# #
# #             # Run Python script to compare images
# #             result = subprocess.run(
# #                 ['C:\\Python38\\python.exe', 'C:\\Users\\user\\PycharmProjects\\elderlycare\\my_project\\hand.py', captured_path, reference_path],
# #                 capture_output=True,
# #                 text=True
# #             )
# #
# #             output = result.stdout.strip().lower()
# #             print("Subprocess output:", output)
# #
# #             match = output == "match"
# #             return JsonResponse({'status': 'ok', 'match': match})
# #
# #         except Exception as e:
# #             print(e)
# #             return JsonResponse({'status': 'error', 'message': str(e)})
# #
# #     return JsonResponse({'status': 'invalid_request'})
# # def compare_pose(request):
# #     if request.method == 'POST':
# #         try:
# #             image_base64 = request.POST.get('image')
# #             task_id = request.POST.get('id')
# #             print("Received task_id:", task_id)
# #             print(image_base64,"kkkk")
# #             print("Image base64 length:", len(image_base64) if image_base64 else 'No image')
# #
# #             if not image_base64 or not task_id:
# #                 return JsonResponse({'status': 'error', 'message': 'Missing image or task ID'})
# #
# #             try:
# #                 task = motion_task.objects.get(id=task_id)
# #                 reference_filename = task.image
# #
# #                 reference_filename= reference_filename.replace("/media/photo/","")
# #                 reference_path= "C:\\Users\\user\\PycharmProjects\\elderlycare\\media\\photo\\"+reference_filename
# #                 print("Reference image path:", reference_path)
# #             except motion_task.DoesNotExist as p:
# #                 print(p)
# #
# #                 return JsonResponse({'status': 'error', 'message': 'Task not found'})
# #
# #             if not os.path.exists(reference_path):
# #                 print("heeeyyyyyyy")
# #                 print(reference_path,"====")
# #                 return JsonResponse({'status': 'error', 'message': 'Reference image not found'})
# #             print("zzzzzzzzzzzzzzzzzzzzzzzz")
# #
# #             captured_path = os.path.join("C:\\Users\\user\\PycharmProjects\\elderlycare\\media", 'captured.jpg')
# #             with open(captured_path, "wb") as fh:
# #                 fh.write(base64.b64decode(image_base64))
# #             print("Captured image saved at:", captured_path)
# #
# #             result = subprocess.run(
# #                 ['C:\\Python38\\python.exe', 'C:\\Users\\user\\PycharmProjects\\elderlycare\\my_project\\hand.py', captured_path, reference_path],
# #                 stdout=subprocess.PIPE,
# #                 stderr=subprocess.PIPE,
# #                 universal_newlines=True
# #                 # text=True
# #             )
# #
# #             print(result)
# #
# #             # print("Return code:", result.returncode)
# #             # print("STDOUT:", result.stdout)
# #             # print("STDERR:", result.stderr)
# #
# #             output = result.stdout.strip().lower()
# #
# #             print(output,"====")
# #             match = output == "match"
# #
# #             return JsonResponse({'status': 'ok', 'match': match})
# #
# #         except Exception as e:
# #             print("Error occurred:", str(e))
# #             return JsonResponse({'status': 'error', 'message': str(e)})
# #
# #     return JsonResponse({'status': 'invalid_request'})

# def compare_pose(request):
#     if request.method == 'POST':
#         try:
#             image_base64 = request.POST.get('image')
#             task_id = request.POST.get('id')
#             lid=request.POST['lid']
#
#             if not image_base64 or not task_id:
#                 return JsonResponse({'status': 'error', 'message': 'Missing image or task ID'})
#
#             task = motion_task.objects.get(id=task_id)
#             reference_filename = task.image.replace("/media/photo/", "")
#             reference_path = os.path.join(settings.MEDIA_ROOT, 'photo', reference_filename)
#
#             if not os.path.exists(reference_path):
#                 return JsonResponse({'status': 'error', 'message': 'Reference image not found'})
#
#             captured_path = os.path.join(settings.MEDIA_ROOT, 'captured.jpg')
#             with open(captured_path, "wb") as fh:
#                 fh.write(base64.b64decode(image_base64))
#
#             result = subprocess.run(
#                 ['C:\\Python38\\python.exe', 'C:\\Users\\user\\PycharmProjects\\elderlycare\\my_project\\hand.py', captured_path, reference_path],
#                 stdout=subprocess.PIPE,
#                 stderr=subprocess.PIPE,
#                 universal_newlines=True
#             )
#
#             # ✅ Safely extract the last line of stdout
#             output_lines = result.stdout.strip().splitlines()
#             output = output_lines[-1].strip().lower() if output_lines else ''
#
#             match = output == "match"
#
#
#             if match=="match":
#
#                 p=Progress()
#                 p.title='Task to perform'
#                 p.date=datetime.now().date()
#                 p.time=datetime.now().time()
#                 p.result='Pass'
#                 p.PATIENT=Patient.objects.get(LOGIN_id=lid)
#                 p.save()
#
#             else:
#                 p = Progress()
#                 p.title = 'Task to perform'
#                 p.date = datetime.now().date()
#                 p.time = datetime.now().time()
#                 p.result = 'Fail'
#                 p.PATIENT = Patient.objects.get(LOGIN_id=lid)
#                 p.save()
#
#
#
#             return JsonResponse({'status': 'ok', 'match': match})
#
#         except Exception as e:
#             return JsonResponse({'status': 'error', 'message': str(e)})
#
#     return JsonResponse({'status': 'invalid_request'})


from django.http import JsonResponse
import base64, os, subprocess
from datetime import datetime
from django.conf import settings
from .models import motion_task, Progress, Patient

def compare_pose(request):
    if request.method == 'POST':
        try:
            image_base64 = request.POST.get('image')
            task_id = request.POST.get('id')
            lid = request.POST.get('lid')

            if not image_base64 or not task_id or not lid:
                return JsonResponse({'status': 'error', 'message': 'Missing required parameters'})

            # Get reference image path
            task = motion_task.objects.get(id=task_id)
            reference_filename = task.image.replace("/media/photo/", "")
            reference_path = os.path.join(settings.MEDIA_ROOT, 'photo', reference_filename)

            if not os.path.exists(reference_path):
                return JsonResponse({'status': 'error', 'message': 'Reference image not found'})

            # Save captured image
            captured_path = os.path.join(settings.MEDIA_ROOT, 'captured.jpg')
            with open(captured_path, "wb") as fh:
                fh.write(base64.b64decode(image_base64))

            # Run external gesture comparison script
            result = subprocess.run(
                ['C:\\Python38\\python.exe', 'C:\\Users\\user\\PycharmProjects\\elderlycare\\my_project\\hand.py', captured_path, reference_path],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                universal_newlines=True
            )

            output_lines = result.stdout.strip().splitlines()
            output = output_lines[-1].strip().lower() if output_lines else ''
            match = output == "match"

            # Get the patient object
            patient = Patient.objects.get(LOGIN_id=lid)

            # Save progress
            Progress.objects.create(
                title='Task to perform',
                date=datetime.now().date(),
                time=datetime.now().time(),
                result='Pass' if match else 'Fail',
                PATIENT=patient
            )

            return JsonResponse({'status': 'ok', 'match': match})

        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)})

    return JsonResponse({'status': 'invalid_request'})



# def view_emotion_graph_post(request):
#     pid = request.POST['pid']
#
#     def get_sum(emotion_name):
#         result = Emotion.objects.filter(PATIENT_id=pid, name=emotion_name).aggregate(total=Sum())
#         return result['total'] or 0
#
#     surprised = get_sum("surprised")
#     sad = get_sum("sad")
#     neutral = get_sum("neutral")
#     happy = get_sum("happy")
#     fareful = get_sum("fareful")  # Assuming 'fearful' is misspelled here
#     disgusted = get_sum("disgusted")
#     angry = get_sum("angry")
#
#     return JsonResponse({
#         'status': 'ok',
#         'surprised': surprised,
#         'sad': sad,
#         'neutral': neutral,
#         'happy': happy,
#         'fareful': fareful,
#         'disgusted': disgusted,
#         'angry': angry,
#     })


# def view_emotion_graph_post(request):
#     pid=request.POST['pid']
#     surprised=Emotion.objects.filter(PATIENT_id=pid,name="surprised").SUM()
#     sad=Emotion.objects.filter(PATIENT_id=pid,name="sad").SUM()
#     neutral = Emotion.objects.filter(PATIENT_id=pid, name="neutral").SUM()
#     happy = Emotion.objects.filter(PATIENT_id=pid, name="happy").SUM()
#     fareful = Emotion.objects.filter(PATIENT_id=pid, name="fareful").SUM()
#     disgusted = Emotion.objects.filter(PATIENT_id=pid, name="disgusted").SUM()
#     angry = Emotion.objects.filter(PATIENT_id=pid, name="angry").SUM()
#
#     return JsonResponse({'status': 'ok', 'surprised': surprised , 'sad' : sad,
#                          'neutral':neutral, 'happy': happy, 'fareful':fareful,
#                          'disgusted': disgusted, 'angry': angry,
#
#                          })

def view_emotion_graph_post(request):
    pid = request.POST['pid']

    def count_emotion(emotion_name):
        return Emotion.objects.filter(PATIENT_id=pid, name=emotion_name).count()

    surprised = count_emotion("surprised")
    sad = count_emotion("sad")
    neutral = count_emotion("neutral")
    happy = count_emotion("happy")
    fearful = count_emotion("fear")  # double-check if it's "fearful" or "fareful"
    disgusted = count_emotion("disgusted")
    angry = count_emotion("angry")

    print(surprised,sad,neutral,happy,fearful,disgusted,angry)

    return JsonResponse({
        'status': 'ok',
        'surprised': surprised,
        'sad': sad,
        'neutral': neutral,
        'happy': happy,
        'fearful': fearful,
        'disgusted': disgusted,
        'angry': angry,
    })