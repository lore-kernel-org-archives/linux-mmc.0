From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 23/27] devicetree: fix name of pinctrl-bindings.txt
Date: Thu, 14 Jun 2018 13:09:08 -0300
Message-ID: <d04d47f9fba035cf9de8589a288964c636324d58.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1528990947.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Rename:
	pinctrl-binding.txt -> pinctrl-bindings.txt

In order to match the current name of this file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt | 2 +-
 Documentation/devicetree/bindings/mfd/as3722.txt              | 2 +-
 .../devicetree/bindings/mmc/microchip,sdhci-pic32.txt         | 2 +-
 Documentation/devicetree/bindings/mmc/sdhci-st.txt            | 2 +-
 .../devicetree/bindings/pinctrl/pinctrl-max77620.txt          | 4 ++--
 .../devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt          | 4 ++--
 Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt   | 4 ++--
 .../devicetree/bindings/serial/microchip,pic32-uart.txt       | 2 +-
 Documentation/devicetree/bindings/spi/spi-st-ssc.txt          | 2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt b/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
index c7888d6f6408..880d4d70c9fd 100644
--- a/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
+++ b/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
@@ -28,7 +28,7 @@ See: Documentation/devicetree/bindings/clock/clock-bindings.txt
 - pinctrl-names	: a pinctrl state named tsin%d-serial or tsin%d-parallel (where %d is tsin-num)
 		   must be defined for each tsin child node.
 - pinctrl-0	: phandle referencing pin configuration for this tsin configuration
-See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
+See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
 
 
 Required properties (tsin (child) node):
diff --git a/Documentation/devicetree/bindings/mfd/as3722.txt b/Documentation/devicetree/bindings/mfd/as3722.txt
index 0b2a6099aa20..5297b2210704 100644
--- a/Documentation/devicetree/bindings/mfd/as3722.txt
+++ b/Documentation/devicetree/bindings/mfd/as3722.txt
@@ -46,7 +46,7 @@ is required:
 	Following properties are require if pin control setting is required
 	at boot.
 	- pinctrl-names: A pinctrl state named "default" be defined, using the
-		bindings in pinctrl/pinctrl-binding.txt.
+		bindings in pinctrl/pinctrl-bindings.txt.
 	- pinctrl[0...n]: Properties to contain the phandle that refer to
 		different nodes of pin control settings. These nodes represents
 		the pin control setting of state 0 to state n. Each of these
diff --git a/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
index 3149297b3933..f064528effed 100644
--- a/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
+++ b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
@@ -12,7 +12,7 @@ Required properties:
           See: Documentation/devicetree/bindings/clock/clock-bindings.txt
 - pinctrl-names: A pinctrl state names "default" must be defined.
 - pinctrl-0: Phandle referencing pin configuration of the SDHCI controller.
-             See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
+             See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-st.txt b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
index 6b3d40ca395e..ccf82b4ee838 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-st.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
@@ -20,7 +20,7 @@ Required properties:
 
 - pinctrl-names:	A pinctrl state names "default" must be defined.
 - pinctrl-0:		Phandle referencing pin configuration of the sd/emmc controller.
-			See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
+			See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
 
 - reg:			This must provide the host controller base address and it can also
 			contain the FlashSS Top register for TX/RX delay used by the driver
diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
index ad4fce3552bb..511fc234558b 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
@@ -11,9 +11,9 @@ Optional Pinmux properties:
 --------------------------
 Following properties are required if default setting of pins are required
 at boot.
-- pinctrl-names: A pinctrl state named per <pinctrl-binding.txt>.
+- pinctrl-names: A pinctrl state named per <pinctrl-bindings.txt>.
 - pinctrl[0...n]: Properties to contain the phandle for pinctrl states per
-		<pinctrl-binding.txt>.
+		<pinctrl-bindings.txt>.
 
 The pin configurations are defined as child of the pinctrl states node. Each
 sub-node have following properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
index a677145ae6d1..625a22e2f211 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mcp23s08.txt
@@ -101,9 +101,9 @@ Optional Pinmux properties:
 --------------------------
 Following properties are required if default setting of pins are required
 at boot.
-- pinctrl-names: A pinctrl state named per <pinctrl-binding.txt>.
+- pinctrl-names: A pinctrl state named per <pinctrl-bindings.txt>.
 - pinctrl[0...n]: Properties to contain the phandle for pinctrl states per
-		<pinctrl-binding.txt>.
+		<pinctrl-bindings.txt>.
 
 The pin configurations are defined as child of the pinctrl states node. Each
 sub-node have following properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt
index eee3dc260934..cbcbd31e3ce8 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-rk805.txt
@@ -10,9 +10,9 @@ Optional Pinmux properties:
 --------------------------
 Following properties are required if default setting of pins are required
 at boot.
-- pinctrl-names: A pinctrl state named per <pinctrl-binding.txt>.
+- pinctrl-names: A pinctrl state named per <pinctrl-bindings.txt>.
 - pinctrl[0...n]: Properties to contain the phandle for pinctrl states per
-		<pinctrl-binding.txt>.
+		<pinctrl-bindings.txt>.
 
 The pin configurations are defined as child of the pinctrl states node. Each
 sub-node have following properties:
diff --git a/Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt b/Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
index 7a34345d0ca3..c8dd440e9747 100644
--- a/Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
+++ b/Documentation/devicetree/bindings/serial/microchip,pic32-uart.txt
@@ -8,7 +8,7 @@ Required properties:
           See: Documentation/devicetree/bindings/clock/clock-bindings.txt
 - pinctrl-names: A pinctrl state names "default" must be defined.
 - pinctrl-0: Phandle referencing pin configuration of the UART peripheral.
-             See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
+             See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
 
 Optional properties:
 - cts-gpios: CTS pin for UART
diff --git a/Documentation/devicetree/bindings/spi/spi-st-ssc.txt b/Documentation/devicetree/bindings/spi/spi-st-ssc.txt
index fe54959ec957..1bdc4709e474 100644
--- a/Documentation/devicetree/bindings/spi/spi-st-ssc.txt
+++ b/Documentation/devicetree/bindings/spi/spi-st-ssc.txt
@@ -9,7 +9,7 @@ Required properties:
 - clocks	: Must contain an entry for each name in clock-names
 		    See ../clk/*
 - pinctrl-names	: Uses "default", can use "sleep" if provided
-		    See ../pinctrl/pinctrl-binding.txt
+		    See ../pinctrl/pinctrl-bindings.txt
 
 Optional properties:
 - cs-gpios	: List of GPIO chip selects
-- 
2.17.1
