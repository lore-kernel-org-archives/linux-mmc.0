From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 2/4] mmc: dw_mmc: use the __mmc_of_parse to parse the slot
 node
Date: Wed, 28 May 2014 14:35:49 +0900
Message-ID: <1401255351-17653-3-git-send-email-jh80.chung@samsung.com>
References: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, ludovic.desroches@atmel.com, tgih.jun@samsung.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

dw-mmc controller has the multiple slot.
Then it needs to parse the property for each slot.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V3:
	- Fix typo.
	- Maintained the dw_mci_of_quirks().
Changelog V2:
	- None

 drivers/mmc/host/dw_mmc.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ac227c..3285bdd 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1015,12 +1015,11 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 {
 	int present;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci_board *brd = slot->host->pdata;
 	struct dw_mci *host = slot->host;
 	int gpio_cd = mmc_gpio_get_cd(mmc);
 
 	/* Use platform get_cd function, else try onboard card detect */
-	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
+	if (slot->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
 		present = 1;
 	else if (!IS_ERR_VALUE(gpio_cd))
 		present = gpio_cd;
@@ -2010,6 +2009,9 @@ static struct dw_mci_of_slot_quirks {
 	{
 		.quirk	= "disable-wp",
 		.id	= DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
+	}, {
+		.quirk	= "broken-cd",
+		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
 	},
 };
 
@@ -2088,7 +2090,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
 
-	mmc_of_parse(mmc);
+	__mmc_of_parse(mmc, dw_mci_of_find_slot_node(host->dev, slot->id));
 
 	if (host->pdata->blk_settings) {
 		mmc->max_segs = host->pdata->blk_settings->max_segs;
@@ -2234,12 +2236,7 @@ static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host)
 static struct dw_mci_of_quirks {
 	char *quirk;
 	int id;
-} of_quirks[] = {
-	{
-		.quirk	= "broken-cd",
-		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
-	},
-};
+} of_quirks[] = {};
 
 static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 {
-- 
1.7.9.5
