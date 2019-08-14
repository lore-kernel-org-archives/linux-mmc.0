From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v1 3/4] arm64: dts: ls1028a: fix little-big endian issue for dcfg
Date: Wed, 14 Aug 2019 15:26:48 +0800
Message-ID: <20190814072649.8237-3-yinbo.zhu@nxp.com>
References: <20190814072649.8237-1-yinbo.zhu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814072649.8237-1-yinbo.zhu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Li Yang <leoyang.li@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Amit Jain <amit.jain_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com, Alison Wang <alison.wang@nxp.com>, Alex Marginean <alexandru.marginean@nxp.com>, Catalin Horghidan <catalin.horghidan@nxp.com>, Rajat Srivastava <rajat.srivastava@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

dcfg use little endian that SoC register value will be correct

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index b0d4f8916ede..5538e8e354b2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -162,7 +162,7 @@
 		dcfg: syscon@1e00000 {
 			compatible = "fsl,ls1028a-dcfg", "syscon";
 			reg = <0x0 0x1e00000 0x0 0x10000>;
-			big-endian;
+			little-endian;
 		};
 
 		scfg: syscon@1fc0000 {
-- 
2.17.1
