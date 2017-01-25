From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v6 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Wed, 25 Jan 2017 15:28:09 -0500
Message-ID: <20170125202810.16876-3-chris.brandt@renesas.com>
References: <20170125202810.16876-1-chris.brandt@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170125202810.16876-1-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

In the case of a single clock source, you don't need names. However,
if the controller has 2 clock sources, you need to name them correctly
so the driver can find the 2nd one. The 2nd clock is for the internal
card detect logic.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
* add Reviewed-by: Geert Uytterhoeven
* list number of clocks for each SoC
* remove example because it already exists in mmc.txt
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
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index a1650ed..4fd8b7a 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -25,6 +25,19 @@ Required properties:
 		"renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
 		"renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
 
+- clocks: Most controllers only have 1 clock source per channel. However, on
+	  some variations of this controller, the internal card detection
+	  logic that exists in this controller is sectioned off to be run by a
+	  separate second clock source to allow the main core clock to be turned
+	  off to save power.
+	  If 2 clocks are specified by the hardware, you must name them as
+	  "core" and "cd". If the controller only has 1 clock, naming is not
+	  required.
+	  Below is the number clocks for each supported SoC:
+	   1: SH73A0, R8A73A4, R8A7740, R8A7778, R8A7779, R8A7790
+	      R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
+	   2: R7S72100
+
 Optional properties:
 - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
 - pinctrl-names: should be "default", "state_uhs"
-- 
2.10.1
