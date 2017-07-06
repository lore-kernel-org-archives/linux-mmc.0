From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdhci-xenon: remove pointless struct xenon_priv *priv
Date: Thu,  6 Jul 2017 16:15:23 +0800
Message-ID: <1499328923-89408-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:47839 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753359AbdGFIPy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jul 2017 04:15:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Hu Ziji <huziji@marvell.com>, Shawn Lin <shawn.lin@rock-chips.com>

It was never used and leave a long standing compile warning:

drivers/mmc/host/sdhci-xenon.c: In function 'xenon_probe':
drivers/mmc/host/sdhci-xenon.c:447:21: warning: variable 'priv' set but
not used [-Wunused-but-set-variable]

Remove it to fix the warning.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-xenon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index bc1781b..6ef33aa 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -444,7 +444,6 @@ static int xenon_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
-	struct xenon_priv *priv;
 	int err;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
@@ -453,7 +452,6 @@ static int xenon_probe(struct platform_device *pdev)
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
-	priv = sdhci_pltfm_priv(pltfm_host);
 
 	/*
 	 * Link Xenon specific mmc_host_ops function,
-- 
1.9.1


