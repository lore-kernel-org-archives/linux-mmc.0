From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv10 4/5] ARM: dts: socfpga: unuse the slot-node and deprecate
 the supports-highspeed for dw-mmc
Date: Thu, 07 Aug 2014 16:38:01 +0900
Message-ID: <1407397082-32495-5-git-send-email-jh80.chung@samsung.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:27736 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbaHGHiI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Aug 2014 03:38:08 -0400
In-reply-to: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>

dw-mmc controller can support multiple slots.
But, there are no use-cases anywhere. So we don't need to support the
slot-node for dw-mmc controller.
And "supports-highspeed" property in dw-mmc is deprecated.
"supports-highspeed" property can be replaced with "cap-sd/mmc-highspeed".

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Tushar Behera <trblinux@gmail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/boot/dts/socfpga_arria5.dtsi   |    9 +++------
 arch/arm/boot/dts/socfpga_cyclone5.dtsi |    9 +++------
 arch/arm/boot/dts/socfpga_vt.dts        |    9 +++------
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index 12d1c2c..468fc4c 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -29,13 +29,10 @@
 
 		dwmmc0@ff704000 {
 			num-slots = <1>;
-			supports-highspeed;
 			broken-cd;
-
-			slot@0 {
-				reg = <0>;
-				bus-width = <4>;
-			};
+			bus-width = <4>;
+			cap-mmc-highspeed;
+			cap-sd-highspeed;
 		};
 
 		sysmgr@ffd08000 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index bf51182..1ee03c4 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -30,13 +30,10 @@
 
 		dwmmc0@ff704000 {
 			num-slots = <1>;
-			supports-highspeed;
 			broken-cd;
-
-			slot@0 {
-				reg = <0>;
-				bus-width = <4>;
-			};
+			bus-width = <4>;
+			cap-mmc-highspeed;
+			cap-sd-highspeed;
 		};
 
 		ethernet@ff702000 {
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index 09792b4..f9345e0 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -43,13 +43,10 @@
 
 		dwmmc0@ff704000 {
 			num-slots = <1>;
-			supports-highspeed;
 			broken-cd;
-
-			slot@0 {
-				reg = <0>;
-				bus-width = <4>;
-			};
+			bus-width = <4>;
+			cap-mmc-highspeed;
+			cap-sd-highspeed;
 		};
 
 		ethernet@ff700000 {
-- 
1.7.9.5

