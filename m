From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 1/2] mmc: dw_mmc: change definition of get_cd
Date: Thu, 10 Oct 2013 22:36:52 +0800
Message-ID: <1381415813-9395-2-git-send-email-zhangfei.gao@linaro.org>
References: <1381415813-9395-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:54298 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab3JJOjO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Oct 2013 10:39:14 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so2819897pab.36
        for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2013 07:39:13 -0700 (PDT)
In-Reply-To: <1381415813-9395-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Zhangfei Gao <zhangfei.gao@linaro.org>

int (*get_cd)(struct dw_mci *host, u32 slot_id)
Add host info to pass priv, where contains cd pin

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/mmc/host/dw_mmc.c  |    2 +-
 include/linux/mmc/dw_mmc.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 018f365..97ec3d3 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -877,7 +877,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
 		present = 1;
 	else if (brd->get_cd)
-		present = !brd->get_cd(slot->id);
+		present = !brd->get_cd(slot->host, slot->id);
 	else
 		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
 			== 0 ? 1 : 0;
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 198f0fa..5a359dc 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -246,7 +246,7 @@ struct dw_mci_board {
 
 	int (*init)(u32 slot_id, irq_handler_t , void *);
 	int (*get_ro)(u32 slot_id);
-	int (*get_cd)(u32 slot_id);
+	int (*get_cd)(struct dw_mci *host, u32 slot_id);
 	int (*get_ocr)(u32 slot_id);
 	int (*get_bus_wd)(u32 slot_id);
 	/*
-- 
1.7.9.5

