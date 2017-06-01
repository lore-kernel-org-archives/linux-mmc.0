From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5/7] ARM: dts: dra7-evm: Correct the vmmc-supply for mmc2
Date: Thu, 1 Jun 2017 20:03:59 +0530
Message-ID: <20170601143401.16852-6-kishon@ti.com>
References: <20170601143401.16852-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170601143401.16852-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, kishon@ti.com, Ravikumar Kattekola <rk@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Ravikumar Kattekola <rk@ti.com>

On DRA75x EVM, MMC2 vdd/ios are connected to a common supply fixed at 1.8V
not 3.3V

Fixes: 6cf02dbb4b71 ("ARM: dts: dra7-evm: Add mmc2 node for eMMC support")
Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 31a9e061ddd0..e5d7e7f5f645 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -25,6 +25,14 @@
 		stdout-path = &uart1;
 	};
 
+	evm_1v8_sw: fixedregulator-evm_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "evm_1v8";
+		vin-supply = <&smps9_reg>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	evm_3v3_sd: fixedregulator-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3_sd";
@@ -451,7 +459,7 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_default>;
-	vmmc-supply = <&evm_3v3_sw>;
+	vmmc-supply = <&evm_1v8_sw>;
 	bus-width = <8>;
 };
 
-- 
2.11.0
