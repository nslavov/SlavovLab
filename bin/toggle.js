
function toggle(item) {
obj=document.getElementById(item);
visible=(obj.style.display!="none")
key=document.getElementById("ctrl_" + item);
if (visible) {
    obj.style.display="none";
	key.innerHTML=item;
}
else {
	obj.style.display="block";
	key.innerHTML="[-] Hide";
}
}