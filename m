From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/5] mmc: dw_mmc: remove the "supports-highspeed" property.
Date: Mon, 12 May 2014 20:14:13 +0900
Message-ID: <1399893256-7071-3-git-send-email-jh80.chung@samsung.com>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43622 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbaELLO3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 May 2014 07:14:29 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5G00IOZKK3Q780@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 12 May 2014 20:14:27 +0900 (KST)
In-reply-to: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org, dinguyen@altera.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the "support-highspeed" property in dw-mmc.
"support-highspeed" property can be replaced to "cap-sd/mmc-highspeed".

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    1 -
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |    1 -
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |    3 ---
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |    2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |    2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |    4 ++--
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |    6 +++---
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |    4 ++--
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    4 ++--
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |    4 ++--
 arch/arm/boot/dts/socfpga_arria5.dtsi              |    3 ++-
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    3 ++-
 arch/arm/boot/dts/socfpga_vt.dts                   |    3 ++-
 drivers/mmc/host/dw_mmc.c                          |    3 ---
 15 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index 532b1d4..fdab6e7 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -69,7 +69,6 @@ Example:
 
 	dwmmc0@12200000 {
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
index b8653ea..7674026 100644
--- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
@@ -34,7 +34,6 @@ Example:
 		num-slots = <1>;
 		vmmc-supply = <&ldo12>;
 		fifo-depth = <0x100>;
-		supports-highspeed;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
 		slot@0 {
diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 2d4a725..a8b24d7 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -67,8 +67,6 @@ Optional properties:
 * card-detect-delay: Delay in milli-seconds before detecting card after card
   insert event. The default value is 0.
 
-* supports-highspeed: Enables support for high speed cards (up to 50MHz)
-
 * broken-cd: as documented in mmc core bindings.
 
 * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
@@ -98,7 +96,6 @@ board specific portions as listed below.
 		clock-frequency = <400000000>;
 		clock-freq-min-max = <400000 200000000>;
 		num-slots = <1>;
-		supports-highspeed;
 		broken-cd;
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 31db28a..77f69d2 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -45,7 +45,7 @@
 		status = "okay";
 
 		num-slots = <1>;
-		supports-highspeed;
+		cap-mmc-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index e2c0dca..a0806ce 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -128,7 +128,7 @@
 		status = "okay";
 
 		num-slots = <1>;
-		supports-highspeed;
+		cap-mmc-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 9583563..cfcd4a3 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -459,7 +459,7 @@
 
 	mmc@12550000 {
 		num-slots = <1>;
-		supports-highspeed;
+		cap-mmc-highspeed;
 		broken-cd;
 		non-removable;
 		card-detect-delay = <200>;
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 090f983..c023e3c 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -399,7 +399,7 @@
 	mmc_0: mmc@12200000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
+		cap-mmc-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
@@ -418,7 +418,7 @@
 	mmc_2: mmc@12220000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
+		cap-sd-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
index 2c1560d..0efa33b 100644
--- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
@@ -248,7 +248,7 @@
 
 	mmc@12200000 {
 		num-slots = <1>;
-		supports-highspeed;
+		cap-mmc-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
@@ -265,7 +265,7 @@
 
 	mmc@12220000 {
 		num-slots = <1>;
-		supports-highspeed;
+		cap-sd-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
@@ -282,7 +282,7 @@
 
 	mmc@12230000 {
 		num-slots = <1>;
-		supports-highspeed;
+		cap-sd-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index a794a70..9c1a2e6 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -282,7 +282,7 @@
 	mmc@12200000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
+		cap-mmc-highspeed;
 		broken-cd;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
@@ -300,7 +300,7 @@
 	mmc@12220000 {
 		status = "okay";
 		num-slots = <1>;
-		supports-highspeed;
+		cap-sd-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 80a3bf4..6b4bb5e 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -40,7 +40,7 @@
 	mmc@12200000 {
 		status = "okay";
 		broken-cd;
-		supports-highspeed;
+		cap-mmc-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <0 4>;
@@ -57,7 +57,7 @@
 
 	mmc@12220000 {
 		status = "okay";
-		supports-highspeed;
+		cap-sd-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 6910485..b336590 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -71,7 +71,7 @@
 	mmc@12200000 {
 		status = "okay";
 		broken-cd;
-		supports-highspeed;
+		cap-mmc-highspped;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <0 4>;
@@ -87,7 +87,7 @@
 
 	mmc@12220000 {
 		status = "okay";
-		supports-highspeed;
+		cap-sd-highspeed;
 		card-detect-delay = <200>;
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index 6c87b70..0c6080e 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -29,7 +29,8 @@
 
 		dwmmc0@ff704000 {
 			num-slots = <1>;
-			supports-highspeed;
+			cap-mmc-highspeed;
+			cap-sd-highspeed;
 			broken-cd;
 
 			slot@0 {
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index ca41b0e..10a1c13 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -30,7 +30,8 @@
 
 		dwmmc0@ff704000 {
 			num-slots = <1>;
-			supports-highspeed;
+			cap-mmc-highspeed;
+			cap-sd-highspeed;
 			broken-cd;
 
 			slot@0 {
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index 87d6f75..66b2aa1 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -43,7 +43,8 @@
 
 		dwmmc0@ff704000 {
 			num-slots = <1>;
-			supports-highspeed;
+			cap-mmc-highspeed;
+			cap-sd-highspeed;
 			broken-cd;
 
 			slot@0 {
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7d4d9ea..75d7d4e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2284,9 +2284,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			return ERR_PTR(ret);
 	}
 
-	if (of_find_property(np, "supports-highspeed", NULL))
-		pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
-
 	return pdata;
 }
 
-- 
1.7.9.5

