# Design tokens — GeoField (Figma)

Todos os valores abaixo foram extraídos das respostas do Figma (`get_metadata`, `get_design_context`, `get_variable_defs` e `get_screenshot`) para o arquivo informado. Onde o Figma não definiu um valor, isso está registrado explicitamente como “não definido no frame” — nenhum valor foi inventado.

## 1. Origem e escopo

- URL: `https://www.figma.com/design/sK9fKMKrVj3VOrKtN67inI/GeoField-%E2%80%94-App?node-id=0-1&p=f&t=5Hnv7MmGHnO2t2zj-0`
- `fileKey`: `sK9fKMKrVj3VOrKtN67inI`
- Páginas: `0:1` (Page 1) e `45:2` (GeoField — Proposta 2)
- Frames lidos: `45:3` (01 — Tela inicial), `45:20` (02 — Login), `45:41` (03 — Mapa de campo), `45:91` (04 — Levantamentos), `80:51` (Login — GeoField), `93:429` (Detalhes do levantamento — GeoField)
- Dimensão dos frames de celular: `390 × 844 px`
- Screenshot solicitado para `80:51`: `390 × 844 px`, formato PNG. A leitura visual do PNG não foi possível neste ambiente; os valores abaixo vêm das propriedades textuais retornadas pelo Figma.
- `get_variable_defs` em `45:20` retornou `{}`; `search_design_system` não retornou componentes, variáveis nem estilos nomeados. Portanto, os tokens abaixo vêm dos valores literais aplicados nos nós.

## 2. Tokens de cores (hex extraídos)

| Hex | Uso observado | Nós de origem |
|---|---|---|
| `#f7f7f2` | Fundo das telas iniciais, login, mapa e levantamentos | `45:3`, `45:20`, `45:41`, `45:91`, `80:51` |
| `#ffffff` | Fundo do frame de detalhes e da navegação inferior; fallback da variável `--backgrounds/primary` | `93:429`, `93:596` |
| `#fffffa` | Fundo de cards, campo de busca e navegação na Proposta 2 | `45:91`, `45:41` |
| `#f5f5ed` | Fundo do cartão principal de levantamento | `93:579` |
| `#edf1ea` | Fundo dos campos de e-mail e senha | `80:68`, `80:72` |
| `#edf3ee` | Fundo do botão “Consultar anotações” | `93:588` |
| `#eaf2e9` | Pílulas “Offline disponível”, “Sincronizado”, “4 pontos”, “GPS ±5 m” e terrenos do mapa | `45:46`, `45:114`, `45:63`, `45:65`, `45:51`, `45:53` |
| `#dae6d0` | Base do mapa | `45:49` |
| `#c3d5bc` | Terrenos do mapa | `45:50`, `45:52` |
| `#e2e7e2` | Bordas e divisor no frame de detalhes | `93:429`, `93:450`, `93:579`, `93:596` |
| `#e0e6e0` | Bordas de cards, campo de busca e navegação na Proposta 2 | `45:96`, `45:100`, `45:126` |
| `#7b857d` | Borda inferior dos campos de acesso | `80:68`, `80:72` |
| `#1f2723` | Texto primário, status do relógio e indicador de navegação | `45:21`, `45:94`, `80:64`, `93:436`, `80:91` |
| `#234b3a` | Verde usado em login e detalhes: marca, links, botão primário, botões secundários | `80:62`, `80:82`, `80:87`, `93:449`, `93:587`, `93:588` |
| `#18583d` | Verde usado na Proposta 2 e no mapa: botão principal, ícones, pílulas | `45:47`, `45:102`, `45:124`, `45:133`, `45:70` |
| `#2e7a52` | Status “Levantamento finalizado” e item ativo da navegação em detalhes | `93:437`, `93:537` |
| `#68716c` | Texto secundário nos frames reformulados (login e detalhes) | `80:65`, `80:85`, `93:446`, `93:452`, `93:542` |
| `#68716a` | Texto secundário na Proposta 2 e no mapa | `45:95`, `45:104`, `45:128` |
| `#fff2e0` | Fundo das pílulas “Em andamento” e “Pendente” | `45:106`, `45:122` |
| `#f48b39` | Texto das pílulas “Em andamento” e “Pendente” | `45:107`, `45:123` |
| `var(--backgrounds/primary, white)` → `#ffffff` | Texto do botão primário no login | `80:83` |
| `var(--grays/white, white)` → `#ffffff` | Texto do botão “Ver pontos no mapa” | `93:519` |

