From: Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 3/3] arm64: allwinner: h6: enable MMC0/2 on Pine H64
Date: Thu, 19 Jul 2018 12:28:10 +0800
Message-ID: <20180719042810.6546-4-icenowy@aosc.io>
References: <20180719042810.6546-1-icenowy@aosc.io>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719042810.6546-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
List-Id: linux-mmc@vger.kernel.org

The Pine H64 board have a MicroSD slot connected to MMC0 controller of
the H6 SoC and a eMMC slot connected to MMC2.

Enable them in the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Use real regulator instead of dummy regulator.

 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 1673636358ef..ceffc40810ee 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -41,6 +41,24 @@
 	};
 };
 
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&reg_cldo1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&reg_cldo1>;
+	vqmmc-supply = <&reg_bldo2>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
 &r_i2c {
 	status = "okay";
 
-- 
2.17.1
