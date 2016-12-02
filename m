From: Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH 1/2] dt-bindings: mmc: add DT binding for S3C24XX MMC/SD/SDIO
 controller
Date: Thu,  1 Dec 2016 22:14:24 -0200
Message-ID: <1480637665-6325-2-git-send-email-sergio.prado@e-labworks.com>
References: <1480637665-6325-1-git-send-email-sergio.prado@e-labworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1480637665-6325-1-git-send-email-sergio.prado@e-labworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
Cc: Sergio Prado <sergio.prado@e-labworks.com>
List-Id: linux-mmc@vger.kernel.org

Adds the device tree bindings description for Samsung S3C24XX
MMC/SD/SDIO controller, used as a connectivity interface with external
MMC, SD and SDIO storage mediums.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 .../devicetree/bindings/mmc/samsung,s3cmci.txt     | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt

diff --git a/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
new file mode 100644
index 000000000000..3f044076e69a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
@@ -0,0 +1,38 @@
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
+Required Board Specific Properties:
+- pinctrl-0: Should specify pin control groups used for this controller.
+- pinctrl-names: Should contain only one value - "default".
+
+Example:
+	sdi: sdi@5a000000 {
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
