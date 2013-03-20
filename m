From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mmc: sdhci-{pxav2,pxav3}: Use of_match_ptr() macro
Date: Wed, 20 Mar 2013 15:48:30 +0800
Message-ID: <1363765710.3758.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:62301 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3CTHsn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Mar 2013 03:48:43 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so1142774pbb.4
        for <linux-mmc@vger.kernel.org>; Wed, 20 Mar 2013 00:48:42 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Kevin Liu <kliu5@marvell.com>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org

This eliminates having an #ifdef returning NULL for the case
when OF is disabled.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/sdhci-pxav2.c |    4 +---
 drivers/mmc/host/sdhci-pxav3.c |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index eeb7d43..d57c047 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -262,9 +262,7 @@ static struct platform_driver sdhci_pxav2_driver = {
 	.driver		= {
 		.name	= "sdhci-pxav2",
 		.owner	= THIS_MODULE,
-#ifdef CONFIG_OF
-		.of_match_table = sdhci_pxav2_of_match,
-#endif
+		.of_match_table = of_match_ptr(sdhci_pxav2_of_match),
 		.pm	= SDHCI_PLTFM_PMOPS,
 	},
 	.probe		= sdhci_pxav2_probe,
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index a0cdbc5..bbadfbd 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -439,9 +439,7 @@ static const struct dev_pm_ops sdhci_pxav3_pmops = {
 static struct platform_driver sdhci_pxav3_driver = {
 	.driver		= {
 		.name	= "sdhci-pxav3",
-#ifdef CONFIG_OF
-		.of_match_table = sdhci_pxav3_of_match,
-#endif
+		.of_match_table = of_match_ptr(sdhci_pxav3_of_match),
 		.owner	= THIS_MODULE,
 		.pm	= SDHCI_PXAV3_PMOPS,
 	},
-- 
1.7.9.5



