<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
function resize(obj) {
    obj.style.height = '1px';
    obj.style.height = (12 + obj.scrollHeight) + 'px';
}

//숫자 세자리마다 콤마붙이는 함수
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
} 

function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

function inputOnlyNumberFormat(obj) {
    obj.value = onlynumber(uncomma(obj.value));
}

function onlynumber(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1');
}

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">후원모금신청</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   
   <!-- contact form -->
      <div class="container" align="center" style="padding-top: 50px">
               <div class="contact-form " >
               <p>
                        <span style="font-size:15px"><b>목표금액</b></span>
                        <input type="text" maxlength="10" onkeyup="inputNumberFormat(this);" placeholder="목표금액(원)" name="amount" id="amount" style="width: 250px; font-size: 15px">&nbsp;&nbsp;
                        <span style="font-size:15px"><b>후원마감일 지정</b></span>
                        <input type="date" placeholder="마감일" name="phone" id="phone" style="width: 250px; font-size: 15px"><br/>
                        <span style="display: inline-block; width: 50%; text-align: left;">*최소50만원~ 최대 1000만원</span>
                     </p>
                  <form type="POST" id="fruitkha-contact" onSubmit="return valid_datas( this );">
                     <p>
                        <input type="text" placeholder="이름" name="name" id="name" style="width: 730px; font-size: 20px" value="홍길동">
                     </p>
                      <p>
                        <input type="text" placeholder="제목" name="name" id="name" style="width: 730px; font-size: 20px">
                     </p>
                     <p><textarea name="message" id="message" cols="30"  placeholder="신청내용" style="width: 730px; font-size: 20px"></textarea></p>
               <p>       
                     <!-- 이미지 미리보기 시작 -->
                       <div id='image_preview'>
                         <input type='file' id='btnAtt' multiple='multiple'/><br/>
                         <div id='att_zone'
                           data-placeholder='파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 드래그앤드롭 하세요'></div>
                       </div>
                       
                          <script type="text/javascript">
                          ( /* att_zone : 이미지들이 들어갈 위치 id, btn : file tag id */
                          imageView = function imageView(att_zone, btn){
               
                            var attZone = document.getElementById(att_zone);
                            var btnAtt = document.getElementById(btn)
                            var sel_files = [];
                            
                            // 이미지와 체크 박스를 감싸고 있는 div 속성
                            var div_style = 'display:inline-block;position:relative;'
                                          + 'width:150px;height:120px;margin:5px;border:1px solid #00f;z-index:1';
                            // 미리보기 이미지 속성
                            var img_style = 'width:100%;height:100%;z-index:none';
                            // 이미지안에 표시되는 체크박스의 속성
                            var chk_style = 'width:30px;height:30px;position:absolute;'
                                          + 'right:0px;bottom:0px;z-index:999;background-color:white;color:black';
                          
                            btnAtt.onchange = function(e){
                              var files = e.target.files;
                              var fileArr = Array.prototype.slice.call(files)
                              for(f of fileArr){
                                imageLoader(f);
                              }
                            }  
                            
                          
                            // 탐색기에서 드래그앤 드롭 사용
                            attZone.addEventListener('dragenter', function(e){
                              e.preventDefault();
                              e.stopPropagation();
                            }, false)
                            
                            attZone.addEventListener('dragover', function(e){
                              e.preventDefault();
                              e.stopPropagation();
                              
                            }, false)
                          
                            attZone.addEventListener('drop', function(e){
                              var files = {};
                              e.preventDefault();
                              e.stopPropagation();
                              var dt = e.dataTransfer;
                              files = dt.files;
                              for(f of files){
                                imageLoader(f);
                              }
                              
                            }, false)
                            
               
                            
                            /*첨부된 이미지들을 배열에 넣고 미리보기 */
                            imageLoader = function(file){
                              sel_files.push(file);
                              var reader = new FileReader();
                              reader.onload = function(ee){
                                let img = document.createElement('img')
                                img.setAttribute('style', img_style)
                                img.src = ee.target.result;
                                attZone.appendChild(makeDiv(img, file));
                              }
                              
                              reader.readAsDataURL(file);
                            }
                            
                            /*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환 */
                            makeDiv = function(img, file){
                              var div = document.createElement('div')
                              div.setAttribute('style', div_style)
                              
                              var btn = document.createElement('input')
                              btn.setAttribute('type', 'button')
                              btn.setAttribute('value', 'x')
                              btn.setAttribute('delFile', file.name);
                              btn.setAttribute('style', chk_style);
                              btn.onclick = function(ev){
                                var ele = ev.srcElement;
                                var delFile = ele.getAttribute('delFile');
                                for(var i=0 ;i<sel_files.length; i++){
                                  if(delFile== sel_files[i].name){
                                    sel_files.splice(i, 1);      
                                  }
                                }
                                
                                dt = new DataTransfer();
                                for(f in sel_files) {
                                  var file = sel_files[f];
                                  dt.items.add(file);
                                }
                                btnAtt.files = dt.files;
                                var p = ele.parentNode;
                                attZone.removeChild(p)
                              }
                              div.appendChild(img)
                              div.appendChild(btn)
                              return div
                            }
                          }
                        )('att_zone', 'btnAtt')
                     </script>
                     <!-- 이미지 미리보기 끝 -->
                </p>
                     <input type="hidden" name="token" value="" />
                     <div align="center">
                     <input type="submit" value="신청하기" style="background-color:#FFCC80; color:#554838; font-size: 20px; align-content: center;">&nbsp;&nbsp;
                     <input type="submit" value="취소" style="background-color:#FFCC80; color:#554838; font-size: 20px; align-content: center;">
                     </div>
                  </form>
            <!-- 
            <div class="col-lg-4">
               <div class="contact-form-wrap">
                  <div class="contact-form-box">
                     <h4><i class="fas fa-map"></i> Shop Address</h4>
                     <p>34/8, East Hukupara <br> Gifirtok, Sadan. <br> Country Name</p>
                  </div>
                  <div class="contact-form-box">
                     <h4><i class="far fa-clock"></i> Shop Hours</h4>
                     <p>MON - FRIDAY: 8 to 9 PM <br> SAT - SUN: 10 to 8 PM </p>
                  </div>
                  <div class="contact-form-box">
                     <h4><i class="fas fa-address-book"></i> Contact</h4>
                     <p>Phone: +00 111 222 3333 <br> Email: support@fruitkha.com</p>
                  </div>
               </div>
            </div>
             -->
         </div>
      </div>
   <br>
   <!-- end contact form -->
</body>
</html>