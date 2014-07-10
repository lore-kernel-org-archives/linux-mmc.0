From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 1/5] mmc: dw_mmc: modify the dt-binding for removing
 slot-node and supports-highspeed
Date: Thu, 10 Jul 2014 16:08:35 +0900
Message-ID: <1404976119-10777-2-git-send-email-jh80.chung@samsung.com>
References: <1404976119-10777-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36421 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbaGJHIr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jul 2014 03:08:47 -0400
In-reply-to: <1404976119-10777-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>

Almost Soc is used the slot per a host.
Don't use the slot-node and deprecated the "supports-highsped" property.
Instead, use the cap-mmc/sd-highspeed.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Tushar Behera <trblinux@gmail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   17 +++++------------
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   12 +++++-------
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   12 +++++-------
 3 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index 532b1d4..9308325 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -46,13 +46,14 @@ Required Properties:
       - if CIU clock divider value is 0 (that is divide by 1), both tx and rx
         phase shift clocks should be 0.
 
-Required properties for a slot:
+Required properties for a slot (Deprecated - Recommend to use one slot per a host):
 
 * gpios: specifies a list of gpios used for command, clock and data bus. The
   first gpio is the command line and the second gpio is the clock line. The
   rest of the gpios (depending on the bus-width property) are the data lines in
   no particular order. The format of the gpio specifier depends on the gpio
   controller.
+ (Deprecated - Refer to Documentaion/devicetree/binding/pinctrl/samsung-pinctrl.txt)
 
 Example:
 
@@ -69,21 +70,13 @@ Example:
 
 	dwmmc0@12200000 {
 		num-slots = <1>;
-		supports-highspeed;
+		cap-mmc-highspeed;
+		cap-sd-highspeed;
 		broken-cd;
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-			gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
-				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
-				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
-				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
-				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
-		};
+		bus-width = <8>;
 	};
diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
index e5bc49f..3b35449 100644
--- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
@@ -34,13 +34,11 @@ Example:
 		num-slots = <1>;
 		vmmc-supply = <&ldo12>;
 		fifo-depth = <0x100>;
-		supports-highspeed;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
-		slot@0 {
-			reg = <0>;
-			bus-width = <4>;
-			disable-wp;
-			cd-gpios = <&gpio10 3 0>;
-		};
+		bus-width = <4>;
+		disable-wp;
+		cd-gpios = <&gpio10 3 0>;
+		cap-mmc-highspeed;
+		cap-sd-highspeed;
 	};
diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 2d4a725..346c609 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -67,7 +67,8 @@ Optional properties:
 * card-detect-delay: Delay in milli-seconds before detecting card after card
   insert event. The default value is 0.
 
-* supports-highspeed: Enables support for high speed cards (up to 50MHz)
+* supports-highspeed (DEPRECATED): Enables support for high speed cards (up to 50MHz)
+			   (use "cap-mmc-highspeed" or "cap-sd-highspeed" instead)
 
 * broken-cd: as documented in mmc core bindings.
 
@@ -98,14 +99,11 @@ board specific portions as listed below.
 		clock-frequency = <400000000>;
 		clock-freq-min-max = <400000 200000000>;
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 		vmmc-supply = <&buck8>;
-
-		slot@0 {
-			reg = <0>;
-			bus-width = <8>;
-		};
+		bus-width = <8>;
+		cap-mmc-highspeed;
+		cap-sd-highspeed;
 	};
-- 
1.7.9.5

