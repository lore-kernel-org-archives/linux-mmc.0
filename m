From: Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH 3/3] ARM: dts: iwg20m: Add MMCIF0 support
Date: Wed, 12 Jul 2017 11:03:25 +0100
Message-ID: <1499853805-5915-4-git-send-email-chris.paterson2@renesas.com>
References: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:64407 "EHLO
        relmlie4.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755271AbdGLKEM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jul 2017 06:04:12 -0400
In-Reply-To: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Biju Das <biju.das@bp.renesas.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Paterson <chris.paterson2@renesas.com>

Define the iwg20m board dependent part of the MMCIF0 device node.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index 001ca91..ffce1b6 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -22,8 +22,34 @@
 		device_type = "memory";
 		reg = <2 0x00000000 0 0x20000000>;
 	};
+
+	reg_3p3v: 3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &extal_clk {
 	clock-frequency = <20000000>;
 };
+
+&pfc {
+	mmcif0_pins: mmc {
+		groups = "mmc_data8", "mmc_ctrl";
+		function = "mmc";
+	};
+};
+
+&mmcif0 {
+		pinctrl-0 = <&mmcif0_pins>;
+		pinctrl-names = "default";
+
+		vmmc-supply = <&reg_3p3v>;
+		bus-width = <8>;
+		non-removable;
+		status = "okay";
+};
-- 
1.9.1

