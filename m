From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/2] dt-bindings: mmc: Document the Amlogic Meson8 and Meson8b SDIO bindings
Date: Tue,  3 Oct 2017 13:24:16 +0200
Message-ID: <20171003112417.31860-2-martin.blumenstingl@googlemail.com>
References: <20171003112417.31860-1-martin.blumenstingl@googlemail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50976 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdJCLY2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Oct 2017 07:24:28 -0400
In-Reply-To: <20171003112417.31860-1-martin.blumenstingl@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, Carlo Caione <carlo@endlessm.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>

From: Carlo Caione <carlo@endlessm.com>

This documents the devicetree bindings for the SDIO/MMC host found in
Amlogic Meson8 and Meson8b SoCs. It supports the SD specification v2.0
and the eMMC specification v4.41.
It has an internal "mux" which allows connecting up to three MMC devices
to it. The maximum supported bus-width is 4-bits.

Amlogic's GPL kernel sources call it "SDIO" to differentiate it from the
other MMC controller in (at least the Meson8 and Meson8b) the SoCs (they
call the other one "SDHC", which supports a bus-width of up to 8-bits).

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mmc/amlogic,meson-mx-sdio.txt         | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
new file mode 100644
index 000000000000..8765c605e6bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
@@ -0,0 +1,54 @@
+* Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
+
+The highspeed MMC host controller on Amlogic SoCs provides an interface
+for MMC, SD, SDIO and SDHC types of memory cards.
+
+Supported maximum speeds are the ones of the eMMC standard 4.41 as well
+as the speed of SD standard 2.0.
+
+The hardware provides an internal "mux" which allows up to three slots
+to be controlled. Only one slot can be accessed at a time.
+
+Required properties:
+ - compatible : must be one of
+	- "amlogic,meson8-sdio"
+	- "amlogic,meson8b-sdio"
+	along with the generic "amlogic,meson-mx-sdio"
+ - reg : mmc controller base registers
+ - interrupts : mmc controller interrupt
+ - #address-cells : must be 1
+ - size-cells : must be 0
+ - clocks : phandle to clock providers
+ - clock-names : must contain "core" and "clkin"
+
+Required child nodes:
+A node for each slot provided by the MMC controller is required.
+NOTE: due to a driver limitation currently only one slot (= child node)
+      is supported!
+
+Required properties on each child node (= slot):
+ - compatible : must be "mmc-slot" (see mmc.txt within this directory)
+ - reg : the slot (or "port") ID
+
+Optional properties on each child node (= slot):
+ - bus-width : must be 1 or 4 (8-bit bus is not supported)
+ - for cd and all other additional generic mmc parameters
+   please refer to mmc.txt within this directory
+
+Examples:
+	mmc@c1108c20 {
+		compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
+		reg = <0xc1108c20 0x20>;
+		interrupts = <0 28 1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
+		clock-names = "core", "clkin";
+
+		slot@1 {
+			compatible = "mmc-slot";
+			reg = <1>;
+
+			bus-width = <4>;
+		};
+	};
-- 
2.14.2