## 3. Tipografia

Família: `Inter` (declarada como `font-['Inter:...']` em todos os textos lidos).

Pesos retornados pelo Figma:

| Classe Figma | Peso | Nome exibido |
|---|---|---|
| `font-normal` | 400 | Regular |
| `font-medium` | 500 | Medium |
| `font-semibold` | 600 | Semi Bold |

Tamanhos, pesos e line-heights extraídos:

| Tamanho | Peso | Line-height | Cor | Exemplo / origem |
|---|---|---|---|---|
| 9 px | Semi Bold | `normal` | `#18583d` | Rótulos P01–P04 no mapa (`45:56`, `45:58`, `45:60`, `45:62`) |
| 9 px | Regular | `normal` | `#68716a` | Rótulos da navegação na Proposta 2 (`45:128`, `45:130`) |
| 10 px | Medium | `normal` | `#1f2723` | Status do relógio (`45:22`) |
| 10 px | Medium | `normal` | `#18583d` | Pílulas “Offline disponível”, “4 pontos”, “GPS ±5 m” (`45:47`, `45:64`, `45:66`) |
| 10 px | Medium | `normal` | `#f48b39` | Pílulas “Em andamento” e “Pendente” (`45:107`, `45:123`) |
| 10 px | Medium | `normal` | `#18583d` | Pílula “Sincronizado” (`45:115`) |
| 11 px | Semi Bold | `normal` | `#1f2723` | Status do relógio em Proposta 2 (`45:92`) |
| 11 px | Regular | `normal` | `#68716a` | Metadados “12 pontos · 2 fotos” (`45:105`) |
| 11 px | Regular | 14 px | `#68716c` | Coordenadas dos pontos (`93:468`, `93:477`) |
| 11 px | Semi Bold | `normal` | `#ffffff` | “Ver imagens registradas” (`I79:46;93:519`) |
| 12 px | Regular | 16 px | `#68716c` | Rótulos “E-mail” e “Senha” (`80:70`, `80:74`) |
| 12 px | Regular | `normal` | `#68716a` | Subtítulos de tela (`45:95`, `45:45`) |
| 12 px | Regular | `normal` | `#68716c` | Data “24 set” (`93:447`); assinatura (`80:89`) |
| 12 px | Regular | `normal` | `#2e7a52` | Status “Levantamento finalizado” (`93:437`) |
| 12 px | Semi Bold | 20 px | `#234b3a` | “Esqueci minha senha” (`80:80`), “Criar conta” (`80:87`) |
| 12 px | Semi Bold | `normal` | `#234b3a` | “Consultar anotações” (`93:523`), “Exportar CSV” (`93:526`) |
| 12 px | Regular | `normal` | `#68716c` | Itens inativos da navegação (`93:542`) |
| 12 px | Semi Bold | `normal` | `#2e7a52` | Item ativo “Levantamentos” (`93:537`) |
| 13 px | Semi Bold | 15 px | `#1f2723` | Identificação P01–P06 (`93:467`, `93:476`) |
| 13 px | Semi Bold | `normal` | `#fffffa` | Botão “Novo levantamento” (`45:125`) |
| 14 px | Regular | 24 px | `#68716c` | “Entre para continuar seus levantamentos em campo.” (`80:65`) |
| 14 px | Semi Bold | 20 px | `#234b3a` | “Esqueci minha senha” e “Criar conta” (`80:80`, `80:87`) |
| 14 px | Regular | 20 px | `#68716c` | “Ainda não tem conta?” (`80:85`) |
| 14 px | Regular | `normal` | `#68716c` | Localização no cartão (`93:446`) |
| 14 px | Semi Bold | `normal` | `#1f2723` | Título do card de levantamento (`45:103`) |
| 14 px | Semi Bold | `normal` | `#ffffff` | “Ver pontos no mapa” (`93:519`) |
| 15 px | Semi Bold | `normal` | `#234b3a` | “6 pontos coletados” (`93:449`) |
| 15 px | Semi Bold | `normal` | `#1f2723` | Valores “Não informado” (`93:453`, `93:457`) |
| 16 px | Regular | 24 px | `#68716c` | Texto dos campos (`80:71`, `80:75`) |
| 16 px | Semi Bold | 24 px | `#ffffff` | Botão “Entrar” (`80:83`) |
| 16 px | Semi Bold | `normal` | `#1f2723` | “Seus levantamentos” (`45:99`), “Acesso rápido” (`45:67`) |
| 17 px | Semi Bold | `normal` | `#1f2723` | “Pontos registrados” (`93:460`) |
| 18 px | Semi Bold | `normal` | `#18583d` | Glifos dos cards e ações (`45:102`, `45:70`) |
| 19 px | Semi Bold | `normal` | `#1f2723` | “Detalhes do levantamento” (`93:436`) |
| 20 px | Semi Bold | 34 px | `#234b3a` | Marca “GeoField” (`80:62`) |
| 20 px | Semi Bold | `normal` | `#1f2723` | “Sítio Boa Vista” (`93:440`) |
| 20 px | Semi Bold | `normal` | `#68716a` | Glifos da navegação na Proposta 2 (`45:127`, `45:129`) |
| 24 px | Semi Bold | `normal` | `#1f2723` | Títulos de tela (`45:24`, `45:44`, `45:94`) / Boas-vindas (`45:24`) |
| 28 px | Semi Bold | 36 px | `#1f2723` | “Bem-vindo de volta” (`80:64`) |
| 28 px | Semi Bold | 34 px | `#234b3a` | Marca “GeoField” (`80:62`) |

