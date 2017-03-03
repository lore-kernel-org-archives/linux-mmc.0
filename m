From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 6/7] arm64: dts: ls1046a: add clocks property and compatible for eSDHC node
Date: Fri, 3 Mar 2017 16:18:48 +0800
Message-ID: <1488529129-23560-7-git-send-email-yangbo.lu@nxp.com>
References: <1488529129-23560-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:6801
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751514AbdCCIeL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Mar 2017 03:34:11 -0500
In-Reply-To: <1488529129-23560-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

The eSDHC could select peripheral clock or platform clock as clock source.
In default, we use platform clock. This patch is to add clocks property
describing peripheral clock for eSDHC node. The driver could use common clk
APIs to get peripheral clock. Also add a compatible for ls1046a eSDHC node.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None
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

