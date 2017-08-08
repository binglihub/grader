// Copyright (c) 2017, bing. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular_components/angular_components.dart';
import 'dart:html';

class RubricContent{
  final String content;
  final double point;
  bool selected=false;
  RubricContent(this.content,this.point);
}


// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives,CORE_DIRECTIVES],
  providers: const [materialProviders],
)
class AppComponent {
  int status = 0;
  List<RubricContent> rubric_list = [];
  

  String rubric_content = "";
  String rubric_point = "";
  double total_points = 0.0;

  void add(){
    rubric_list.add(new RubricContent(rubric_content, double.parse(rubric_point)));
    rubric_content = "";
    rubric_point = "";
    total_points = getTotal();
    querySelector("#rubric_content").focus();
    
  }
  double getTotal() => rubric_list.isEmpty?0.0:rubric_list.map((x)=>x.point).reduce((a,b)=>a+b);

  void focusOnPoint() => querySelector("#rubric_point").focus();

  void rubric_reset(){
    rubric_list = [];
    rubric_point = "";
    rubric_content = "";
    total_points = 0.0;
  }

  void complete(){
    status = 1;
    rubric_list.forEach((x)=>x.selected=false);
  }

  void report_reset()=>rubric_list.forEach((x)=>x.selected=false);

  void output(){
    String out = "";
    rubric_list.forEach((x){
      if(x.selected) out+=x.content+" -"+x.point.toString()+"\n";
    });
    querySelector("#report").innerHtml=out;
  }
}
