From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH 2/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
Date: Mon, 23 Jun 2014 16:15:20 +0530
Message-ID: <1403520321-2431-3-git-send-email-yuvaraj.cd@samsung.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45736 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaFWKps (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jun 2014 06:45:48 -0400
In-Reply-To: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jh80.chung@samsung.com, cjb@laptop.org, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: sonnyrao@chromium.org, t.figa@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, ks.giri@samsung.com, prashanth.g@samsung.com, alim.akhtar@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

On exynos 5250 and 5420 based boards which uses built-in CD# line
for card detection.But unfortunately CD# line is on the same voltage
rails as of I/O voltage rails.When we cut off vqmmc,the consequent
card detection will break in these boards.

Also if we let alone the vqmmc turned on when vmmc turned off, the
card could have half way powered and this can damage the card.So
this patch adds a check so that, if the board used the built-in
card detection mechanism i.e through CDETECT, it will not turned
down vqmmc and vmmc both.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f5cabce..e034bce 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -932,6 +932,25 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	spin_unlock_bh(&host->lock);
 }
 
+/*
+ * some of the boards use controller CD line for card detection.Unfortunately
+ * CD line is bind to the same volatge domain as of the IO lines.If we turn off
+ * IO voltage domain, CD line wont work.
+ * Return true when controller CD line is used for card detection or return
+ * false.
+ */
+static bool dw_mci_builtin_cd(struct dw_mci_slot *slot)
+{
+	struct dw_mci_board *brd = slot->host->pdata;
+	struct mmc_host *mmc = slot->mmc;
+
+	if ((brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION) &&
+			!IS_ERR_VALUE(mmc_gpio_get_cd(mmc)))
+		return true;
+	else
+		return false;
+}
+
 static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
@@ -988,6 +1007,10 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		mci_writel(slot->host, PWREN, regs);
 		break;
 	case MMC_POWER_OFF:
+		if (dw_mci_builtin_cd(slot) &&
+				!test_bit(DW_MMC_CARD_PRESENT, &slot->flags))
+			return;
+
 		if (!IS_ERR(mmc->supply.vqmmc) &&
 				test_bit(DW_MMC_IO_POWERED, &slot->flags)) {
 			ret = regulator_disable(mmc->supply.vqmmc);
-- 
1.7.10.4

