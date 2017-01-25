From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 01/14] Documentation: dt/bindings: Document pinctrl-ingenic
Date: Wed, 25 Jan 2017 19:51:54 +0100
Message-ID: <20170125185207.23902-2-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170125185207.23902-1-paul@crapouillou.net>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

This commit adds documentation for the devicetree bidings of the
pinctrl-ingenic driver, which handles pin configuration and pin
muxing of the Ingenic SoCs currently supported by the Linux kernel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/pinctrl/ingenic,pinctrl.txt           | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt

v2: Rewrote the documentation for the new pinctrl-ingenic driver
v3: No changes

diff --git a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
new file mode 100644
index 000000000000..ead5b01ad471
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
@@ -0,0 +1,77 @@
+Ingenic jz47xx pin controller
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of the
+phrase "pin configuration node".
+
+For the jz47xx SoCs, pin control is tightly bound with GPIO ports. All pins may
+be used as GPIOs, multiplexed device functions are configured within the
+GPIO port configuration registers and it is typical to refer to pins using the
+naming scheme "PxN" where x is a character identifying the GPIO port with
+which the pin is associated and N is an integer from 0 to 31 identifying the
+pin within that GPIO port. For example PA0 is the first pin in GPIO port A, and
+PB31 is the last pin in GPIO port B. The jz4740 contains 4 GPIO ports, PA to
+PD, for a total of 128 pins. The jz4780 contains 6 GPIO ports, PA to PF, for a
+total of 192 pins.
+
+
+Pin controller node
+===================
+
+Required properties:
+- compatible: One of:
+  - "ingenic,jz4740-pinctrl"
+  - "ingenic,jz4780-pinctrl"
+
+Optional properties:
+- ingenic,pull-ups: A list of 32-bit bit fields, where each bit set tells the
+  driver that a pull-up resistor is available for this pin.
+  By default, the driver considers that all pins feature a pull-up resistor.
+- ingenic,pull-downs: A list of 32-bit bit fields, where each bit set tells
+  the driver that a pull-down resistor is available for this pin.
+  By default, the driver considers that all pins feature a pull-down
+  resistor.
+
+
+'functions' sub-node
+====================
+
+The 'functions' node will contain sub-nodes that correspond to pin function
+nodes, and no properties. Pin function nodes will contain sub-nodes that
+correspond to pin groups, and no properties.
+
+The names of the pin function nodes will end up being the available functions
+provided by the pinctrl driver.
+The names of the pin group nodes will end up being the available groups
+provided by the pinctrl driver.
+
+Required properties for pin groups:
+- ingenic,pins: <pin mode [pin mode ...]>;
+  where 'pin' is the number of the pin, and 'mode' is the function mode of the
+  pin that should be enabled for this group.
+
+
+Example:
+=======
+
+pinctrl: ingenic-pinctrl@10010000 {
+	compatible = "ingenic,jz4740-pinctrl";
+	reg = <0x10010000 0x400>;
+
+	ingenic,pull-ups   = <0xffffffff 0xffffffff 0xffffffff 0xdfffffff>;
+	ingenic,pull-downs = <0x00000000 0x00000000 0x00000000 0x00000000>;
+
+	functions {
+		mmc {
+			mmc-1bit {
+				/* CLK, CMD, D0 */
+				ingenic,pins = <0x69 0 0x68 0 0x6a 0>;
+			};
+
+			mmc-4bit {
+				/* D1, D2, D3 */
+				ingenic,pins = <0x6b 0 0x6c 0 0x6d 0>;
+			};
+		};
+	};
+};
-- 
2.11.0

