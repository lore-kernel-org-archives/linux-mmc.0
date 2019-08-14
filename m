From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v1 2/4] soc: fsl: guts: Add definition for LS1028A
Date: Wed, 14 Aug 2019 15:26:47 +0800
Message-ID: <20190814072649.8237-2-yinbo.zhu@nxp.com>
References: <20190814072649.8237-1-yinbo.zhu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814072649.8237-1-yinbo.zhu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Li Yang <leoyang.li@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Amit Jain <amit.jain_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com, Alison Wang <alison.wang@nxp.com>, Alex Marginean <alexandru.marginean@nxp.com>, Catalin Horghidan <catalin.horghidan@nxp.com>, Rajat Srivastava <rajat.srivastava@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

Adding compatible string "ls1028a-dcfg" to initialize guts driver
for ls1028 and SoC die attribute definition for LS1028A

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/soc/fsl/guts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 1ef8068c8dd3..34810f9bb2ee 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -102,6 +102,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
 	  .svr          = 0x87360000,
 	  .mask         = 0xff3f0000,
 	},
+	/* Die: LS1028A, SoC: LS1028A */
+	{ .die          = "LS1028A",
+	  .svr          = 0x870b0000,
+	  .mask         = 0xff3f0000,
+	},
 	{ },
 };
 
@@ -224,6 +229,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,ls1012a-dcfg", },
 	{ .compatible = "fsl,ls1046a-dcfg", },
 	{ .compatible = "fsl,lx2160a-dcfg", },
+	{ .compatible = "fsl,ls1028a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
-- 
2.17.1
