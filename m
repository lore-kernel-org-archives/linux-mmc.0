From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v5 2/2] Documentation: DT: MMC: meson-gx: new bindings doc
Date: Wed, 19 Oct 2016 09:12:05 -0700
Message-ID: <20161019161205.28565-2-khilman@baylibre.com>
References: <20161019161205.28565-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161019161205.28565-1-khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/mmc/amlogic,meson-gx.txt   | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
new file mode 100644
index 000000000000..a2fa9a1c26ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
@@ -0,0 +1,33 @@
+Amlogic SD / eMMC controller for S905/GXBB family SoCs
+
+The MMC 5.1 compliant host controller on Amlogic provides the
+interface for SD, eMMC and SDIO devices.
+
+This file documents the properties in addition to those available in
+the MMC core bindings, documented by mmc.txt.
+
+Required properties:
+- compatible : contains one of:
+  - "amlogic,meson-gx-mmc"
+  - "amlogic,meson-gxbb-mmc"
+  - "amlogic,meson-gxl-mmc"
+  - "amlogic,meson-gxm-mmc"
+- clocks     : A list of phandle + clock-specifier pairs for the clocks listed in clock-names.
+- clock-names: Should contain the following:
+	"core" - Main peripheral bus clock
+	"clkin0" - Parent clock of internal mux
+	"clkin1" - Other parent clock of internal mux
+  The driver has an interal mux clock which switches between clkin0 and clkin1 depending on the
+  clock rate requested by the MMC core.
+
+Example:
+
+	sd_emmc_a: mmc@70000 {
+        	compatible = "amlogic,meson-gxbb-mmc";
+		reg = <0x0 0x70000 0x0 0x2000>;
+                interrupts = < GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&clkc CLKID_SD_EMMC_A>, <&xtal>, <&clkc CLKID_FCLK_DIV2>;
+		clock-names = "core", "clkin0", "clkin1";
+		pinctrl-0 = <&emmc_pins>;
+	};
+
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
