From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v1 1/4] arm64: dts: ls1028a-rdb: enable emmc hs400 mode
Date: Wed, 14 Aug 2019 15:26:46 +0800
Message-ID: <20190814072649.8237-1-yinbo.zhu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Li Yang <leoyang.li@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Amit Jain <amit.jain_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com, Alison Wang <alison.wang@nxp.com>, Alex Marginean <alexandru.marginean@nxp.com>, Catalin Horghidan <catalin.horghidan@nxp.com>, Rajat Srivastava <rajat.srivastava@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

This patch is to enable emmc hs400 mode for ls1028ardb

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 8a725409e881..f1e46cc4cea1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -92,8 +92,10 @@
 	};
 
 &esdhc1 {
-	status = "okay";
 	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width = <8>;
+	status = "okay";
 	};
 
 &i2c0 {
-- 
2.17.1
