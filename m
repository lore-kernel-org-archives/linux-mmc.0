From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv5 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk to
 host's quirk
Date: Fri, 11 Jul 2014 12:49:47 +0900
Message-ID: <1405050587-5577-6-git-send-email-jh80.chung@samsung.com>
References: <1405050587-5577-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1405050587-5577-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Replaced the "disable-wp" into host's quirks.
(Because the slot-node is removed at dt-file.)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ac227c..aa29dc4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -997,7 +997,7 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 	int gpio_ro = mmc_gpio_get_ro(mmc);
 
 	/* Use platform get_ro function, else try on board write protect */
-	if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
+	if (slot->host->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
 		read_only = 0;
 	else if (!IS_ERR_VALUE(gpio_ro))
 		read_only = gpio_ro;
@@ -2006,12 +2006,7 @@ static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
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
@@ -2238,6 +2233,9 @@ static struct dw_mci_of_quirks {
 	{
 		.quirk	= "broken-cd",
 		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
+	}, {
+		.quirk	= "disable-wp",
+		.id	= DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
 	},
 };
 
-- 
1.7.9.5
