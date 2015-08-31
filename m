From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 8/8] ARM: dts: rockchip: add tuning related settings to veyron
 devices
Date: Mon, 31 Aug 2015 20:24:06 +0200
Message-ID: <1441045446-30858-9-git-send-email-heiko@sntech.de>
References: <1441045446-30858-1-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1441045446-30858-1-git-send-email-heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This allows the tuning code to run and use higher speeds on capable cards.

Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi | 7 ++++++-
 arch/arm/boot/dts/rk3288-veyron.dtsi       | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi b/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
index b5334ec..24a7a11 100644
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
+	default-sample-phase = <90>;
 	num-slots = <1>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	vmmc-supply = <&vcc33_sd>;
 	vqmmc-supply = <&vccio_sd>;
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index df7d70d..394aa80 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -194,7 +194,9 @@
 	broken-cd;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	default-sample-phase = <158>;
 	disable-wp;
+	mmc-hs200-1_8v;
 	mmc-pwrseq = <&emmc_pwrseq>;
 	non-removable;
 	num-slots = <1>;
@@ -409,6 +411,10 @@
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
2.1.4
