From: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v13 1/6] dt-bindings: mmc: Add Cavium SOCs MMC bindings
Date: Thu, 30 Mar 2017 17:31:23 +0200
Message-ID: <20170330153128.22842-2-jglauber@cavium.com>
References: <20170330153128.22842-1-jglauber@cavium.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170330153128.22842-1-jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "Steven J . Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Add description of Cavium Octeon and ThunderX SOC device tree bindings.

CC: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
CC: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Signed-off-by: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Steven J. Hill <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Acked-by: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/mmc/cavium-mmc.txt         | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/cavium-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/cavium-mmc.txt b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
new file mode 100644
index 0000000..1433e62
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
@@ -0,0 +1,57 @@
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
+   cavium,octeon-7890-mmc
+   cavium,thunder-8190-mmc
+   cavium,thunder-8390-mmc
+   mmc-slot
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
+- power-gpios : use vmmc-supply instead
+- cavium,octeon-6130-mmc-slot : use mmc-slot instead
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
+			compatible = "mmc-slot";
+			reg = <0>;
+			vmmc-supply = <&mmc_supply_3v3>;
+			max-frequency = <42000000>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+		};
+
+		mmc-slot@1 {
+			compatible = "mmc-slot";
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
