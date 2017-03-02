From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 8/9] arm64: dts: ls1046a: add clocks property and compatible
 for eSDHC node
Date: Thu, 2 Mar 2017 17:47:29 +0800
Message-ID: <1488448050-7574-9-git-send-email-yangbo.lu@nxp.com>
References: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, Xiaobo Xie <xiaobo.xie@nxp.com>, linux-arm-kernel@lists.infradead.org, Yangbo Lu <yangbo.lu@nxp.com>
List-Id: linux-mmc@vger.kernel.org

The eSDHC could select peripheral clock or platform clock as clock source.
In default, we use platform clock. This patch is to add clocks property
describing peripheral clock for eSDHC node. The driver could use common clk
APIs to get peripheral clock. Also add a compatible for ls1046a eSDHC node.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 4a164b8..141a513 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -209,10 +209,11 @@
 		};
 
 		esdhc: esdhc@1560000 {
-			compatible = "fsl,esdhc";
+			compatible = "fsl,ls1046a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <0>;
+			clocks = <&clockgen 2 1>;
 			voltage-ranges = <1800 1800 3300 3300>;
 			sdhci,auto-cmd12;
 			big-endian;
-- 
2.1.0.27.g96db324
