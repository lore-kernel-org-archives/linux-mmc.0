From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] mmc: sdhci-bcm-kona: Use sdhci_pltfm_unregister instead
 of open coded
Date: Tue, 17 Sep 2013 15:59:32 +0800
Message-ID: <1379404772.12080.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:59987 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab3IQH7i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2013 03:59:38 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so5258176pdj.29
        for <linux-mmc@vger.kernel.org>; Tue, 17 Sep 2013 00:59:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Christian Daudt <csd@broadcom.com>, linux-mmc@vger.kernel.org

This avoid duplicated implementation and also fixes missing iounmap() and
release_mem_region() calls in sdhci_bcm_kona_remove().
sdhci_pltfm_init() calls request_mem_region() and ioremap(), thus we need to
call the corresponding iounmap() and release_mem_region() calls in
sdhci_bcm_kona_remove().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/sdhci-bcm-kona.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 85472d3..7a190fe 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -316,19 +316,7 @@ err_pltfm_free:
 
 static int __exit sdhci_bcm_kona_remove(struct platform_device *pdev)
 {
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-	int dead;
-	u32 scratch;
-
-	dead = 0;
-	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
-	if (scratch == (u32)-1)
-		dead = 1;
-	sdhci_remove_host(host, dead);
-
-	sdhci_free_host(host);
-
-	return 0;
+	return sdhci_pltfm_unregister(pdev);
 }
 
 static struct platform_driver sdhci_bcm_kona_driver = {
-- 
1.8.1.2



