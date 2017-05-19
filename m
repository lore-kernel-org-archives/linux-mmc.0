From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 20/41] ARM: dts: dra7-evm: Correct the vmmc-supply for mmc2
Date: Fri, 19 May 2017 13:45:20 +0530
Message-ID: <20170519081541.26753-21-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
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
index 4bc4b575c99b..fbcb3199defd 100644
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
@@ -449,7 +457,7 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_default>;
-	vmmc-supply = <&evm_3v3_sw>;
+	vmmc-supply = <&evm_1v8_sw>;
 	bus-width = <8>;
 };
 
-- 
2.11.0
