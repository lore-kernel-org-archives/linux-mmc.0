From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2] mmc: dw_mmc: fix dw_mci_get_cd
Date: Thu, 16 Jan 2014 10:31:42 +0800
Message-ID: <1389839502-13046-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:43185 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbaAPCeF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 21:34:05 -0500
Received: by mail-pd0-f170.google.com with SMTP id z10so1948637pdj.15
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 18:34:05 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@linaro.org>, Sachin Kamat <sachin.kamat@linaro.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Introduced from commit bf626e5550f24aec24975a0e85ad8e572ca76a6b
CDETECT is ignored since negated return value of mmc_gpio_get_cd(mmc)
can not be checked by IS_ERR_VALUE.
Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT,
otherwise sd detect may occasionally fail.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reported-by: Kevin Hilman <khilman@linaro.org>
Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |    2 ++
 drivers/mmc/host/dw_mmc.c                          |   12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 8f3f13315358..18b0819bafe0 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -73,6 +73,8 @@ Optional properties:
 
 * caps2-mmc-hs200-1_2v: Supports mmc HS200 SDR 1.2V mode
 
+* caps2-mmc-cd-active-high: cd pin is high when card present
+
 * broken-cd: as documented in mmc core bindings.
 
 * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a776f24f4311..ad65b895d34c 100644
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
+		present = gpio_cd;
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
@@ -2411,6 +2414,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (of_find_property(np, "caps2-mmc-hs200-1_2v", NULL))
 		pdata->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
 
+	if (of_find_property(np, "caps2-mmc-cd-active-high", NULL))
+		pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+
 	return pdata;
 }
 
-- 
1.7.9.5

