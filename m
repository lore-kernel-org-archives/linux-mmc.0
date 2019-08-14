From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v1 4/4] mmc: sdhci-of-esdhc: add erratum A011334 support in ls1028a 1.0 SoC
Date: Wed, 14 Aug 2019 15:26:49 +0800
Message-ID: <20190814072649.8237-4-yinbo.zhu@nxp.com>
References: <20190814072649.8237-1-yinbo.zhu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814072649.8237-1-yinbo.zhu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Li Yang <leoyang.li@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Amit Jain <amit.jain_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com, Alison Wang <alison.wang@nxp.com>, Alex Marginean <alexandru.marginean@nxp.com>, Catalin Horghidan <catalin.horghidan@nxp.com>, Rajat Srivastava <rajat.srivastava@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

This patch is to add erratum A011334 support in ls1028a 1.0 SoC

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index b16f7d440f78..eb2b290447fc 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1006,6 +1006,7 @@ static struct soc_device_attribute soc_incorrect_hostver[] = {
 static struct soc_device_attribute soc_fixup_sdhc_clkdivs[] = {
 	{ .family = "QorIQ LX2160A", .revision = "1.0", },
 	{ .family = "QorIQ LX2160A", .revision = "2.0", },
+	{ .family = "QorIQ LS1028A", .revision = "1.0", },
 	{ },
 };
 
-- 
2.17.1
