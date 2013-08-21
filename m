From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 2/3] mmc: core: add ignorance case for CMD13 CRC error
Date: Wed, 21 Aug 2013 21:42:31 +0900
Message-ID: <002301ce9e6b$e72da2a0$b588e7e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32382 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3HUMme (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 08:42:34 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRV003H2SMEHRQ0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Aug 2013 21:42:32 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>

While speed mode is changed, CMD13 cannot be guaranteed.
According to the spec., it is not recommended to use CMD13
to check the busy completion of the timing change.
If CMD13 is used in this case, CRC error must be ignored.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/mmc_ops.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 837fc73..f5dfa9c 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -23,6 +23,9 @@
 
 #define MMC_OPS_TIMEOUT_MS	(10 * 60 * 1000) /* 10 minute timeout */
 
+static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
+				    bool ignore_crc);
+
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 {
 	int err;
@@ -380,6 +383,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	struct mmc_command cmd = {0};
 	unsigned long timeout;
 	u32 status;
+	bool ignore_crc;
 
 	BUG_ON(!card);
 	BUG_ON(!card->host);
@@ -408,10 +412,15 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (!use_busy_signal)
 		return 0;
 
-	/* Must check status to be sure of no errors */
+	/*
+	 * Must check status to be sure of no errors
+	 * If CMD13 is to check the busy completion of the timing change,
+	 * disable the check of CRC error.
+	 */
+	ignore_crc = (index == EXT_CSD_HS_TIMING) ? true : false;
 	timeout = jiffies + msecs_to_jiffies(MMC_OPS_TIMEOUT_MS);
 	do {
-		err = mmc_send_status(card, &status);
+		err = __mmc_send_status(card, &status, ignore_crc);
 		if (err)
 			return err;
 		if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
@@ -449,7 +458,8 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 }
 EXPORT_SYMBOL_GPL(mmc_switch);
 
-int mmc_send_status(struct mmc_card *card, u32 *status)
+static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
+				    bool ignore_crc)
 {
 	int err;
 	struct mmc_command cmd = {0};
@@ -461,6 +471,8 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
 	if (!mmc_host_is_spi(card->host))
 		cmd.arg = card->rca << 16;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
+	if (ignore_crc)
+		cmd.flags &= ~MMC_RSP_CRC;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err)
@@ -475,6 +487,11 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
 	return 0;
 }
 
+int mmc_send_status(struct mmc_card *card, u32 *status)
+{
+	return __mmc_send_status(card, status, false);
+}
+
 static int
 mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 		  u8 len)
-- 
1.7.0.4


