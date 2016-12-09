From: Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: add DT binding for S3C24XX MMC/SD/SDIO controller
Date: Fri,  9 Dec 2016 11:14:43 -0200
Message-ID: <1481289284-19919-2-git-send-email-sergio.prado@e-labworks.com>
References: <1481289284-19919-1-git-send-email-sergio.prado@e-labworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481289284-19919-1-git-send-email-sergio.prado@e-labworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
Cc: Sergio Prado <sergio.prado@e-labworks.com>
List-Id: linux-mmc@vger.kernel.org

Adds the device tree bindings description for Samsung S3C24XX
MMC/SD/SDIO controller, used as a connectivity interface with external
MMC, SD and SDIO storage mediums.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mmc/samsung,s3cmci.txt     | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt

diff --git a/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
new file mode 100644
index 000000000000..d09dbf4b3824
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
@@ -0,0 +1,34 @@
+* Samsung's S3C24XX MMC/SD/SDIO controller device tree bindings
+
+Samsung's S3C24XX MMC/SD/SDIO controller is used as a connectivity interface
+with external MMC, SD and SDIO storage mediums.
+
+This file documents differences between the core mmc properties described by
+mmc.txt and the properties used by the Samsung S3C24XX MMC/SD/SDIO controller
+implementation.
+
+Required SoC Specific Properties:
+- compatible: should be one of the following
+  - "samsung,s3c2410-sdi": for controllers compatible with s3c2410
+  - "samsung,s3c2412-sdi": for controllers compatible with s3c2412
+  - "samsung,s3c2440-sdi": for controllers compatible with s3c2440
+- clocks: Should reference the controller clock
+- clock-names: Should contain "sdi"
+
+Example:
+	mmc0: mmc@5a000000 {
+		compatible = "samsung,s3c2440-sdi";
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdi_pins>;
+		reg = <0x5a000000 0x100000>;
+		interrupts = <0 0 21 3>;
+		clocks = <&clocks PCLK_SDI>;
+		clock-names = "sdi";
+		bus-width = <4>;
+		cd-gpios = <&gpg 8 GPIO_ACTIVE_LOW>;
+		wp-gpios = <&gph 8 GPIO_ACTIVE_LOW>;
+	};
+
+	Note: This example shows both SoC specific and board specific properties
+	in a single device node. The properties can be actually be separated
+	into SoC specific node and board specific node.
-- 
1.9.1
