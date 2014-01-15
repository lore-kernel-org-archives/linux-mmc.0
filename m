From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Wed, 15 Jan 2014 15:15:59 +0800
Message-ID: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
References: <CAGa+x85awFYsrU9Gggirpaip3vggtSqu5GinVzss=nfNcp4nww@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:65434 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaAOHQv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 02:16:51 -0500
Received: by mail-pa0-f52.google.com with SMTP id kx10so771691pab.11
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 23:16:50 -0800 (PST)
In-Reply-To: <CAGa+x85awFYsrU9Gggirpaip3vggtSqu5GinVzss=nfNcp4nww@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Introdeced from commit b7db86adfa58b
CDETECT is ingored since IS_ERR_VALUE(!mmc_gpio_get_cd(mmc)) does not work
Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reported-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/mmc/host/dw_mmc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a776f24f4311..9ded62c8225e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1033,7 +1033,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	int present;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci_board *brd = slot->host->pdata;
-	int gpio_cd = !mmc_gpio_get_cd(mmc);
+	struct dw_mci *host = slot->host;
+	int gpio_cd = mmc_gpio_get_cd(mmc);
 
 	/* Use platform get_cd function, else try onboard card detect */
 	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
@@ -1041,11 +1042,12 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	else if (brd->get_cd)
 		present = !brd->get_cd(slot->id);
 	else if (!IS_ERR_VALUE(gpio_cd))
-		present = !!gpio_cd;
+		present = !gpio_cd;
 	else
 		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
 			== 0 ? 1 : 0;
 
+	spin_lock_bh(&host->lock);
 	if (present) {
 		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 		dev_dbg(&mmc->class_dev, "card is present\n");
@@ -1053,6 +1055,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 		dev_dbg(&mmc->class_dev, "card is not present\n");
 	}
+	spin_unlock_bh(&host->lock);
 
 	return present;
 }
@@ -2081,7 +2084,7 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
 	return gpio;
 }
 
-/* find the cd gpio for a given slot; or -1 if none specified */
+/* find the cd gpio for a given slot */
 static void dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
 					struct mmc_host *mmc)
 {
-- 
1.7.9.5

