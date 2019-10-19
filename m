From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 03/11] DTS: ARM: pandora-common: define wl1251 as child node of mmc3
Date: Sat, 19 Oct 2019 20:41:18 +0200
Message-ID: <bec9d76e6da03d734649b9bdf76e9d575c57631a.1571510481.git.hns@goldelico.com>
References: <cover.1571510481.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1571510481.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundati>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Since v4.7 the dma initialization requires that there is a
device tree property for "rx" and "tx" channels which is
not provided by the pdata-quirks initialization.

By conversion of the mmc3 setup to device tree this will
finally allows to remove the OpenPandora wlan specific omap3
data-quirks.

Fixes: 81eef6ca9201 ("mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel")

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: <stable@vger.kernel.org> # 4.7.0
---
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 37 +++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index ec5891718ae6..c595b3eb314d 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -226,6 +226,18 @@
 		gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;	/* GPIO_164 */
 	};
 
+	/* wl1251 wifi+bt module */
+	wlan_en: fixed-regulator-wg7210_en {
+		compatible = "regulator-fixed";
+		regulator-name = "vwlan";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		startup-delay-us = <50000>;
+		regulator-always-on;
+		enable-active-high;
+		gpio = <&gpio1 23 GPIO_ACTIVE_HIGH>;
+	};
+
 	/* wg7210 (wifi+bt module) 32k clock buffer */
 	wg7210_32k: fixed-regulator-wg7210_32k {
 		compatible = "regulator-fixed";
@@ -522,9 +534,30 @@
 	/*wp-gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;*/	/* GPIO_127 */
 };
 
-/* mmc3 is probed using pdata-quirks to pass wl1251 card data */
 &mmc3 {
-	status = "disabled";
+	vmmc-supply = <&wlan_en>;
+
+	bus-width = <4>;
+	non-removable;
+	ti,non-removable;
+	cap-power-off-card;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	wlan: wl1251@1 {
+		compatible = "ti,wl1251";
+
+		reg = <1>;
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;	/* GPIO_21 */
+
+		ti,wl1251-has-eeprom;
+	};
 };
 
 /* bluetooth*/
-- 
2.19.1
