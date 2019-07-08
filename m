From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 1/2] dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
Date: Mon,  8 Jul 2019 19:33:29 +0200
Message-ID: <20190708173330.13217-2-martin.blumenstingl@googlemail.com>
References: <20190708173330.13217-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190708173330.13217-1-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, robh+dt@kernel.org, ulf.hansson@linaro.org, jianxin.pan@amlogic.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-mmc@vger.kernel.org

This documents the devicetree bindings for the SDHC MMC host controller
found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
HS200 mode (up to 100MHz clock).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/mmc/amlogic,meson-mx-sdhc.txt    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.txt

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.txt
new file mode 100644
index 000000000000..afe14210030c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.txt
@@ -0,0 +1,34 @@
+* Amlogic Meson6, Meson8, Meson8b and Meson8m2 SDHC controller
+
+The SDHC MMC host controller on Amlogic SoCs provides an eMMC and MMC
+card interface with 1/4/8-bit bus width.
+It supports eMMC spec 4.4x/4.5x including HS200 (up to 100MHz clock).
+
+This file documents the properties in addition to those available in
+the MMC core bindings, documented by mmc.txt.
+
+Required properties:
+ - compatible : must be one of
+	- "amlogic,meson8-sdhc"
+	- "amlogic,meson8b-sdhc"
+	- "amlogic,meson8m2-sdhc"
+	preceded by the generic "amlogic,meson-mx-sdhc"
+ - reg : register base address and size
+ - interrupts : SDHC controller interrupt
+ - clocks : phandle to clock providers
+ - clock-names : "pclk", "clkin0", "clkin1", "clkin2" and "clkin3"
+		 ("pclk" is the module gate clock, and clkin are
+		  the inputs to the internal clock mux)
+
+Examples:
+	mmc@8e00 {
+		compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
+		reg = <0x8e00 0x42>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&clkc CLKID_SDHC>,
+			<&clkc CLKID_XTAL>,
+			<&clkc CLKID_FCLK_DIV4>,
+			<&clkc CLKID_FCLK_DIV3>,
+			<&clkc CLKID_FCLK_DIV5>;
+		clock-names = "pclk", "clkin0", "clkin1", "clkin2", "clkin3";
+	};
-- 
2.22.0
