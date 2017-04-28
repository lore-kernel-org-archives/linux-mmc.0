From: Hu Ziji <huziji@marvell.com>
Subject: [PATCH -next 1/2] mmc: sdhci-xenon: Fix the work flow in
 xenon_remove().
Date: Fri, 28 Apr 2017 10:34:59 +0800
Message-ID: <e05202317167dc118edd6e2404b3eebc03de57bb.1493275842.git.huziji@marvell.com>
References: <cover.1493275841.git.huziji@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56222 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967136AbdD1Cgv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Apr 2017 22:36:51 -0400
Content-Disposition: inline
In-Reply-To: <cover.1493275841.git.huziji@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, dougj@marvell.com, jszhang@marvell.com, nadavh@marvell.com, ygao@marvell.com, xigu@marvell.com, liuw@marvell.com, dingwei@marvell.com, huziji@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, zjwu@marvell.com

sdhci_remove_host() might execute SOFT_RESET_ALL.
Inside xenon_remove(), Xenon SDHC should be enabled during
sdhci_remove_host().

Move xenon_sdhc_unprepare after sdhci_remove_host() such that Xenon
SDHC is disabled after sdhci_remove_host() completes.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Reported-by: Jisheng Zhang <jszhang@marvell.com>
Tested-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-xenon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 3b82a0b..786c3ed 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -514,10 +514,10 @@ static int xenon_remove(struct platform_device *pdev)
 
 	xenon_clean_phy(host);
 
-	xenon_sdhc_unprepare(host);
-
 	sdhci_remove_host(host, 0);
 
+	xenon_sdhc_unprepare(host);
+
 	clk_disable_unprepare(pltfm_host->clk);
 
 	sdhci_pltfm_free(pdev);
-- 
2.7.4

