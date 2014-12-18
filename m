From: Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 3/3] ARM: dts: rk3288: Add drive/sample clocks for dw_mmc devices
Date: Thu, 18 Dec 2014 15:01:03 -0800
Message-ID: <1418943663-10012-4-git-send-email-amstan@chromium.org>
References: <1418943663-10012-1-git-send-email-amstan@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:43821 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbaLRXB0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 18:01:26 -0500
Received: by mail-ob0-f179.google.com with SMTP id va2so6959124obc.10
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 15:01:25 -0800 (PST)
In-Reply-To: <1418943663-10012-1-git-send-email-amstan@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tgih.jun@samsung.com, jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: Heiko Stuebner <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, addy ke <addy.ke@rock-chips.com>, Andrew Bresticker <abrestic@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Kever Yang <kever.yang@rock-chips.com>, Mike Turquette <mturquette@linaro.org>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Alexandru M Stan <amstan@chromium.org>

The drive/sample clocks can be phase shifted.  The drive clock
could be used in a future patch to adjust hold times.  The sample
clock is used for tuning.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Doug Anderson <dianders@chromium.org>
Suggested-by: Heiko Stuebner <heiko@sntech.de>
Suggested-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 9c35a1d..49e498e 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -150,8 +150,9 @@
 	sdmmc: dwmmc@ff0c0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
+			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0c0000 0x4000>;
@@ -161,8 +162,9 @@
 	sdio0: dwmmc@ff0d0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>,
+			 <&cru SCLK_SDIO0_DRV>, <&cru SCLK_SDIO0_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0d0000 0x4000>;
@@ -172,8 +174,9 @@
 	sdio1: dwmmc@ff0e0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_SDIO1>, <&cru SCLK_SDIO1>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_SDIO1>, <&cru SCLK_SDIO1>,
+			 <&cru SCLK_SDIO1_DRV>, <&cru SCLK_SDIO1_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0e0000 0x4000>;
@@ -183,8 +186,9 @@
 	emmc: dwmmc@ff0f0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		clock-freq-min-max = <400000 150000000>;
-		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
-		clock-names = "biu", "ciu";
+		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
+			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0f0000 0x4000>;
-- 
2.2.0.rc0.207.ga3a616c

