From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 15/21] dt-bindings: PCI: hisi: Add document for PCIe of Kirin SoCs
Date: Wed, 14 Jun 2017 16:23:32 +0800
Message-ID: <20170614082338.15673-16-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, Xiaowei Song <songxiaowei@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org

From: Xiaowei Song <songxiaowei@hisilicon.com>

This patch adds document for PCIe of Kirin SoC series.

Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/kirin-pcie.txt         | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
new file mode 100644
index 0000000..68ffa0f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
@@ -0,0 +1,50 @@
+HiSilicon Kirin SoCs PCIe host DT description
+
+Kirin PCIe host controller is based on Designware PCI core.
+It shares common functions with PCIe Designware core driver
+and inherits common properties defined in
+Documentation/devicetree/bindings/pci/designware-pci.txt.
+
+Additional properties are described here:
+
+Required properties
+- compatible:
+	"hisilicon,kirin960-pcie" for PCIe of Kirin960 SoC
+- reg: Should contain rc_dbi, apb, phy, config registers location and length.
+- reg-names: Must include the following entries:
+  "dbi": controller configuration registers;
+  "apb": apb Ctrl register defined by Kirin;
+  "phy": apb PHY register defined by Kirin;
+  "config": PCIe configuration space registers.
+- reset-gpios: The gpio to generate PCIe perst assert and deassert signal.
+
+Optional properties:
+
+Example based on kirin960:
+
+	pcie@f4000000 {
+		compatible = "hisilicon,kirin-pcie";
+		reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
+		      <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF4000000 0 0x2000>;
+		reg-names = "dbi","apb","phy", "config";
+		bus-range = <0x0  0x1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x02000000 0x0 0x00000000 0x0 0xf5000000 0x0 0x2000000>;
+		num-lanes = <1>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0x0 0 0 1 &gic 0 0 0  282 4>,
+				<0x0 0 0 2 &gic 0 0 0  283 4>,
+				<0x0 0 0 3 &gic 0 0 0  284 4>,
+				<0x0 0 0 4 &gic 0 0 0  285 4>;
+		clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
+			 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
+			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
+			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
+			 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
+		clock-names = "pcie_phy_ref", "pcie_aux",
+			      "pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
+		reset-gpios = <&gpio11 1 0 >;
+	};
-- 
2.10.2
