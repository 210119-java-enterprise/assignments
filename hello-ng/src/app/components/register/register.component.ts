import { Component, ComponentFactoryResolver, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {


  registerForm: FormGroup;
  loading = false;
  submitted = false;
  RegisterSuccess = false;

   ngOnInit() { }

  constructor(private formBuilder: FormBuilder,
    private authService: AuthService,
    private router: Router) {
    console.log('reg0) LoginComponent constructor was invoked!');

    console.log('reg1) Initializing form values for LoginComponent...');

    this.registerForm = this.formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required],
      fname: ['', Validators.required],
      lname: ['', Validators.required],
      email: ['', Validators.required],

    });

    console.log('reg2) Initialization of LoginComponent form values complete');
  }

  get formFields() {
    return this.registerForm.controls;
  }

  register = async () => {

    if (this.registerForm.invalid) {
      console.log('reg3) The form is invalid!');
      console.log(this.formFields.username.errors)
      return;
    }

    this.loading = true;

    this.submitted = true;
    let un = this.formFields.username.value;
    let pw = this.formFields.password.value;
    let em = this.formFields.email.value;
    let fn = this.formFields.fname.value;
    let ln = this.formFields.lname.value;


    console.log('reg4) in RegisterComponent.login', un, pw);

    try {
      await this.authService.authenticateUser(un, pw);
      this.loading = false;
      this.router.navigate(['/dashboard']);
    } catch (e) {
      console.log('reg5) Registration failed!');
      console.error(e);
      this.loading = false;
    }

  }






}
