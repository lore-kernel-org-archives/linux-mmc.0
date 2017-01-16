From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v3 7/9] ARM: DTS: stm32: add node for SDIO controller on stm32f429
Date: Mon, 16 Jan 2017 08:37:16 +0100
Message-ID: <1484552238-23171-8-git-send-email-andrea.merello@gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35892 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdAPHhq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2017 02:37:46 -0500
Received: by mail-wm0-f66.google.com with SMTP id r126so28767060wmr.3
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2017 23:37:45 -0800 (PST)
In-Reply-To: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

this patch adds the sdio controller DT note on stm32f429

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index de7b9c3..c12a64e 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -388,6 +388,18 @@
 			};
 		};
 
+		sdio: sdio@40012c00 {
+			compatible = "st,stm32f4xx-sdio";
+			reg = <0x40012c00 0x400>;
+			clocks = <&rcc 0 171>;
+			interrupts = <49>;
+			status = "disabled";
+			pinctrl-0 = <&sdio_pins>;
+			pinctrl-1 = <&sdio_pins_od>;
+			pinctrl-names = "default", "opendrain";
+			max-frequency = <48000000>;
+		};
+
 		rcc: rcc@40023810 {
 			#reset-cells = <1>;
 			#clock-cells = <2>;
-- 
2.7.4