## 4. Espaçamento e grade base

Não há um token de grade nomeado no arquivo. Os valores aplicados diretamente nos frames são:

- Largura de referência: `390 px`; altura: `844 px`.
- Margens horizontais observadas: `20 px` (frame de detalhes, `93:431`/`93:458`/`93:516`), `22 px` (Proposta 2 e mapa), `24 px` (login reformulado, `80:56`).
- Escala de gaps observada: `2, 3, 4, 6, 7, 8, 9, 10, 12, 14, 16 px`.
- Escala de paddings observada: `4, 10, 12, 14, 16, 20, 24, 32, 38, 40, 56, 64 px`.
- Alturas recorrentes: `22, 24, 26, 32, 34, 38, 42, 44, 48, 54, 56, 62, 64, 74, 94, 104, 126, 286, 304, 365 px`.
- Larguras recorrentes: `32, 34, 48, 60, 64, 80, 94, 93, 108, 110, 129, 130, 133, 144, 209, 250, 322, 344, 346, 350, 390 px`.
- Deslocamentos verticais de seção observados: `64 px` (`93:431`), `350 px` (`93:458`), `642 px` (`93:516`), `787 px` (`93:596`).

## 5. Estilos de componentes

### Botões

**Primário — conjunto A (login e detalhes)**

| Propriedade | Valor | Origem |
|---|---|---|
| Background | `#234b3a` | `80:82`, `93:587`, `79:46` |
| Altura | `56 px` (Entrar), `38 px` (Ver pontos no mapa), `32 px` (Ver imagens registradas) | `80:82`, `93:587`, `79:46` |
| Largura | `100%` do container (`350 px` no login; `344 px` em detalhes) | `80:82`, `93:587` |
| Border radius | `28 px` (Entrar), `14 px` (ações de detalhes) | `80:82`, `93:587`, `79:46` |
| Gap interno | `10 px` | `93:587`, `79:46` |
| Texto | Inter Semi Bold, `16 px`/line-height `24 px` (Entrar); `14 px`/`normal` (mapa); `11 px`/`normal` (imagens) | `80:83`, `93:519`, `I79:46;93:519` |
| Cor do texto | `#ffffff` (`var(--backgrounds/primary, white)` / `var(--grays/white, white)`) | `80:83`, `93:519` |

**Primário — conjunto B (Proposta 2 e mapa)**

| Propriedade | Valor | Origem |
|---|---|---|
| Background | `#18583d` | `45:124` |
| Altura | `48 px` | `45:124` |
| Largura | `346 px` | `45:124` |
| Border radius | `13 px` | `45:124` |
| Texto | Inter Semi Bold, `13 px`/`normal`, `#fffffa` | `45:125` |

**Secundário / outline**

