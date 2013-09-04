From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v3] mmc: add ignorance case for CMD13 CRC error
Date: Wed, 04 Sep 2013 21:21:05 +0900
Message-ID: <002b01cea969$3ab56630$b0203290$%jun@samsung.com>
References: <002301ce9e6b$e72da2a0$b588e7e0$%jun@samsung.com>
 <CAPDyKFrGxbo46_uhJrWc-u0k1kJxXxeKePdoou3aFpwSBUY21g@mail.gmail.com>
 <002901cea22c$af778730$0e669590$%jun@samsung.com>
 <CAPDyKForsH3rsLevSiCfm4nkYHV_FvFVH=YhSsvb=bqLgCtBwA@mail.gmail.com>
 <001d01cea911$8a509c80$9ef1d580$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:29768 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757142Ab3IDMVI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2013 08:21:08 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSL00B6SOZ4F970@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 04 Sep 2013 21:21:06 +0900 (KST)
In-reply-to: <001d01cea911$8a509c80$9ef1d580$%jun@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Ulf Hansson' <ulf.hansson@linaro.org>

While speed mode is changed, CMD13 cannot be guaranteed.
According to the spec., it is not recommended to use CMD13
to check the busy completion of the timing change.
If CMD13 is used in this case, CRC error must be ignored.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
Change in v3:
 - Adjusted condition with MMC_CAP_WAIT_WHILE_BUSY.(From Ulf Hansson) 

Change in v2:
 - Removed function declaration.(From Ulf Hansson)

 drivers/mmc/core/mmc_ops.c |   73 +++++++++++++++++++++++++++-----------------
 1 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index ef18348..37f7d70 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -23,6 +23,40 @@
 
 #define MMC_OPS_TIMEOUT_MS	(10 * 60 * 1000) /* 10 minute timeout */
 
+static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
+				    bool ignore_crc)
+{
+	int err;
+	struct mmc_command cmd = {0};
+
+	BUG_ON(!card);
+	BUG_ON(!card->host);
+
+	cmd.opcode = MMC_SEND_STATUS;
+	if (!mmc_host_is_spi(card->host))
+		cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
+	if (ignore_crc)
+		cmd.flags &= ~MMC_RSP_CRC;
+
+	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
+	if (err)
+		return err;
+
+	/* NOTE: callers are required to understand the difference
+	 * between "native" and SPI format status words!
+	 */
+	if (status)
+		*status = cmd.resp[0];
+
+	return 0;
+}
+
+int mmc_send_status(struct mmc_card *card, u32 *status)
+{
+	return __mmc_send_status(card, status, false);
+}
+
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 {
 	int err;
@@ -380,6 +414,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	struct mmc_command cmd = {0};
 	unsigned long timeout;
 	u32 status;
+	bool ignore_crc = false;
 
 	BUG_ON(!card);
 	BUG_ON(!card->host);
@@ -408,10 +443,18 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (!use_busy_signal)
 		return 0;
 
-	/* Must check status to be sure of no errors */
+	/*
+	 * Must check status to be sure of no errors
+	 * If CMD13 is to check the busy completion of the timing change,
+	 * disable the check of CRC error.
+	 */
+	if (index == EXT_CSD_HS_TIMING &&
+	    !(card->host->caps & MMC_CAP_WAIT_WHILE_BUSY))
+		ignore_crc = true;
+
 	timeout = jiffies + msecs_to_jiffies(MMC_OPS_TIMEOUT_MS);
 	do {
-		err = mmc_send_status(card, &status);
+		err = __mmc_send_status(card, &status, ignore_crc);
 		if (err)
 			return err;
 		if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
@@ -449,32 +492,6 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
-int mmc_send_status(struct mmc_card *card, u32 *status)
-{
-	int err;
-	struct mmc_command cmd = {0};
-
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-
-	cmd.opcode = MMC_SEND_STATUS;
-	if (!mmc_host_is_spi(card->host))
-		cmd.arg = card->rca << 16;
-	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
-
-	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
-	if (err)
-		return err;
-
-	/* NOTE: callers are required to understand the difference
-	 * between "native" and SPI format status words!
-	 */
-	if (status)
-		*status = cmd.resp[0];
-
-	return 0;
-}
-
 static int
 mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 		  u8 len)
-- 
1.7.0.4


