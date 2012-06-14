From: Jonathan Kliegman <kliegs@chromium.org>
Subject: [PATCH] mmc: dw_mmc: Fix null dma_ops access when use_dma is false
Date: Thu, 14 Jun 2012 13:31:55 -0400
Message-ID: <1339695115-606-1-git-send-email-kliegs@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46027 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276Ab2FNRcY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jun 2012 13:32:24 -0400
Received: by vcbf11 with SMTP id f11so1168641vcb.19
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jun 2012 10:32:23 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jonathan Kliegman <kliegs@chromium.org>

host->dma_ops is not valid if host->usa dma is 0 so protect
host->dma_ops reference in dw_mci_resume

Signed-off-by: Jonathan Kliegman <kliegs@chromium.org>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ca5e72..e2758d5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2175,7 +2175,7 @@ int dw_mci_resume(struct dw_mci *host)
 		return ret;
 	}
 
-	if (host->dma_ops->init)
+	if (host->use_dma && host->dma_ops->init)
 		host->dma_ops->init(host);
 
 	/* Restore the old value at FIFOTH register */
-- 
1.7.7.3

