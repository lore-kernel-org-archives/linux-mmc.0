From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/3] ARM: dts: keystone-k2g-evm: Add "vqmmc-supply" property for mmc0/mmc1
Date: Wed, 25 Apr 2018 18:57:44 +0530
Message-ID: <20180425132746.13911-2-kishon@ti.com>
References: <20180425132746.13911-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425132746.13911-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kishon@ti.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Add "vqmmc-supply" property for mmc0/mmc1 to indicate the supply connected
to the IO lines. Also add dt node for ldo1 regulator required for mmc1
vqmmc-supply.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 6a4657799b99..60b4f59899d2 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -37,6 +37,14 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	vcc1v8_ldo1_reg: fixedregulator-vcc1v8-ldo1 {
+		compatible = "regulator-fixed";
+		regulator-name = "ldo1";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
 };
 
 &k2g_pinctrl {
@@ -130,6 +138,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	vmmc-supply = <&vcc3v3_dcin_reg>;
+	vqmmc-supply = <&vcc3v3_dcin_reg>;
 	cd-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
@@ -138,6 +147,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vcc3v3_dcin_reg>; /* VCC3V3_EMMC is connected to VCC3V3_DCIN */
+	vqmmc-supply = <&vcc1v8_ldo1_reg>;
 	ti,non-removable;
 	status = "okay";
 };
-- 
2.17.0
