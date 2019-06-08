From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
Date: Sun,  9 Jun 2019 01:23:12 +0530
Message-ID: <20190608195317.6336-3-manivannan.sadhasivam@linaro.org>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org, sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org, linus.walleij@linaro.org, linux-clk@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Add devicetree binding for Actions Semi Owl SoC's SD/MMC/SDIO controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/mmc/owl-mmc.txt       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.txt b/Documentation/devicetree/bindings/mmc/owl-mmc.txt
new file mode 100644
index 000000000000..a702f8d66cec
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/owl-mmc.txt
@@ -0,0 +1,37 @@
+Actions Semi Owl SoCs SD/MMC/SDIO controller
+
+Required properties:
+- compatible: should be "actions,owl-mmc"
+- reg: offset and length of the register set for the device.
+- interrupts: single interrupt specifier.
+- clocks: single clock specifier of the controller clock.
+- resets: phandle to the reset line.
+- dma-names: should be "mmc".
+- dmas: single DMA channel specifier
+
+Optional properties:
+- pinctrl-names: pinctrl state names "default" must be defined.
+- pinctrl-0: phandle referencing pin configuration of the controller.
+- bus-width: see mmc.txt
+- cap-sd-highspeed: see mmc.txt
+- cap-mmc-highspeed: see mmc.txt
+- sd-uhs-sdr12: see mmc.txt
+- sd-uhs-sdr25: see mmc.txt
+- sd-uhs-sdr50: see mmc.txt
+- non-removable: see mmc.txt
+
+Example:
+
+		mmc0: mmc@e0330000 {
+			compatible = "actions,owl-mmc";
+			reg = <0x0 0xe0330000 0x0 0x4000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD0>;
+			resets = <&cmu RESET_SD0>;
+			dmas = <&dma 2>;
+			dma-names = "mmc";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_default>;
+			bus-width = <4>;
+			cap-sd-highspeed;
+		};
-- 
2.17.1
