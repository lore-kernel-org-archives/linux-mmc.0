From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 11/12] arm64: dts: marvell: add sdhci support for Armada 7K/8K
Date: Fri,  9 Dec 2016 11:30:07 +0100
Message-ID: <923c97f32a828b579756bf86946689ed54a0a174.1481279228.git-series.gregory.clement@free-electrons.com>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37438 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932926AbcLIKas (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2016 05:30:48 -0500
In-Reply-To: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>

Also enable it on the Armada 7040 DB board

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts |  7 +++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi  |  9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 070b589680c5..f7f978a12a49 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -146,3 +146,10 @@
 &cpm_usb3_1 {
 	status = "okay";
 };
+
+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	non-removable;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 7b6136182ad0..e812fb59fb80 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -229,6 +229,15 @@
 
 			};
 
+			sdhci0: sdhci@6e0000 {
+				compatible = "marvell,armada-7000-sdhci";
+				reg = <0x6e0000 0x300>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "core";
+				clocks = <&cpm_syscon0 1 4>;
+				status = "disabled";
+			};
+
 			ap_syscon: system-controller@6f4000 {
 				compatible = "marvell,ap806-system-controller",
 					     "syscon";
-- 
git-series 0.9.1
