From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v6 2/2] Documentation: DT: MMC: meson-gx: new bindings doc
Date: Wed, 19 Oct 2016 11:18:25 -0700
Message-ID: <20161019181825.2186-2-khilman@baylibre.com>
References: <20161019181825.2186-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32841 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944560AbcJSSS2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2016 14:18:28 -0400
Received: by mail-pf0-f176.google.com with SMTP id 128so20159320pfz.0
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2016 11:18:28 -0700 (PDT)
In-Reply-To: <20161019181825.2186-1-khilman@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
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

