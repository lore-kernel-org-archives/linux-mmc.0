From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v3 05/21] arm64: dts: Add I2C nodes for Hi3660
Date: Wed, 14 Jun 2017 16:23:22 +0800
Message-ID: <20170614082338.15673-6-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de
Cc: devicetree@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>, linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, zhangfei.gao@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>

Add I2C nodes for Hi3660-hikey960.

On HiKey960,
I2C0, I2C7 are connected to Low Speed Expansion Connector.
I2C1 is connected to ADV7535.
I2C3 is connected to USB5734.

Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 22 +++++++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 56 +++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 64875a5..1a4d6c5 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -29,6 +29,28 @@
 	};
 };
 
+&i2c0 {
+	/* On Low speed expansion */
+	label = "LS-I2C0";
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	adv7533: adv7533@39 {
+		status = "ok";
+		compatible = "adi,adv7533";
+		reg = <0x39>;
+	};
+};
+
+&i2c7 {
+	/* On Low speed expansion */
+	label = "LS-I2C1";
+	status = "okay";
+};
+
 &uart5 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index f55710a..9abe84e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -186,6 +186,62 @@
 			#reset-cells = <2>;
 		};
 
+		i2c0: i2c@ffd71000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xffd71000 0x0 0x1000>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_I2C0>;
+			resets = <&iomcu_rst 0x20 3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@ffd72000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xffd72000 0x0 0x1000>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_I2C1>;
+			resets = <&iomcu_rst 0x20 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@fdf0c000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xfdf0c000 0x0 0x1000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_I2C3>;
+			resets = <&crg_rst 0x78 7>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c3_pmx_func &i2c3_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c7: i2c@fdf0b000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xfdf0b000 0x0 0x1000>;
+			interrupts = <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clock-frequency = <400000>;
+			clocks = <&crg_ctrl HI3660_CLK_GATE_I2C7>;
+			resets = <&crg_rst 0x60 14>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c7_pmx_func &i2c7_cfg_func>;
+			status = "disabled";
+		};
+
 		uart5: serial@fdf05000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf05000 0x0 0x1000>;
-- 
2.10.2
