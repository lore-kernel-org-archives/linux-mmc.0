From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk to
 host's quirk
Date: Mon, 30 Jun 2014 20:49:19 +0900
Message-ID: <1404128960-27225-6-git-send-email-jh80.chung@samsung.com>
References: <1404128960-27225-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1404128960-27225-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Replaced the "disable-wp" into host's quirks.
(Because the slot-node is removed at dt-file.)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ac227c..6c5d696 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -994,10 +994,11 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 {
 	int read_only;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci_board *brd = slot->host->pdata;
 	int gpio_ro = mmc_gpio_get_ro(mmc);
 
 	/* Use platform get_ro function, else try on board write protect */
-	if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
+	if (brd->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
 		read_only = 0;
 	else if (!IS_ERR_VALUE(gpio_ro))
 		read_only = gpio_ro;
@@ -2006,12 +2007,7 @@ static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
 static struct dw_mci_of_slot_quirks {
 	char *quirk;
 	int id;
-} of_slot_quirks[] = {
-	{
-		.quirk	= "disable-wp",
-		.id	= DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
-	},
-};
+} of_slot_quirks[] = {};
 
 static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
 {
@@ -2238,6 +2234,9 @@ static struct dw_mci_of_quirks {
 	{
 		.quirk	= "broken-cd",
 		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
+	},{
+		.quirk	= "disable-wp",
+		.id	= DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
 	},
 };
 
-- 
1.7.9.5
