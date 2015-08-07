From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [RFC PATCH] ARM: dts: rockchip: Add wifi support for firefly
Date: Fri,  7 Aug 2015 16:12:05 +0200
Message-ID: <1438956725-4188-1-git-send-email-michael@amarulasolutions.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36555 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbbHGOLp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Aug 2015 10:11:45 -0400
Received: by wicgj17 with SMTP id gj17so63186415wic.1
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2015 07:11:43 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: heiko@sntech.de, michael@amarulasolutions.com
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, dianders@chromium.org, romain.perier@gmail.com

This patch enable wifi support for the firefly board.
Card answer to me that support from 2.0V but regulator is connected
to 1.8V, so voltage capability is wrong. In order to avoid this
we just defined a fixed regulator trigger by the wifi enable gpio
that report 2.0V.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 43 +++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 0b42372..fcf234e 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -116,6 +116,28 @@
 		vin-supply = <&vcc_io>;
 	};
 
+	io_domains: io-domains {
+		compatible = "rockchip,rk3288-io-voltage-domain";
+		rockchip,grf = <&grf>;
+
+		wifi-supply = <&vcc_18>;
+		audio-supply = <&vcca_33>;
+	};
+
+	vcc_wifi: wifi-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdio0_pwr>;
+		regulator-name = "vcc_wifi";
+		regulator-min-microvolt = <2000000>;
+		regulator-max-microvolt = <2000000>;
+		startup-delay-us = <100000>;
+		regulator-always-on;
+		vin-supply = <&vcc_io>;
+	};
+
 	vcc_flash: flash-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_flash";
@@ -437,13 +459,30 @@
 &sdio0 {
 	broken-cd;
 	bus-width = <4>;
+	clock-freq-min-max = <400000 50000000>;
 	disable-wp;
 	non-removable;
+	cap-sd-highspeed;
 	num-slots = <1>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
-	vmmc-supply = <&vcc_18>;
+	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdio0_int>;
+
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
+	cap-sdio-irq;
+
+	vmmc-supply = <&vcc_wifi>;
 	status = "okay";
+
+	brcmf: bcrmf@0 {
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&gpio4>;
+		reg = <0>;
+		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "host-wake";
+		status = "okay";
+	};
 };
 
 &sdmmc {
-- 
1.9.1

