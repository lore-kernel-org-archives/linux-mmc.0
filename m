From: Hu Ziji <huziji@marvell.com>
Subject: [PATCH -next 2/2] mmc: sdhci-xenon: Fix the default value of
 LOGIC_TIMING_ADJUST register in eMMC 5.0 PHY
Date: Fri, 28 Apr 2017 10:35:15 +0800
Message-ID: <50ac97be8a5696487750791f231ab2606eb800bb.1493275842.git.huziji@marvell.com>
References: <cover.1493275841.git.huziji@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56237 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1031447AbdD1ChJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Apr 2017 22:37:09 -0400
Content-Disposition: inline
In-Reply-To: <cover.1493275841.git.huziji@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, dougj@marvell.com, jszhang@marvell.com, nadavh@marvell.com, ygao@marvell.com, xigu@marvell.com, liuw@marvell.com, dingwei@marvell.com, huziji@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, zjwu@marvell.com

The default value of LOGIC_TIMING_ADJUST register in eMMC 5.0 PHY
is different from that in eMMC 5.1 PHY.
Set the specific value for that register in eMMC 5.0 PHY.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Reported-by: Jisheng Zhang <jszhang@marvell.com>
Tested-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 4bdbcd3..31d08cf 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -108,6 +108,7 @@
 
 #define XENON_EMMC_5_0_PHY_LOGIC_TIMING_ADJUST	\
 	(XENON_EMMC_5_0_PHY_REG_BASE + 0x14)
+#define XENON_EMMC_5_0_PHY_LOGIC_TIMING_VALUE	0x5A54
 #define XENON_EMMC_PHY_LOGIC_TIMING_ADJUST	(XENON_EMMC_PHY_REG_BASE + 0x18)
 #define XENON_LOGIC_TIMING_VALUE		0x00AA8977
 
@@ -130,6 +131,8 @@ struct xenon_emmc_phy_regs {
 	u16 logic_timing_adj;
 	/* DLL Update Enable bit */
 	u32 dll_update;
+	/* value in Logic Timing Adjustment register */
+	u32 logic_timing_val;
 };
 
 static const char * const phy_types[] = {
@@ -166,6 +169,7 @@ static struct xenon_emmc_phy_regs xenon_emmc_5_0_phy_regs = {
 	.dll_ctrl	= XENON_EMMC_5_0_PHY_DLL_CONTROL,
 	.logic_timing_adj = XENON_EMMC_5_0_PHY_LOGIC_TIMING_ADJUST,
 	.dll_update	= XENON_DLL_UPDATE_STROBE_5_0,
+	.logic_timing_val = XENON_EMMC_5_0_PHY_LOGIC_TIMING_VALUE,
 };
 
 static struct xenon_emmc_phy_regs xenon_emmc_5_1_phy_regs = {
@@ -176,6 +180,7 @@ static struct xenon_emmc_phy_regs xenon_emmc_5_1_phy_regs = {
 	.dll_ctrl	= XENON_EMMC_PHY_DLL_CONTROL,
 	.logic_timing_adj = XENON_EMMC_PHY_LOGIC_TIMING_ADJUST,
 	.dll_update	= XENON_DLL_UPDATE,
+	.logic_timing_val = XENON_LOGIC_TIMING_VALUE,
 };
 
 /*
@@ -607,7 +612,7 @@ static void xenon_emmc_phy_set(struct sdhci_host *host,
 
 	if (timing == MMC_TIMING_MMC_HS400)
 		/* Hardware team recommend a value for HS400 */
-		sdhci_writel(host, XENON_LOGIC_TIMING_VALUE,
+		sdhci_writel(host, phy_regs->logic_timing_val,
 			     phy_regs->logic_timing_adj);
 	else
 		xenon_emmc_phy_disable_data_strobe(host);
-- 
2.7.4

