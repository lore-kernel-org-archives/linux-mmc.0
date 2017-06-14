From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 16/21] arm64: dts: hisi: add kirin pcie node
Date: Wed, 14 Jun 2017 16:23:33 +0800
Message-ID: <20170614082338.15673-17-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, Xiaowei Song <songxiaowei@hisilicon.com>, Guodong Xu <guodong.xu@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Xiaowei Song <songxiaowei@hisilicon.com>

Add PCIe node for hi3660, and add binding documentation.

Cc: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 4101bf5..bdfdf27 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -817,5 +817,37 @@
 			cs-gpios = <&gpio18 5 0>;
 			status = "disabled";
 		};
+
+		pcie@f4000000 {
+			compatible = "hisilicon,kirin960-pcie";
+			reg = <0x0 0xf4000000 0x0 0x1000>,
+			      <0x0 0xff3fe000 0x0 0x1000>,
+			      <0x0 0xf3f20000 0x0 0x40000>,
+			      <0x0 0xf5000000 0x0 0x2000>;
+			reg-names = "dbi", "apb", "phy", "config";
+			bus-range = <0x0  0x1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0x00000000 0x0
+				  0xf6000000 0x0 0x2000000>;
+			num-lanes = <1>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <0x0 0 0 1 &gic 0 0 0 282 4>,
+					<0x0 0 0 2 &gic 0 0 0  283 4>,
+					<0x0 0 0 3 &gic 0 0 0  284 4>,
+					<0x0 0 0 4 &gic 0 0 0  285 4>;
+			clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
+				 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
+				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
+				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
+				 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
+			clock-names = "pcie_phy_ref", "pcie_aux",
+				      "pcie_apb_phy", "pcie_apb_sys",
+				      "pcie_aclk";
+			reset-gpios = <&gpio11 1 0 >;
+			status = "ok";
+		};
 	};
 };
-- 
2.10.2
