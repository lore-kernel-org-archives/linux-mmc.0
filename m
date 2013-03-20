From: <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: atmel-mci: pio hang on block errors
Date: Wed, 20 Mar 2013 10:32:26 +0100
Message-ID: <1363771946-8931-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:50375 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934136Ab3CTJch (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Mar 2013 05:32:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, terry@beam.ltd.uk, ludovic.desroches@atmel.com

From: Terry Barnaby <terry@beam.ltd.uk>

The driver is doing, by default, multi-block reads. When a block error occurs
card/block.c instigates a single block read: "mmcblk0: retrying using single
block read".
It leaves the sg chain intact and just changes the length attribute for the
first sg entry and the overall sg_len parameter. When atmci_read_data_pio is
called to read the single block of data it ignores the sg_len and expects to
read more than 512 bytes as it sees there are multiple items in the sg list. No
more data comes as the controller has only been commanded to get one block.

Signed-off-by: Terry Barnaby <terry@beam.ltd.uk>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: stable <stable@vger.kernel.org> # 3.2+
---
 drivers/mmc/host/atmel-mci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 0932024..d98e68e 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -163,6 +163,7 @@ struct atmel_mci {
 	void __iomem		*regs;
 
 	struct scatterlist	*sg;
+	unsigned int		sg_len;
 	unsigned int		pio_offset;
 
 	struct atmel_mci_slot	*cur_slot;
@@ -751,6 +752,7 @@ static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
 	data->error = -EINPROGRESS;
 
 	host->sg = data->sg;
+	host->sg_len = data->sg_len;
 	host->data = data;
 	host->data_chan = NULL;
 
@@ -1573,7 +1575,8 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 			if (offset == sg->length) {
 				flush_dcache_page(sg_page(sg));
 				host->sg = sg = sg_next(sg);
-				if (!sg)
+				host->sg_len--;
+				if (!sg || !host->sg_len)
 					goto done;
 
 				offset = 0;
@@ -1586,7 +1589,8 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 
 			flush_dcache_page(sg_page(sg));
 			host->sg = sg = sg_next(sg);
-			if (!sg)
+			host->sg_len--;
+			if (!sg || !host->sg_len)
 				goto done;
 
 			offset = 4 - remaining;
@@ -1640,7 +1644,8 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 			nbytes += 4;
 			if (offset == sg->length) {
 				host->sg = sg = sg_next(sg);
-				if (!sg)
+				host->sg_len--;
+				if (!sg || !host->sg_len)
 					goto done;
 
 				offset = 0;
@@ -1654,7 +1659,8 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 			nbytes += remaining;
 
 			host->sg = sg = sg_next(sg);
-			if (!sg) {
+			host->sg_len--;
+			if (!sg || !host->sg_len) {
 				atmci_writel(host, ATMCI_TDR, value);
 				goto done;
 			}
-- 
1.7.11.3

