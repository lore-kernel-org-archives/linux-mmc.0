From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v7 11/13] arm64: dts: marvell: add eMMC support for Armada 37xx
Date: Thu, 30 Mar 2017 17:23:03 +0200
Message-ID: <f02cef05e7348975ba5a01443f90ce4147e52edd.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda
List-Id: linux-mmc@vger.kernel.org

Add the eMMC support for Armada 37xx SoC and enable it in the Armada 3720
DB board.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts |  9 +++++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 86602c907a61..c84623dd334a 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -106,6 +106,15 @@
 	status = "okay";
 };
 
+&sdhci0 {
+	non-removable;
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	marvell,pad-type = "fixed-1-8v";
+	status = "okay";
+};
+
 /* CON31 */
 &usb3 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index b48d668a6ab6..4c499b86fb8b 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -213,6 +213,17 @@
 				};
 			};
 
+			sdhci0: sdhci@d8000 {
+				compatible = "marvell,armada-3700-sdhci",
+				"marvell,sdhci-xenon";
+				reg = <0xd8000 0x300
+				       0x17808 0x4>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&nb_periph_clk 0>;
+				clock-names = "core";
+				status = "disabled";
+			};
+
 			sata: sata@e0000 {
 				compatible = "marvell,armada-3700-ahci";
 				reg = <0xe0000 0x2000>;
-- 
git-series 0.9.1
