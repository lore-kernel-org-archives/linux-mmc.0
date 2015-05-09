From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] mmc: host: sdhci: Use BUG_ON()
Date: Sat,  9 May 2015 18:44:51 -0300
Message-ID: <1431207891-21448-3-git-send-email-festevam@gmail.com>
References: <1431207891-21448-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:33359 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbbEIVpa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 May 2015 17:45:30 -0400
Received: by qcvo8 with SMTP id o8so29058253qcv.0
        for <linux-mmc@vger.kernel.org>; Sat, 09 May 2015 14:45:29 -0700 (PDT)
In-Reply-To: <1431207891-21448-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Use BUG_ON() instead of an 'if' condition followed by BUG().

The semantic patch that makes this change is available
in scripts/coccinelle/misc/bugon.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/sdhci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c80287a..8d97fe0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -328,8 +328,7 @@ static void sdhci_read_block_pio(struct sdhci_host *host)
 	local_irq_save(flags);
 
 	while (blksize) {
-		if (!sg_miter_next(&host->sg_miter))
-			BUG();
+		BUG_ON(!sg_miter_next(&host->sg_miter));
 
 		len = min(host->sg_miter.length, blksize);
 
@@ -374,8 +373,7 @@ static void sdhci_write_block_pio(struct sdhci_host *host)
 	local_irq_save(flags);
 
 	while (blksize) {
-		if (!sg_miter_next(&host->sg_miter))
-			BUG();
+		BUG_ON(!sg_miter_next(&host->sg_miter));
 
 		len = min(host->sg_miter.length, blksize);
 
-- 
1.9.1

