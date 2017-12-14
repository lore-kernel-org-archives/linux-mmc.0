From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 12/14] ARM: dts: am57xx-idk: Select pull down for mmc1_clk line in default mode
Date: Thu, 14 Dec 2017 19:10:52 +0530
Message-ID: <20171214134054.7749-13-kishon@ti.com>
References: <20171214134054.7749-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:51770 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbdLNNmZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Dec 2017 08:42:25 -0500
In-Reply-To: <20171214134054.7749-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com

During a short period when the bus voltage is switched from 3.3v to 1.8v,
(to enumerate UHS mode), the mmc module is disabled and the mmc IO lines
are kept in a state according to the programmed pad mux pull type.

According to 4.2.4.2 Timing to Switch Signal Voltage in "SD Specifications
Part 1 Physical Layer Specification Version 5.00 February 22, 2016", the
host should hold CLK low for at least 5ms.

In order to keep the card line low during voltage switch, the pad mux of
mmc1_clk line should be configured to pull down.

This is specific to am57xx-idk (and not all dra72/dra74 based boards)
since mmc1_clk line in am57xx-idk is not connected to an external
pullup.

While at that change the order of header files in am571x-idk.dts and
am572x-idk.dts so that the modified pinctrl values in am57xx-idk-common
could take effect.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts         |  2 +-
 arch/arm/boot/dts/am572x-idk.dts         |  2 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 11 +++++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index debf9464403e..c7d77acffa28 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -10,8 +10,8 @@
 #include "dra72x.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "am57xx-idk-common.dtsi"
 #include "dra72x-mmc-iodelay.dtsi"
+#include "am57xx-idk-common.dtsi"
 
 / {
 	model = "TI AM5718 IDK";
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index a578fe97ba3b..144376ad5f35 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -11,8 +11,8 @@
 #include "dra74x.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include "am57xx-idk-common.dtsi"
 #include "dra74x-mmc-iodelay.dtsi"
+#include "am57xx-idk-common.dtsi"
 
 / {
 	model = "TI AM5728 IDK";
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 43a6d0590f7c..43cdf523a8a0 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -115,6 +115,17 @@
 			DRA7XX_CORE_IOPAD(0x37d4, MUX_MODE15 | PULL_UP)	/* dcan1_rx.off */
 		>;
 	};
+
+	mmc1_pins_default: mmc1_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mmc1_clk.clk */
+			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
+			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
+			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
+			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
+			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
+		>;
+	};
 };
 
 &i2c1 {
-- 
2.11.0

