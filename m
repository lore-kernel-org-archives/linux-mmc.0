From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v7 12/13] arm64: dts: marvell: add sdhci support for Armada 7K/8K
Date: Thu, 30 Mar 2017 17:23:04 +0200
Message-ID: <08d6b21af1fd65783062c14e5896700d25c602f3.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43368 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934103AbdC3PXa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 11:23:30 -0400
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda

Also enable it on the Armada 7040 DB and Armada 8040 DB boards.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts       | 14 +++++++++++++-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts       | 12 +++++++++++-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 11 ++++++++++-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 11 ++++++++++-
 4 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 070b589680c5..6adbfcd26369 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -146,3 +146,17 @@
 &cpm_usb3_1 {
 	status = "okay";
 };
+
+&ap_sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+};
+
+&cpm_sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 6e6f182fb297..3d9565bf6e91 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -148,3 +148,15 @@
 &cps_usb3_1 {
 	status = "okay";
 };
+
+&ap_sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	non-removable;
+};
+
+&cpm_sdhci0 {
+	status = "okay";
+	bus-width = <8>;
+	non-removable;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 5019c8f4acd0..fe41bf9c301e 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -229,6 +229,17 @@
 
 			};
 
+			ap_sdhci0: sdhci@6e0000 {
+				compatible = "marvell,armada-ap806-sdhci";
+				reg = <0x6e0000 0x300>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "core";
+				clocks = <&ap_syscon 4>;
+				dma-coherent;
+				marvell,xenon-phy-slow-mode;
+				status = "disabled";
+			};
+
 			ap_syscon: system-controller@6f4000 {
 				compatible = "marvell,ap806-system-controller",
 					     "syscon";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 3a99c36433d6..f07ea5aeac48 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -173,6 +173,17 @@
 				clocks = <&cpm_syscon0 1 25>;
 				status = "okay";
 			};
+
+			cpm_sdhci0: sdhci@780000 {
+				compatible = "marvell,armada-cp110-sdhci";
+				reg = <0x780000 0x300>;
+				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "core";
+				clocks = <&cpm_syscon0 1 4>;
+				dma-coherent;
+				status = "disabled";
+			};
+
 		};
 
 		cpm_pcie0: pcie@f2600000 {
-- 
git-series 0.9.1
