From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv3 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk to
 host's quirk
Date: Thu, 10 Jul 2014 16:08:39 +0900
Message-ID: <1404976119-10777-6-git-send-email-jh80.chung@samsung.com>
References: <1404976119-10777-1-git-send-email-jh80.chung@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1404976119-10777-1-git-send-email-jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Replaced the "disable-wp" into host's quirks.
(Because the slot-node is removed at dt-file.)

Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/mmc/host/dw_mmc.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ac227c..a3ccd07 100644
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
+	},{
+		.quirk	= "disable-wp",
+		.id	= DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
 	},
 };
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