| Variante | Valores | Origem |
|---|---|---|
| Consultar anotações | Background `#edf3ee`; borda `1 px solid #e2e7e2`; radius `14 px`; altura `44 px`; largura `209 px`; gap `7 px`; ícone `16 px`; texto Inter Semi Bold `12 px`/`normal` `#234b3a` | `93:588`, `93:571`, `93:523` |
| Exportar CSV | Sem background explícito; borda `1 px solid #e2e7e2`; radius `14 px`; altura `44 px`; gap `6 px`; ícone `16 px`; texto Inter Semi Bold `12 px`/`normal` `#234b3a` | `93:589`, `93:574`, `93:526` |
| Botão de texto (Esqueci minha senha / Criar conta) | Altura `48 px`; padding horizontal `8 px`; texto Inter Semi Bold `14 px`/line-height `20 px` `#234b3a` | `80:79`, `80:80`, `80:86`, `80:87` |
| Botão de ícone (Voltar / visualizar senha) | Área `48 × 48 px`; ícone `24 × 24 px` | `80:54`, `80:93`, `80:76`, `80:96` |

**Estados**

| Estado | Valores extraídos |
|---|---|
| Normal | Valores das tabelas acima. |
| Hover | Não definido nos frames consultados. |
| Disabled | Não definido nos frames consultados. |
| Selecionado (aplicável à navegação inferior) | Ver item ativo em “Navegação”; para botões, nenhum estado selecionado foi definido. |

### Campos

**Campo de acesso (login reformulado)**

| Propriedade | Valor | Origem |
|---|---|---|
| Background | `#edf1ea` | `80:68`, `80:72` |
| Borda | `1 px solid #7b857d` apenas na borda inferior | `80:68`, `80:72` |
| Border radius | `4 px` nos cantos superiores | `80:68`, `80:72` |
| Altura | `64 px` | `80:68`, `80:72` |
| Padding | `16 px` à esquerda; `16 px` à direita no e-mail; `4 px` à direita na senha | `80:68`, `80:72` |
| Gap entre rótulo e valor | `4 px` | `80:69`, `80:73` |
| Rótulo | Inter Regular `12 px`/line-height `16 px`, `#68716c` | `80:70`, `80:74` |
| Valor/placeholder | Inter Regular `16 px`/line-height `24 px`, `#68716c` | `80:71`, `80:75` |
| Gap entre campos | `16 px` | `80:67` |
| Ação interna (olho) | Área `48 × 48 px`, ícone `24 × 24 px` | `80:76`, `80:96` |

**Campo de busca (Proposta 2)**

| Propriedade | Valor | Origem |
|---|---|---|
| Background | `#fffffa` | `45:96` |
| Borda | `1 px solid #e0e6e0` | `45:96` |
| Border radius | `12 px` | `45:96` |
| Altura / largura | `44 px` / `346 px` | `45:96` |
| Ícone | Glifo “⌕”, Inter Medium `22 px`/`normal`, `#68716a` | `45:97` |
| Placeholder | Inter Regular `12 px`/`normal`, `#68716a` | `45:98` |

**Estados**

| Estado | Valores extraídos |
|---|---|
| Normal | Valores das tabelas acima. |
| Hover | Não definido nos frames consultados. |
| Focus | Não definido nos frames consultados (a borda inferior `#7b857d` aparece como estilo aplicado, sem distinção de foco). |
| Disabled | Não definido nos frames consultados. |

### Cards

