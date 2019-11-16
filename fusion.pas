type
  TArray = array[1..100] of integer;
  TVector = record
    vector: TArray;
    length: integer;
end;
  TVector2D = record
    vector1: TVector;
    vector2: TVector;
end;
var 
i,j:integer;

procedure afficher_vec(vec:TVector);
begin
	//writeln('affiche');
	for i := 1 to vec.length do
		begin
		writeln(vec.vector[i]);
		//writeln(i);
		end;
end;
function car(vec:TVector):integer;
begin
	car := vec.vector[1];
end;

function cdr(vec:TVector):TVector;
begin
	for i := 2 to vec.length do
		cdr.vector[i - 1] := vec.vector[i];
	cdr.length := vec.length - 1;
end;

function cons(tete:integer; vec:TVector):TVector ;

begin
	//writeln('cons');
	cons.vector[1] := tete;
	cons.length := vec.length + 1;
	for i := 1 to vec.length do
		cons.vector[i + 1] := vec.vector[i];
	
	//afficher_vec(cons);
end;

function separer(vec:TVector):TVector2D ;
begin
	separer.vector1.length := 0;
	separer.vector2.length := 0;
	for i := 1 to trunc((vec.length + 1)/ 2) do
	begin
		separer.vector1.vector[i] := vec.vector[i];
		separer.vector1.length := separer.vector1.length  + 1;
	end;

	separer.vector1.length := trunc((vec.length + 1)/ 2) ;
	j := 1;
	for i := trunc((vec.length + 1)/ 2 )+ 1 to vec.length do
		begin
			
			separer.vector2.vector[j] := vec.vector[i];
			j := j + 1;
			separer.vector2.length := separer.vector2.length + 1;
		end;
end;

function fusionner(vec1:TVector; vec2:TVector):TVector ;
begin
	if vec1.length <= 0 then
		begin
		fusionner := vec2;
		end

	else 
	begin
		if vec2.length <= 0 then
			
				fusionner := vec1

		
			//writeln('fusionner');
		else 
			begin
				if car(vec1) < car(vec2) then
					begin
					//writeln('fusionner');
						//afficher_vec(vec1);
						//afficher_vec(vec2);
						fusionner := cons(car(vec1), fusionner( cdr(vec1) , vec2 ));
						
					end
			else 
				begin
				//writeln('fusionner');
				//afficher_vec(vec1);
				//afficher_vec(vec2);
				fusionner := cons(car(vec2), fusionner( cdr(vec2) , vec1 ));
				
				end
			end;
	end;

end;

function tri_fusion(vec:TVector):TVector ;
begin
	//writeln('tri_fusion');
	//afficher_vec(vec);
	if (vec.length <= 1) then
		tri_fusion := vec
	else 
		begin
			tri_fusion := fusionner( tri_fusion( separer(vec).vector1) , tri_fusion( separer(vec).vector2) );
		end;
end;

var
vec:TVector;
begin
	vec.length := 4;
	vec.vector[1] := 3;
	vec.vector[2] := 10;
	vec.vector[3] := 18;
	vec.vector[4] := 19;
	afficher_vec(tri_fusion(vec));


end.