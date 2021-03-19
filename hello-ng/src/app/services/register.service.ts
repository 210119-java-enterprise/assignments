import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { environment as env } from 'src/environments/environment';
import { Principal } from '../models/principal';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class RegisterService {


  RegisterUser(username: string, password: string, fname:string, lname:string, email:string): Promise<Principal> {
    console.log('in authservice.authenticateUser', username, password);
    return this.http.post(env.API_URL + '/users/register', {username, password,fname,lname,email}, {
      headers: {
        'Content-Type': 'application/json'
      },
      observe: 'response'
    }).pipe(
      map(resp => {
        let principal = resp.body as Principal;
        this.currentUserSubject.next(principal);
        return principal;
      })
    ).toPromise();
  }




  constructor() { }
}
