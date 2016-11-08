From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 6/9] DT: stm32f429: add pin map for SDIO controller
Date: Tue,  8 Nov 2016 14:43:42 +0100
Message-ID: <1478612625-23256-7-git-send-email-andrea.merello@gmail.com>
References: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34997 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbcKHNo2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2016 08:44:28 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so11947122wme.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2016 05:44:28 -0800 (PST)
In-Reply-To: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 336ee4f..961bc0c 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -313,6 +313,37 @@
 				};
 			};
 
+			sdio_pins:sdio_pins@0 {
+				pins {
+					pinmux = <STM32F429_PC8_FUNC_SDIO_D0>,
+						 <STM32F429_PC9_FUNC_SDIO_D1>,
+						 <STM32F429_PC10_FUNC_SDIO_D2>,
+						 <STM32F429_PC11_FUNC_SDIO_D3>,
+						 <STM32F429_PC12_FUNC_SDIO_CK>,
+						 <STM32F429_PD2_FUNC_SDIO_CMD>;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			sdio_pins_od:sdio_pins_od@0 {
+				pins {
+					pinmux = <STM32F429_PC8_FUNC_SDIO_D0>,
+						 <STM32F429_PC9_FUNC_SDIO_D1>,
+						 <STM32F429_PC10_FUNC_SDIO_D2>,
+						 <STM32F429_PC11_FUNC_SDIO_D3>,
+						 <STM32F429_PC12_FUNC_SDIO_CK>;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+
+				pins_od {
+					pinmux = <STM32F429_PD2_FUNC_SDIO_CMD>;
+					drive-open-drain;
+					slew-rate = <2>;
+				};
+			};
+
 			ethernet0_mii: mii@0 {
 				pins {
 					pinmux = <STM32F429_PG13_FUNC_ETH_MII_TXD0_ETH_RMII_TXD0>,
-- 
2.7.4

