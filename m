From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/12] ARM: dts: dra72-evm: Add pinmux configuration for MMC
Date: Fri, 16 Jun 2017 17:24:37 +0530
Message-ID: <20170616115439.8508-11-kishon@ti.com>
References: <20170616115439.8508-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170616115439.8508-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, kishon@ti.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Include dra72x-mmc-iodelay.dtsi which has pinmux and IODelay
configuration values for the various MMC modes for dra72 SoC
and use it in the pinctrl properties of MMC devicetree
nodes present in dra72-evm.dts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 99fdb3d8445b..c572693b1665 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -6,6 +6,7 @@
  * published by the Free Software Foundation.
  */
 #include "dra72-evm-common.dtsi"
+#include "dra72x-mmc-iodelay.dtsi"
 / {
 	model = "TI DRA722";
 
@@ -55,9 +56,22 @@
 };
 
 &mmc1 {
+	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_hs>;
+	pinctrl-2 = <&mmc1_pins_sdr12>;
+	pinctrl-3 = <&mmc1_pins_sdr25>;
+	pinctrl-4 = <&mmc1_pins_sdr50>;
+	pinctrl-5 = <&mmc1_pins_ddr50_rev10>;
+	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev10_conf>;
 	vqmmc-supply = <&ldo1_reg>;
 };
 
 &mmc2 {
+	pinctrl-names = "default", "hs", "ddr_1_8v", "hs200_1_8v";
+	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-1 = <&mmc2_pins_hs>;
+	pinctrl-2 = <&mmc2_pins_ddr_rev10>;
+	pinctrl-3 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_rev10_conf>;
 	vmmc-supply = <&evm_1v8_sw>;
 };
-- 
2.11.0
