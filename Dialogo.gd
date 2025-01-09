extends CanvasLayer
var falas = [
{'personagem': 'chamito_01', 'dizecao':"EU TE ODEIO APPLEJACK"},
{'personagem': 'applejack_02', 'dizecao':"apples"},
{'personagem': 'applejack_01', 'dizecao':"YEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEHAAAAAAAAAAAAAAAAAAAAAAWWWWWWW"},
{'personagem': 'chamito_01', 'dizecao':"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean a porta sem. In at lacinia elit, nec pharetra erat afnawfbaufbfubafuabfaufaubfaubfuwbfaubfauwbfuawbfuawbfuawbfuawbfauwbfaubfaubfauwbfaubfawufbawufbawufbauwbfaubfauwbfau."},
]
var letra = 0
var falaAtual = -1
var Boneco1 = true
var nextPersonagem
var clicavel
# Called when the node enters the scene tree for the first time.
func _ready():
	falaNova()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func refatorarFala():
	var fala = falas[falaAtual].dizecao
	for i in range(1, fala.length()):
		if i % 100 == 0:
			falas[falaAtual].dizecao = falas[falaAtual].dizecao.insert(i, '\n')

func falaNova():
	if(falaAtual+1 < falas.size()):
		falaAtual += 1
		refatorarFala()
		$Dialogo.text = ""
		letra = 0
		var personagem = falas[falaAtual].personagem.get_slice('_', 0)
		if falaAtual+1 < falas.size():
			nextPersonagem = falas[falaAtual+1].personagem.get_slice('_', 0)
		else: 
			nextPersonagem = null
		var personagemSrc = falas[falaAtual].personagem
		if Boneco1:
			$Boneco1.modulate = Color(1,1,1)
			$Boneco1.texture = load("res://Sprites/"+personagemSrc+".png")
			$Boneco1.z_index = 1
			$Boneco2.z_index = 0
			$Boneco2.modulate = Color(0.5,0.5,0.5)
			if nextPersonagem != personagem:
				Boneco1 = false
		else:
			$Boneco2.modulate = Color(1,1,1)
			$Boneco2.texture = load("res://Sprites/"+personagemSrc+".png")
			$Boneco2.z_index = 1
			$Boneco1.z_index = 0
			$Boneco1.modulate = Color(0.5,0.5,0.5)
			if nextPersonagem != personagem:
				Boneco1 = true
		$Dialogo/Timer.start()

func _on_timer_timeout():

	var fala = falas[falaAtual].dizecao

	if $Dialogo.text != fala:
		$Dialogo.text += fala[letra]
		letra += 1
		$Dialogo/Timer.start()
	pass # Replace with function body.


func _on_dialogo_button_up():
	if $Dialogo.text != falas[falaAtual].dizecao:
		$Dialogo.text = falas[falaAtual].dizecao
	else:
		falaNova()
	pass # Replace with function body.
