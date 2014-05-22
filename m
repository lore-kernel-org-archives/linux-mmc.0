From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 2/8] mmc: sdhci-st: STMicroelectronics SDHCI binding documentation.
Date: Thu, 22 May 2014 16:18:16 +0100
Message-ID: <1400771902-26553-3-git-send-email-peter.griffin@linaro.org>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: peter.griffin@linaro.org, kernel@stlinux.com, lee.jones@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds the device tree binding documentation for ST
SDHCI driver. It contains the differences between the core properties
in mmc.txt and the properties used by the sdhci-st driver.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-st.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-st.txt b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
new file mode 100644
index 0000000..ae3dae0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
@@ -0,0 +1,26 @@
+* STMicroelectronics sdhci-st MMC/SD controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-st driver
+
+Required properties:
+- compatible: "st,sdhci"
+- clocks: card clock, must be "mmc".
+
+Optional properties:
+- reset: to provide a reset to the HC.
+- non-removable: non-removable slot (bindings/mmc/mmc.txt).
+
+Example:
+
+mmc0: sdhci@fe81e000 {
+	compatible	= "st,sdhci";
+	status		= "disabled";
+	reg		= <0xfe81e000 0x1000>;
+	interrupts	= <GIC_SPI 127 IRQ_TYPE_NONE>;
+	interrupt-names	= "mmcirq";
+	pinctrl-names	= "default";
+	pinctrl-0	= <&pinctrl_mmc0>;
+	clock-names	= "mmc";
+	clocks		= <&clk_s_a1_ls 1>;
+};
-- 
1.9.1
