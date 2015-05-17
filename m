From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 6/6] ARM: shmobile: lager: Enable UHS-I SDR-50
Date: Sun, 17 May 2015 01:39:44 +0100
Message-ID: <1431823184.4222.180.camel@xylophone.i.decadent.org.uk>
References: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,2}.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
None of the states includes the CD pins, as they can't be allocated both
through pinctrl and as GPIOs.  But the Lager manual shows these signals
being pulled up to the same variable voltage as the other signals.  This
might possibly lead to spurious card detect interrupts after switching
to 1.8V signalling.

Ben.

 arch/arm/boot/dts/r8a7790-lager.dts |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 343ec0ccc8df..5584e835d0f5 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -314,11 +314,21 @@
 		renesas,function = "sdhi0";
 	};
 
+	sdhi0_pins_1v8: sd0_1v8 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
+		renesas,function = "sdhi0_1v8";
+	};
+
 	sdhi2_pins: sd2 {
 		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
 
+	sdhi2_pins_1v8: sd2_1v8 {
+		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,function = "sdhi2_1v8";
+	};
+
 	mmc1_pins: mmc1 {
 		renesas,groups = "mmc1_data8", "mmc1_ctrl";
 		renesas,function = "mmc1";
@@ -491,7 +501,8 @@
 
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdhi0_pins_1v8>;
+	pinctrl-names = "default", "1v8";
 
 	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
 	assigned-clock-rates = <156000000>;
@@ -499,12 +510,14 @@
 	vmmc-supply = <&vcc_sdhi0>;
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
 &sdhi2 {
 	pinctrl-0 = <&sdhi2_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdhi2_pins_1v8>;
+	pinctrl-names = "default", "1v8";
 
 	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
 	assigned-clock-rates = <97500000>;
@@ -512,6 +525,7 @@
 	vmmc-supply = <&vcc_sdhi2>;
 	vqmmc-supply = <&vccq_sdhi2>;
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
-- 
1.7.10.4



