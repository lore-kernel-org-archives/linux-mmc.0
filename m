From: Hongtao Wu <wuht06@gmail.com>
Subject: [RFC PATCH v3 2/3] Documentation: Add Spreadtrum MMC DT bindings.
Date: Sat, 15 Aug 2015 00:55:52 +0800
Message-ID: <1439571353-30165-3-git-send-email-wuht06@gmail.com>
References: <y>
 <1439571353-30165-1-git-send-email-wuht06@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439571353-30165-1-git-send-email-wuht06@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, shawn.lin@rock-chips.com
Cc: Orson.Zhai@spreadtrum.com, Chunyan.Zhang@spreadtrum.com, Jason.Wu@spreadtrum.com
List-Id: linux-mmc@vger.kernel.org

The bindings is used to interpret Spreadtrum MMC dts file.

Signed-off-by: Billows Wu(WuHongtao) <wuht06@gmail.com>
---
 Documentation/devicetree/bindings/mmc/sprd-mmc.txt |   46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sprd-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/sprd-mmc.txt b/Documentation/devicetree/bindings/mmc/sprd-mmc.txt
new file mode 100644
index 0000000..9603059
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sprd-mmc.txt
@@ -0,0 +1,46 @@
+* Spreadtrum MMC Host Controller
+
+The Spreadtrum MMC Host Controller provides an interface for MMC, SD, and SDIO
+types of memory cards. This file documents differences between the core
+properties described by mmc.txt and the properties used by the Spreadtrum MMC
+driver.
+
+Required properties:
+- compatible:
+ should be "sprd,sdhost-3.0": in order to compatible with MMC controller
+ version
+- reg: Registers location and length
+- interrupts: exactly one interrupt specifier
+- clocks: phandle to input clocks
+
+Optional properties:
+- cd-gpios: specify GPIOs for card detection, see gpio binding
+- vmmc-supply: phandle to input sdio core voltage
+- vqmmc-supply: phandle to input sdio signal voltage
+
+*NOTE*
+- The following properties are defined by spreadtrum. They are not standard
+ properties of SDIO.
+- sprd,name: The name of the MMC device. For Example, "emmc", "wifi" and "sd".
+  The capabilities of different MMC device can be set by this property in
+  spreadtrum MMC host driver.
+- sprd,delay: This property value that obtained by hardware testing are fixed.
+ prop-encoded-array <wr-dl rd-pos-dl rd-neg-dl> where:
+    * wr-dl is the delay value between sdio clock signal and data write in
+        milliseconds
+    * rd-pos-dl is the delay value between sdio clock signal and posedge data
+        read in milliseconds
+    * rd-neg-dl is the delay value between sdio clock signal and negedge data
+        read in milliseconds
+
+Example:
+
+sdio0@abc0000 {
+    compatible  = "sprd,sdhost-3.0";
+    reg = <0 0xabc00000 0 0x1000>;
+    interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+    vmmc-supply = <&vddemmccore>;
+    vqmmc-supply = <&vddgen0>;
+    clocks = <&ext_192m>;
+    sprd,delay = <0x3 0xa 0xa>;
+};
--
1.7.9.5
