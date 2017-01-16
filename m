From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v3 6/9] ARM: DTS: stm32: add pin map for SDIO controller on stm32f429
Date: Mon, 16 Jan 2017 08:37:15 +0100
Message-ID: <1484552238-23171-7-git-send-email-andrea.merello@gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34729 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbdAPHho (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2017 02:37:44 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so28594676wmi.1
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2017 23:37:44 -0800 (PST)
In-Reply-To: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

This patch adds the pin configuration for SDIO controller on
stm32f429

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index e4dae0e..de7b9c3 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -336,7 +336,38 @@
 				};
 			};
 
-			ethernet_mii: mii@0 {
+			sdio_pins: sdio_pins@0 {
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
+			sdio_pins_od: sdio_pins_od@0 {
+				pins1 {
+					pinmux = <STM32F429_PC8_FUNC_SDIO_D0>,
+						 <STM32F429_PC9_FUNC_SDIO_D1>,
+						 <STM32F429_PC10_FUNC_SDIO_D2>,
+						 <STM32F429_PC11_FUNC_SDIO_D3>,
+						 <STM32F429_PC12_FUNC_SDIO_CK>;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+
+				pins2 {
+					pinmux = <STM32F429_PD2_FUNC_SDIO_CMD>;
+					drive-open-drain;
+					slew-rate = <2>;
+				};
+			};
+
+			ethernet0_mii: mii@0 {
 				pins {
 					pinmux = <STM32F429_PG13_FUNC_ETH_MII_TXD0_ETH_RMII_TXD0>,
 						 <STM32F429_PG14_FUNC_ETH_MII_TXD1_ETH_RMII_TXD1>,
-- 
2.7.4

