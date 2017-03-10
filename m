From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v12 1/9] dt-bindings: mmc: Add Cavium SOCs MMC bindings
Date: Fri, 10 Mar 2017 14:24:59 +0100
Message-ID: <20170310132507.32025-2-jglauber@cavium.com>
References: <20170310132507.32025-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170310132507.32025-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>
List-Id: linux-mmc@vger.kernel.org

Add description of Cavium Octeon and ThunderX SOC device tree bindings.

CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: Rob Herring <robh+dt@kernel.org>
---
 .../devicetree/bindings/mmc/cavium-mmc.txt         | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/cavium-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/cavium-mmc.txt b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
new file mode 100644
index 0000000..225c2be
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
@@ -0,0 +1,58 @@
+* Cavium Octeon & ThunderX MMC controller
+
+The highspeed MMC host controller on Caviums SoCs provides an interface
+for MMC and SD types of memory cards.
+
+Supported maximum speeds are the ones of the eMMC standard 4.41 as well
+as the speed of SD standard 4.0. Only 3.3 Volt is supported.
+
+Required properties:
+ - compatible : should be one of:
+   cavium,octeon-6130-mmc
+   cavium,octeon-6130-mmc-slot
+   cavium,octeon-7890-mmc
+   cavium,octeon-7890-mmc-slot
+   cavium,thunder-8190-mmc
+   cavium,thunder-8190-mmc-slot
+   cavium,thunder-8390-mmc
+   cavium,thunder-8390-mmc-slot
+ - reg : mmc controller base registers
+ - clocks : phandle
+
+Optional properties:
+ - for cd, bus-width and additional generic mmc parameters
+   please refer to mmc.txt within this directory
+ - cavium,cmd-clk-skew : number of coprocessor clocks before sampling command
+ - cavium,dat-clk-skew : number of coprocessor clocks before sampling data
+
+Deprecated properties:
+- spi-max-frequency : use max-frequency instead
+- cavium,bus-max-width : use bus-width instead
+
+Examples:
+	mmc_1_4: mmc@1,4 {
+		compatible = "cavium,thunder-8390-mmc";
+		reg = <0x0c00 0 0 0 0>;	/* DEVFN = 0x0c (1:4) */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&sclk>;
+
+		mmc-slot@0 {
+			compatible = "cavium,thunder-8390-mmc-slot";
+			reg = <0>;
+			vmmc-supply = <&mmc_supply_3v3>;
+			max-frequency = <42000000>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+		};
+
+		mmc-slot@1 {
+			compatible = "cavium,thunder-8390-mmc-slot";
+			reg = <1>;
+			vmmc-supply = <&mmc_supply_3v3>;
+			max-frequency = <42000000>;
+			bus-width = <8>;
+			cap-mmc-highspeed;
+			non-removable;
+		};
+	};
-- 
2.9.0.rc0.21.g7777322