| Card | Valores | Origem |
|---|---|---|
| Cartão principal do levantamento | Background `#f5f5ed`; borda `1 px solid #e2e7e2`; radius `18 px`; padding `16 px`; altura `104 px`; largura `350 px`; gap interno `9 px`; título Inter Semi Bold `20 px`/`normal` `#1f2723`; ícone de conclusão `22 px`; localização com ícone `18 px` e texto Inter Regular `14 px`/`normal` `#68716c`; data Inter Regular `12 px`/`normal` `#68716c` | `93:579`, `93:439`, `93:440`, `93:442`, `93:446`, `93:447` |
| Cartão de levantamento (Proposta 2) | Background `#fffffa`; borda `1 px solid #e0e6e0`; radius `15 px`; altura `126 px`; largura `346 px`; ícone `34 px`; glifo `18 px` `#18583d`; título Inter Semi Bold `14 px`/`normal` `#1f2723`; subtítulo Inter Regular `11 px`/`normal` `#68716a`; metadados Inter Regular `11 px`/`normal` `#68716a` | `45:100`, `45:101`, `45:102`, `45:103`, `45:104`, `45:105` |
| Cartão de medições | Background `#ffffff`; borda `1 px solid #e2e7e2`; radius `14 px`; altura `62 px`; padding `14 px` horizontal e `10 px` vertical; gap `14 px`; rótulo Inter Regular `12 px`/`normal` `#68716c`; valor Inter Semi Bold `15 px`/`normal` `#1f2723`; divisor `1 px × 34 px` `#e2e7e2` | `93:450`, `93:451`, `93:452`, `93:453`, `93:454`, `93:455` |
| Lista de pontos | Container com borda `1 px solid #e2e7e2`, radius `14 px`, altura `252 px`; linhas de `42 px` com padding horizontal `12 px`, gap `10 px`; título Inter Semi Bold `13 px`/line-height `15 px` `#1f2723`; coordenadas Inter Regular `11 px`/line-height `14 px` `#68716c`; borda inferior `1 px #e2e7e2` em todas exceto a última (`border-0`); ícone de check `15 px` dentro de área `18 px` | `93:461`, `93:581`–`93:586` |
| Card de ação rápida | Background `#fffffa`; borda `1 px solid #e0e6e0`; radius `15 px`; altura `94 px`; largura `110 px`; área de ícone `34 px`; glifo Inter Semi Bold `18 px`/`normal` `#18583d`; rótulo Inter Medium `10 px`/`normal` `#1f2723` | `45:68`, `45:69`, `45:70`, `45:71` |
| Card do mapa | Background `#fffffa`; borda `1 px solid #e0e6e0`; radius `15 px`; altura `365 px`; largura `346 px`; canvas interno `#dae6d0` com radius `12 px`; terrenos `#c3d5bc` e `#eaf2e9` com radius `18 px` | `45:48`, `45:49`, `45:50`, `45:51`, `45:52`, `45:53` |
| Pílulas | Altura `26 px`; radius `13 px`; background `#eaf2e9` / `#fff2e0` / `#fffffa`; texto Inter Medium `10 px`/`normal` nas cores `#18583d` ou `#f48b39` | `45:46`, `45:47`, `45:106`, `45:107`, `45:114`, `45:115`, `45:63`, `45:64` |

### Navegação inferior

| Conjunto | Valores | Origem |
|---|---|---|
| Detalhes | Background `#ffffff`; borda `1 px solid #e2e7e2`; radius `14 px`; altura `54 px`; padding superior `15 px`; largura `390 px`; cada item com largura `130 px` e gap `3 px`; ícone `22 px`; rótulo Inter `12 px`/`normal`; item ativo Inter Semi Bold `#2e7a52`; itens inativos Inter Regular `#68716c` | `93:596`, `93:590`, `93:591`, `93:592`, `93:529`, `93:532`, `93:534`, `93:537` |
| Proposta 2 / mapa | Background `#fffffa`; borda `1 px solid #e0e6e0`; altura `74 px`; largura `390 px`; glifo `20 px`; rótulo `9 px`/`normal`; item ativo Inter Semi Bold `#18583d`; itens inativos Inter Regular ou Semi Bold `#68716a` | `45:126`, `45:80`, `45:127`–`45:136`, `45:81`–`45:90` |

## 6. Border radius e sombras

**Raios extraídos**

| Raio | Onde aparece | Origem |
|---|---|---|
| `2 px` | Indicador de navegação (`108 × 4 px`) | `80:91` |
| `4 px` | Cantos superiores dos campos de acesso | `80:68`, `80:72` |
| `12 px` | Campo de busca; canvas do mapa | `45:96`, `45:49` |
| `13 px` | Pílulas; botão principal da Proposta 2 | `45:46`, `45:124` |
| `14 px` | Cartão de medições, lista de pontos, ações de detalhes, navegação inferior | `93:450`, `93:461`, `93:587`, `93:596` |
| `15 px` | Cartões da Proposta 2, cards de ação e card do mapa | `45:100`, `45:68`, `45:48` |
| `18 px` | Cartão principal; terrenos do mapa | `93:579`, `45:50` |
| `28 px` | Botão “Entrar” | `80:82` |

**Bordas extraídas**

- `1 px solid #e2e7e2` — frame de detalhes.
- `1 px solid #e0e6e0` — Proposta 2 e mapa.
- `1 px solid #7b857d` — apenas borda inferior dos campos de acesso.
- `border-0` — última linha da lista de pontos (`93:586`).

**Sombras**

Nenhuma sombra (`box-shadow`) foi retornada nos frames consultados. O sistema visual dos frames lidos utiliza apenas bordas de `1 px` e fundos sólidos; não há valor de sombra extraído do Figma para documentar.
