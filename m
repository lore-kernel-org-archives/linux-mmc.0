From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: dw_mmc: Add more capabilities field
Date: Fri, 09 Dec 2011 14:55:52 +0900
Message-ID: <00a901ccb637$35e66590$a1b330b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch adds another capabilities field for MMC_CAPS2_XXX.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |    6 ++++++
 include/linux/mmc/dw_mmc.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3aaeb08..366df6b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1681,6 +1681,12 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	else
 		mmc->caps = 0;
 
+	if (host->pdata->caps2)
+		mmc->caps2 = host->pdata->caps2;
+	else
+		mmc->caps2 = 0;
+
+
 	if (host->pdata->get_bus_wd)
 		if (host->pdata->get_bus_wd(slot->id) >= 4)
 			mmc->caps |= MMC_CAP_4_BIT_DATA;
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
