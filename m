From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 02/14] dt/bindings: Document gpio-ingenic
Date: Fri, 28 Apr 2017 22:08:12 +0200
Message-ID: <20170428200824.10906-3-paul@crapouillou.net>
References: <20170402204244.14216-2-paul@crapouillou.net>
 <20170428200824.10906-1-paul@crapouillou.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:39074 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166058AbdD1UIv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Apr 2017 16:08:51 -0400
In-Reply-To: <20170428200824.10906-1-paul@crapouillou.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>

This commit adds documentation for the devicetree bindings of the
gpio-ingenic driver, which handles GPIOs of the Ingenic SoCs
currently supported by the Linux kernel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/gpio/ingenic,gpio.txt      | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt

 v2: New patch
 v3: No changes
 v4: Update for the v4 version of the gpio-ingenic driver
 v5: Remove gpio-bank-... compatible strings, and add 'reg' property

diff --git a/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
new file mode 100644
index 000000000000..7988aeb725f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
@@ -0,0 +1,46 @@
+Ingenic jz47xx GPIO controller
+
+That the Ingenic GPIO driver node must be a sub-node of the Ingenic pinctrl
+driver node.
+
+Required properties:
+--------------------
+
+ - compatible: Must contain one of:
+    - "ingenic,jz4740-gpio"
+    - "ingenic,jz4770-gpio"
+    - "ingenic,jz4780-gpio"
+ - reg: The GPIO bank number.
+ - interrupt-controller: Marks the device node as an interrupt controller.
+ - interrupts: Interrupt specifier for the controllers interrupt.
+ - #interrupt-cells: Should be 2. Refer to
+   ../interrupt-controller/interrupts.txt for more details.
+ - gpio-controller: Marks the device node as a GPIO controller.
+ - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
+    cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
+    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
+ - gpio-ranges: Range of pins managed by the GPIO controller. Refer to
+   'gpio.txt' in this directory for more details.
+
+Example:
+--------
+
+&pinctrl {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	gpa: gpio@0 {
+		compatible = "ingenic,jz4740-gpio";
+		reg = <0>;
+
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 0 32>;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <28>;
+	};
+};
-- 
2.11.0

