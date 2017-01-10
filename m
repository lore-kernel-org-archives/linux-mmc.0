From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v2 6/9] DT: stm32f429: add pin map for SDIO controller
Date: Tue, 10 Jan 2017 09:42:13 +0100
Message-ID: <1484037736-25029-7-git-send-email-andrea.merello@gmail.com>
References: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33468 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030943AbdAJImx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 03:42:53 -0500
Received: by mail-wm0-f66.google.com with SMTP id r144so19165940wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 00:42:53 -0800 (PST)
In-Reply-To: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

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

