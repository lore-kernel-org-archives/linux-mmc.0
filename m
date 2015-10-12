From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 7/7] ARM: dts: rockchip: add tuning related settings to veyron devices
Date: Mon, 12 Oct 2015 14:48:30 +0200
Message-ID: <1444654110-32293-8-git-send-email-heiko@sntech.de>
References: <1444654110-32293-1-git-send-email-heiko@sntech.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:52078 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbbJLMsi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Oct 2015 08:48:38 -0400
In-Reply-To: <1444654110-32293-1-git-send-email-heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org, Heiko Stuebner <heiko@sntech.de>

This allows the tuning code to run and use higher speeds on capable cards.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi | 7 ++++++-
 arch/arm/boot/dts/rk3288-veyron.dtsi       | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi b/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
index b5334ec..fec076e 100644
--- a/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
@@ -90,7 +90,7 @@
 	regulators {
 		vccio_sd: LDO_REG4 {
 			regulator-name = "vccio_sd";
-			regulator-min-microvolt = <3300000>;
+			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-state-mem {
 				regulator-off-in-suspend;
@@ -116,7 +116,12 @@
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
 	cd-gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
+	rockchip,default-sample-phase = <90>;
 	num-slots = <1>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	vmmc-supply = <&vcc33_sd>;
 	vqmmc-supply = <&vccio_sd>;
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 6820977..04c3d2a 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -196,7 +196,9 @@
 	broken-cd;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	rockchip,default-sample-phase = <158>;
 	disable-wp;
+	mmc-hs200-1_8v;
 	mmc-pwrseq = <&emmc_pwrseq>;
 	non-removable;
 	num-slots = <1>;
@@ -413,6 +415,10 @@
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdio0_clk &sdio0_cmd &sdio0_bus4>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	vmmc-supply = <&vcc33_sys>;
 	vqmmc-supply = <&vcc18_wl>;
 };
-- 
2.6.1

