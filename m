From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 02/10] mmc: sdhci-st: ST Microelectronics SDHCI binding
 documentation.
Date: Wed,  4 Jun 2014 17:30:16 +0100
Message-ID: <1401899424-1365-3-git-send-email-peter.griffin@linaro.org>
References: <1401899424-1365-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401899424-1365-1-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com
Cc: peter.griffin@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, kernel@stlinux.com, Giuseppe Cavallaro <peppe.cavallaro@st.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds the device tree binding documentation for the ST
SDHCI driver. It documents the differences between the core properties
described by mmc.txt and the properties used by the sdhci-st driver.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-st.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-st.txt b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
new file mode 100644
index 0000000..7527db4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
@@ -0,0 +1,33 @@
+* STMicroelectronics sdhci-st MMC/SD controller
+
+This file documents the differences between the core properties in
+Documentation/devicetree/bindings/mmc/mmc.txt and the properties
+used by the sdhci-st driver.
+
+Required properties:
+- compatible :  Must be "st,sdhci"
+- clock-names : Should be "mmc"
+                See: Documentation/devicetree/bindings/resource-names.txt
+- clocks :      Phandle of the clock used by the sdhci controler
+                See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Optional properties:
+- non-removable: non-removable slot
+                 See: Documentation/devicetree/bindings/mmc/mmc.txt
+- bus-width: Number of data lines
+                 See: Documentation/devicetree/bindings/mmc/mmc.txt
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
+	bus-width       = <8>
+};
-- 
1.9.1
