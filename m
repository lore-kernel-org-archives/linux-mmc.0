From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv8 5/5] mmc: dw_mmc: replace "disable-wp" from slot's quirk to
 host's quirk
Date: Wed, 30 Jul 2014 20:05:10 +0900
Message-ID: <1406718310-32078-6-git-send-email-jh80.chung@samsung.com>
References: <1406718310-32078-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16217 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbaG3LFT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jul 2014 07:05:19 -0400
In-reply-to: <1406718310-32078-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Doug Anderson <dianders@google.com>, cpgs@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Replaced the "disable-wp" into host's quirks.
(Because the slot-node is removed at dt-file.)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |    8 +++++++-
 include/linux/mmc/dw_mmc.h |    2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ac227c..8d9edc6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -997,7 +997,10 @@ static int dw_mci_get_ro(struct mmc_host *mmc)
 	int gpio_ro = mmc_gpio_get_ro(mmc);
 
 	/* Use platform get_ro function, else try on board write protect */
-	if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT)
+	if (slot->quirks & DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT) {
+		dev_warn(slot->host->dev, "Recommend not to use 'disable-wp'"
+				"into slot-node. Change your dt-file!!");
+	} else if (slot->host->quirks & DW_MCI_QUIRK_NO_WRITE_PROTECT)
 		read_only = 0;
 	else if (!IS_ERR_VALUE(gpio_ro))
 		read_only = gpio_ro;
@@ -2238,6 +2241,9 @@ static struct dw_mci_of_quirks {
 	{
 		.quirk	= "broken-cd",
 		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
+	}, {
+		.quirk	= "disable-wp",
+		.id	= DW_MCI_QUIRK_NO_WRITE_PROTECT,
 	},
 };
 
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index babaea9..29ce014 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -213,6 +213,8 @@ struct dw_mci_dma_ops {
 #define DW_MCI_QUIRK_HIGHSPEED			BIT(2)
 /* Unreliable card detection */
 #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION	BIT(3)
+/* No write protect */
+#define DW_MCI_QUIRK_NO_WRITE_PROTECT		BIT(4)
 
 /* Slot level quirks */
 /* This slot has no write protect */
-- 
1.7.9.5

