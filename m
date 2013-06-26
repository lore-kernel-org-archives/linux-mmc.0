From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: vub300: Staticize vub300_init_card
Date: Wed, 26 Jun 2013 12:02:30 +0530
Message-ID: <1372228350-6375-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:48742 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab3FZGrg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Jun 2013 02:47:36 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so13839805pad.30
        for <linux-mmc@vger.kernel.org>; Tue, 25 Jun 2013 23:47:35 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, tony.olech@elandigitalsystems.com, sachin.kamat@linaro.org

'vub300_init_card' is used only in this file. Make it
static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/vub300.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index cb9f361..e9028ad 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2079,7 +2079,7 @@ static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	kref_put(&vub300->kref, vub300_delete);
 }
 
-void vub300_init_card(struct mmc_host *mmc, struct mmc_card *card)
+static void vub300_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {				/* NOT irq */
 	struct vub300_mmc_host *vub300 = mmc_priv(mmc);
 	dev_info(&vub300->udev->dev, "NO host QUIRKS for this card\n");
-- 
1.7.9.5

