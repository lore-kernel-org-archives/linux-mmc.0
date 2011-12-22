From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2] mmc: dw_mmc: Add second capability field
Date: Thu, 22 Dec 2011 18:01:12 +0900
Message-ID: <006801ccc088$40cf1460$c26d3d20$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:40882 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab1LVJBN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2011 04:01:13 -0500
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, 'James Hogan' <james@albanarts.com>

This patch adds caps2 filed for second capability in dw_mmc.
It corresponds with MMC_CAPS2_XXX. And this patch removes the
unnecessary condition statement for assigning caps.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |    6 ++----
 include/linux/mmc/dw_mmc.h |    1 +
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3aaeb08..3f5a77a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1676,10 +1676,8 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->setpower)
 		host->pdata->setpower(id, 0);
 
-	if (host->pdata->caps)
-		mmc->caps = host->pdata->caps;
-	else
-		mmc->caps = 0;
+	mmc->caps |= host->pdata->caps;
+	mmc->caps2 |= host->pdata->caps2;
 
 	if (host->pdata->get_bus_wd)
 		if (host->pdata->get_bus_wd(slot->id) >= 4)
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 6dc9b80..e8779c6 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -214,6 +214,7 @@ struct dw_mci_board {
 	unsigned int bus_hz; /* Bus speed */
 
 	unsigned int caps;	/* Capabilities */
+	unsigned int caps2;	/* More capabilities */
 	/*
 	 * Override fifo depth. If 0, autodetect it from the FIFOTH register,
 	 * but note that this may not be reliable after a bootloader has used
-- 
1.7.0.4


