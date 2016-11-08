From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 7/9] DT: stm32f429: add node for SDIO controller
Date: Tue,  8 Nov 2016 14:43:43 +0100
Message-ID: <1478612625-23256-8-git-send-email-andrea.merello@gmail.com>
References: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34120 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbcKHNoa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2016 08:44:30 -0500
Received: by mail-wm0-f68.google.com with SMTP id p190so22761362wmp.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2016 05:44:29 -0800 (PST)
In-Reply-To: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 961bc0c..d6d0548 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -365,6 +365,18 @@
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

