# PRD — CLI token_evaluate per Stima Token Output JSON

## Titolo
CLI bash `token_evaluate` per stimare automaticamente il numero medio di token necessari per rappresentare un singolo item JSON generato da un LLM a partire da un blocco HTML strutturato

## Obiettivo
Fornire una CLI semplice e riutilizzabile che automatizzi completamente la stima dei token prodotti da un modello LLM nel generare un oggetto JSON strutturato da un blocco di input HTML. La CLI restituisce direttamente un numero intero rappresentante la stima media dei token, facilitando l'integrazione in script e pipeline di automazione.

## Contesto
- Gli input consistono in blocchi HTML che rappresentano schede con dati strutturati (es. provincia, comune, centro, indirizzo, contatti, orari).
- L'output desiderato è un oggetto JSON strutturato contenente i campi chiave.
- L'analisi serve a stimare **quanti token vengono prodotti mediamente per ciascun item JSON** generato da un LLM.

## Stack Tecnologico
- **CLI `token_evaluate`** script bash principale che orchestra il processo
- **LLM CLI** per eseguire il modello linguistico tramite template YAML
- **Template YAML `token_output`** per definire comportamento e struttura dell'output
- **`ttok` CLI** per misurare il numero di token dell'output
- **Bash utilities** per elaborazione dati e calcolo della media

## Metodo

### Sintassi della CLI
```bash
token_evaluate file_input "istruzioni su cosa si vuole estrarre"
```

### Parametri
- **file_input**: file HTML contenente i blocchi strutturati da analizzare
- **istruzioni**: stringa con le istruzioni specifiche su quali campi estrarre (es. "vorrei estrarre provincia, comune, centro, indirizzo, contatti e orari. Estrai un elemento qualsiasi non il primo")

### Funzionamento Interno
1. **Elaborazione**: La CLI esegue internamente il comando:
   ```bash
   cat file_input | llm -t token_output -p istruzioni "istruzioni_utente" | ttok
   ```

2. **Ripetizione**: Per garantire affidabilità, la CLI esegue il processo **3 volte**

3. **Calcolo Media**: Calcola automaticamente la media dei token ottenuti dalle 3 esecuzioni

4. **Output**: Restituisce un singolo numero intero rappresentante la stima media

### Esempio d'Uso
```bash
token_evaluate sample/input_01.html "vorrei estrarre provincia, comune, centro, indirizzo, contatti e orari. Estrai un elemento qualsiasi non il primo"
# Output: 142
```

## Output Atteso

- **Numero intero**: valore medio dei token stimati per singolo JSON estratto
- **Formato minimale**: output diretto senza header o formattazione aggiuntiva
- **Riproducibilità**: risultati consistenti attraverso multiple esecuzioni
- **Integrazione**: output facilmente utilizzabile in script e pipeline bash

## Benefici

- **Semplicità d'uso**: interfaccia CLI intuitiva con soli 2 parametri
- **Automazione completa**: elimina step manuali, calcolo automatico della media
- **Integrazione in pipeline**: output numerico facilmente utilizzabile in script bash
- **Misura realistica**: basata su comportamento reale del modello LLM
- **Stima costi precisa**: facilita calcoli di costo (token × item × dataset size)
- **Riproducibilità**: risultati consistenti e affidabili

## Estensioni Future

- **Supporto modelli multipli**: parametro `-m` per specificare modello LLM (`gpt-4`, `gpt-3.5-turbo`)
- **Configurazione iterazioni**: parametro `-n` per cambiare numero di ripetizioni (default: 3)
- **Output dettagliato**: flag `-v` per mostrare risultati delle singole esecuzioni
- **Template personalizzati**: parametro `-t` per specificare template diversi da `token_output`
- **Batch processing**: supporto per elaborazione di più file in parallelo
