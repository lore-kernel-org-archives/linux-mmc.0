From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v2 7/9] DT: stm32f429: add node for SDIO controller
Date: Tue, 10 Jan 2017 09:42:14 +0100
Message-ID: <1484037736-25029-8-git-send-email-andrea.merello@gmail.com>
References: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35313 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030674AbdAJImy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 03:42:54 -0500
Received: by mail-wm0-f68.google.com with SMTP id l2so28046674wml.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 00:42:53 -0800 (PST)
In-Reply-To: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

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

