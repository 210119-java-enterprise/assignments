import { Injectable } from '@angular/core';
import { InMemoryDbService } from 'angular-in-memory-web-api';
import { Hero } from '../hero';

@Injectable({
  providedIn: 'root',
})
export class InMemoryDataService implements InMemoryDbService {
  createDb() {
    const heroes = [
      {id: 11, name: 'Levi Ackermann'},
      {id: 12, name: 'Captain America'},
      {id: 13, name: 'Thanos'},
      {id: 14, name: 'Groot'},
      {id: 15, name: 'Batman'},
      {id: 16, name: 'Wonder Woman'},
      {id: 17, name: 'Mystique'},
      {id: 18, name: 'Sonic'},
      {id: 19, name: 'Link'},
      {id: 20, name: 'Mythra'}
    ];
    return {heroes};
  }

  // Overrides the genId method to ensure that a hero always has an id.
  // If the heroes array is empty,
  // the method below returns the initial number (11).
  // if the heroes array is not empty, the method below returns the highest
  // hero id + 1.
  genId(heroes: Hero[]): number {
    return heroes.length > 0 ? Math.max(...heroes.map(hero => hero.id)) + 1 : 11;
  }
}