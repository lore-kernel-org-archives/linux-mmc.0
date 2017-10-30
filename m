From: "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH] mmc: fix white space around call to request_irq
Date: Mon, 30 Oct 2017 17:08:58 +1100
Message-ID: <1509343738-19411-1-git-send-email-me@tobin.cc>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49341 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750931AbdJ3GJI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Oct 2017 02:09:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bruce Chang <brucechang@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, linux-mmc@vger.kernel.org

Currently call to request_irq() contains a line break between the
function call and the assignment variable. This gives false positives
when attempting to audit (grep) kernel code for correct handling of
return value for the function. We can save future developers some time
by removing the line break. This arguably makes the code a little
cleaner also.

Remove line break from between function call and return value
assignment.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/mmc/host/via-sdmmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index a838bf5480d8..9b9a447f26fe 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1144,9 +1144,8 @@ static int via_sd_probe(struct pci_dev *pcidev,
 
 	via_init_mmc_host(sdhost);
 
-	ret =
-	    request_irq(pcidev->irq, via_sdc_isr, IRQF_SHARED, DRV_NAME,
-			sdhost);
+	ret = request_irq(pcidev->irq, via_sdc_isr, IRQF_SHARED,
+			  DRV_NAME, sdhost);
 	if (ret)
 		goto unmap;
 
-- 
2.7.4

