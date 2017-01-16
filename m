From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v3 8/9] ARM: DTS: enable SDIO controller on stm32f469 disco board
Date: Mon, 16 Jan 2017 08:37:17 +0100
Message-ID: <1484552238-23171-9-git-send-email-andrea.merello@gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35902 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbdAPHhr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2017 02:37:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id r126so28767137wmr.3
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2017 23:37:46 -0800 (PST)
In-Reply-To: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

This patch adds SDIO-related DT nodes required by stm32f469 board

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi      |  2 +-
 arch/arm/boot/dts/stm32f469-disco.dts | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index c12a64e..5aba383 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -206,7 +206,7 @@
 			reg = <0x40007000 0x400>;
 		};
 
-		pin-controller {
+		pinctrl:pin-controller {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stm32f429-pinctrl";
diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 8877c00..420ccb3 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -65,6 +65,13 @@
 		serial0 = &usart3;
 	};
 
+	mmc_vcard: mmc_vcard {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc_vcard";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	soc {
 		dma-ranges = <0xc0000000 0x0 0x10000000>;
 	};
@@ -78,6 +85,17 @@
 	clock-frequency = <8000000>;
 };
 
+&sdio {
+	status = "okay";
+	vmmc-supply = <&mmc_vcard>;
+	cd-gpios = <&gpiog 2 0>;
+	cd-inverted;
+	pinctrl-names = "default", "opendrain";
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-1 = <&sdio_pins_od>;
+	bus-width = <4>;
+};
+
 &usart3 {
 	status = "okay";
 };
-- 
2.7.4

