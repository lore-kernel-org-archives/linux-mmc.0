From: Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v2 8/9] DT: stm32f469-disco: add node for SDIO controller
Date: Tue, 10 Jan 2017 09:42:15 +0100
Message-ID: <1484037736-25029-9-git-send-email-andrea.merello@gmail.com>
References: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33486 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030935AbdAJImz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 03:42:55 -0500
Received: by mail-wm0-f66.google.com with SMTP id r144so19166033wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 00:42:54 -0800 (PST)
In-Reply-To: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com, Andrea Merello <andrea.merello@gmail.com>

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi      |  2 +-
 arch/arm/boot/dts/stm32f469-disco.dts | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

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
index 8877c00..7b3458e 100644
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
@@ -78,6 +85,28 @@
 	clock-frequency = <8000000>;
 };
 
+&pinctrl {
+	sdio-cd {
+		sdio_cd: sdio-cd {
+			pins {
+				pinmux = <STM32F429_PG2_FUNC_GPIO>;
+				bias-pull-up;
+			};
+		};
+	};
+};
+
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

