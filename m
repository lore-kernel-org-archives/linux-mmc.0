From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v4 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Fri, 20 Jan 2017 14:43:31 -0500
Message-ID: <20170120194332.1683-3-chris.brandt@renesas.com>
References: <20170120194332.1683-1-chris.brandt@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170120194332.1683-1-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

In the case of a single clock source, you don't need names. However,
if the controller has 2 clock sources, you need to name them correctly
so the driver can find the 2nd one. The 2nd clock is for the internal
card detect logic and must be enabled/disabled along with the main
core clock.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v3:
* add more clarification about why there are sometimes 2 clocks
  and what you should do with them.
* remove 'status = "disabled"' from example
v2:
* fix spelling and change wording
* changed clock name from "carddetect" to "cd"
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index a1650ed..9033c6a 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -25,8 +25,36 @@ Required properties:
 		"renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
 		"renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
 
+- clocks: Most controllers only have 1 clock source per channel. However, on
+	  some variations of this controller, the internal card detection
+	  logic that exists in this controller is sectioned off to be run by a
+	  separate second clock source to allow the main core clock to be turned
+	  off to save power. Unfortunately, the existing driver architecture
+	  does not support such a separation of clocks.
+	  Additionally, it is prohibited to supply a clock to the core but not
+	  to the card detect circuit. That leaves you with if separate clocks
+	  are presented, you must treat them both as 1.
+	  If 2 clocks are specified by the hardware, you must name them as
+	  "core" and "cd".
+	  If the controller only has 1 clock, naming is not required.
+
 Optional properties:
 - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
 - pinctrl-names: should be "default", "state_uhs"
 - pinctrl-0: should contain default/high speed pin ctrl
 - pinctrl-1: should contain uhs mode pin ctrl
+
+Example showing 2 clocks:
+	sdhi0: sd@e804e000 {
+		compatible = "renesas,sdhi-r7s72100";
+		reg = <0xe804e000 0x100>;
+		interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&mstp12_clks R7S72100_CLK_SDHI00>,
+			 <&mstp12_clks R7S72100_CLK_SDHI01>;
+		clock-names = "core", "cd";
+		cap-sd-highspeed;
+		cap-sdio-irq;
+	};
-- 
2.10.1
