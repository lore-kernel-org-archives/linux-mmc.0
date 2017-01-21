From: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v5 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Fri, 20 Jan 2017 22:06:03 -0500
Message-ID: <20170121030604.7672-3-chris.brandt@renesas.com>
References: <20170121030604.7672-1-chris.brandt@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170121030604.7672-1-chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

In the case of a single clock source, you don't need names. However,
if the controller has 2 clock sources, you need to name them correctly
so the driver can find the 2nd one. The 2nd clock is for the internal
card detect logic.

Signed-off-by: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
v4:
* just explain there might be 2 clocks, don't explain how
  we will use them in the driver
v3:
* add more clarification about why there are sometimes 2 clocks
  and what you should do with them.
* remove 'status = "disabled"' from example
v2:
* fix spelling and change wording
* changed clock name from "carddetect" to "cd"
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index a1650ed..1464c16 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -25,8 +25,32 @@ Required properties:
 		"renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
 		"renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
 
+- clocks: Most controllers only have 1 clock source per channel. However, on
+	  some variations of this controller, the internal card detection
+	  logic that exists in this controller is sectioned off to be run by a
+	  separate second clock source to allow the main core clock to be turned
+	  off to save power.
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


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
