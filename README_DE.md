# ClipDistanceControl
Dies ist ein Skript für das Spiel Landwirtschaft Simulator 17. Der Zweck dieses Skripts besteht darin, die "clip distance" (auch als Sichtweite oder draw distance bezeichnet) eines Objekts oder Fahrzeugs zu steuern, das sich innerhalb des zugeordneten Triggers befindet. Wie die GIANTS-Engine Objekte rendert, rendert sie auch, wenn sie für den Spieler nicht sichtbar sind (z.B. eine unterbrochene Sichtlinie oder durch eine Fahrzeughalle blockiert). Das Reduzieren der clip distance die Fahrzeuge und Objekte, wenn sie sich in diesem trigger befinden, kann die performance des Spiels stark erhöhen. Während und nach der Arbeit an dem Skript wurde es von [Northside Farming Group](https://www.fs-uk.com/forum/index.php?topic=182644.0) seit Monaten gründlich getestet, was bedeutet, dass dieses Skript MP-kompatibel sein sollte. Das Erstellen dieses Skripts war die Idee von SneakyBeaky und basiert auf der FS15-Version, deren Autor mir unbekannt ist. Wenn Sie wissen, wer der ursprüngliche Autor ist, lassen Sie es mich bitte wissen. Dieses Skript muss auf einer Karte eingebaut werden.

## Implementierung

Wenn Sie dieses Skript auf Ihrer Karte implementieren möchten, lesen Sie bitte den Abschnitt zum [Copyright](#copyright) dieser README. Es gibt nur ein paar einfache Regeln, die sicherstellen, dass der Ursprung des Skripts immer gefunden werden kann.

**Hinzufügen der Triggerform**
- Fügen Sie Ihrer Karte eine Form hinzu. Ich würde vorschlagen, einfach auf "**Create > Primitive> Cube**" im Giants-Editor-Menü zu klicken.
- Ändern Sie im 'Attributes'-fenster die **Scale X / Y / Z** -Werte, so dass der trigger die gewünschte Größe hat, und aktivieren Sie das Kontrollkästchen "**Rigid Body**".
- Gehen Sie auf die Tab "**Rigid Body**" und kreuzen Sie die Kästchen "Collision" und "Trigger" an und setzen Sie **56031c2** im '**Collision Mask**' Textfeld. Klicken Sie auf die Knopf hinter diesem Textfeld, um zu überprüfen, ob die folgenden Nummern ein Häkchen haben: 1, 6, 7, 8, 12, 13, 21, 22, 24 und 26.
- Wechseln Sie zum Tab "**Shape**" und aktivieren Sie das Kontrollkästchen '**Non Renderable**'.

## Das Skript und die richtigen Einstellungen hinzufugen
- Wenn der trigger ausgewählt ist, öffnen Sie das Fenster '**User Attributes**'.
- Fügen Sie ein neues Attribut namens '**onCreate**' hinzu, geben Sie '**Script Callback**' ein und setzen Sie es auf '**modOnCreate.clipDistanceControl**'
- Fügen Sie ein weiteres neues Attribut namens '**innerClipDistance**' mit dem Typ '**Integer**' hinzu. Stellen Sie dies auf die clip distance in Metern ein, die Sie für diesen Trigger verwenden möchten. Denken Sie daran, wenn der Abstand zwischen Ihnen (dem Spieler) und dem Objekt im trigger größer ist als die eingegebene Distanz, ist er nicht sichtbar. Wenn dieses Attribut nicht festgelegt ist, wird der clip distance auf 300 festgelegt, wodurch der Effekt stark reduziert wird.

## ModDesc
Vergessen Sie nicht, den folgenden Abschnitt zu Ihrem modDesc hinzuzufügen, irgendwo zwischen den modDesc xml nodes.
```
<extraSourceFiles>
  <sourceFile filename="scripts/clipDistanceControl.lua"/>
</extraSourceFiles>
```
Für das Obige muss das Skript in einem Ordner namens "scripts" sein, in der Stammordner Ihrer map gestellt. Wenn Sie in Ihrem modDesc bereits den nodes 'extraSourceFiles' haben, fügen Sie nur den node 'sourceFile' hinzu.

## Anmerkungen
Wiederholen Sie diesen Vorgang für jeden Trigger. Bei allen angegebenen Namen wird zwischen Groß- und Kleinschreibung unterschieden. Vergiss nicht, nach dem Ändern der Werte in GE die Enter-Taste zu drücken, speichere regelmäßig usw. Das Fenster 'Attribute' und 'Benutzerattribute' kann durch Klicken auf 'Window> Attributes' und 'Window > User Attributes' im GE-Menü geöffnet werden .

Wenn Leute Probleme mit der Implementierung dieses Skripts haben, kann ich Screenshots hinzufügen, um einige Aussagen zu klären, lass es mich wissen.

## Copyright
Copyright (c) Timmiej93, 2018. All rights reserved.

Dieses Script kann in **`jeder`** Karte ohne spezielle Erlaubnis verwendet werden. Eine Karte, die dieses Skript enthält, kann auch **`ohne Einschränkungen`** verteilt werden. Anrechnen ist **`nicht erforderlich`**, aber es wäre schön. Das Skript kann jedoch **`nicht`** als dein eigenes Werk beansprucht werden.  
Der Kommentarblock am Anfang der Datei (Zeile 1 bis 44) kann jedoch **`nicht`** entfernt werden (es ist auch nicht nötig, ihn zu entfernen), um sicherzustellen, dass jeder mit Fragen den ursprünglichen Autor finden kann, und sich bei mir beschweren kann, anstelle bei Ihnen, der Kartenhersteller.

Disclaimer: Durch die Verwendung des auf dieser Website verfügbaren Codes erklären Sie sich damit einverstanden, dass Sie diesen Code ausschließlich auf Ihr eigenes Risiko verwenden. Der Code wird ohne irgendeine Form von Garantie geliefert, und ich (Timmiej93) lehne hiermit jede Form von Garantie ab.

Ich (Timmiej93) habe dieses Skript geschrieben, und ich halte das Urheberrecht an dieses Skript. Das bedeutet einfach, dass der Code mir gehört. Es bedeutet auch, dass Sie diesen Code nicht nur für Ihre eigenen Projekte verwenden können. Jeder Beitrag wird zu meinem Eigentum, sobald er festgeschrieben ist, sonst wäre ich nicht in der Lage, diese Änderungen zu veröffentlichen. Wenn dein Computer aufgrund dieses Mods abstürzt oder auf andere Weise beschädigt wird, kannst du es mir sagen, und ich werde versuchen, es für dich zu reparieren. Ich übernehme keine Verantwortung für irgendwelche Schäden.