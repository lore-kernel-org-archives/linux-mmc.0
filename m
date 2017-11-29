From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: r8a77995: draak: enable SDHI2
Date: Wed, 29 Nov 2017 17:06:46 +0100
Message-ID: <1511971606-580-3-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1511971606-580-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41794 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933345AbdK2QG4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Nov 2017 11:06:56 -0500
In-Reply-To: <1511971606-580-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: horms@verge.net.au, geert@linux-m68k.org
Cc: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, magnus.damm@gmail.com, linux-mmc@vger.kernel.org, marek.vasut@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

The single SDHI controller is connected to eMMC.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 91f247f..e690cf8 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -32,6 +32,24 @@
 		/* first 128MB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x18000000>;
 	};
+
+	reg_1p8v: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &extal_clk {
@@ -71,6 +89,18 @@
 		function = "scif2";
 	};
 
+	sdhi2_pins: sd2 {
+		groups = "mmc_data8", "mmc_ctrl";
+		function = "mmc";
+		power-source = <1800>;
+	};
+
+	sdhi2_pins_uhs: sd2_uhs {
+		groups = "mmc_data8", "mmc_ctrl";
+		function = "mmc";
+		power-source = <1800>;
+	};
+
 	usb0_pins: usb0 {
 		groups = "usb0";
 		function = "usb0";
@@ -125,6 +155,20 @@
 	status = "okay";
 };
 
+&sdhi2 {
+	/* used for on-board eMMC */
+	pinctrl-0 = <&sdhi2_pins>;
+	pinctrl-1 = <&sdhi2_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	status = "okay";
+};
+
 &usb2_phy0 {
 	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
-- 
2.7.4

