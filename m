From: <andreas.koop@zf.com>
Subject: [PATCH 1/1] mmc: mmc_spi: Enable stable writes
Date: Wed, 23 Oct 2013 13:29:15 +0000
Message-ID: <4D4D24CE952D2A4684FC7FAAEF13D7164BE076@DLNV00136.emea.zf-world.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx03.zf.com ([149.238.2.133]:62484 "EHLO mx01.zf.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751275Ab3JWNoU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Oct 2013 09:44:20 -0400
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

While using the mmc_spi driver occasionally errors like this popped up:

mmcblk0: error -84 transferring data
end_request: I/O error, dev mmcblk0, sector 581756

I looked on the Internet for occurences of the same problem and came across a helpful post [1]. It includes source code to reproduce the bug. There is also an analysis about the cause. During transmission data in the supplied buffer is beeing modified. Thus the previously calculated check sum is not correct anymore.

After some digging I found out that device drivers are supposed to report they need stable writes.  To fix this I set the appropriate flag at queue initialization if CRC checksumming is enabled for that SPI host.

[1]
https://groups.google.com/forum/#!msg/sim1/gLlzWeXGFr8/KevXinUXfc8J

Signed-off-by: Andreas Koop <andreas.koop <at> zf.com>
---
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index fa9632e..3fdef37 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -207,6 +207,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	mq->mqrq_prev = mqrq_prev;
 	mq->queue->queuedata = mq;
 
+	if (mmc_host_is_spi(host) && host->use_spi_crc)
+		mq->queue->backing_dev_info.capabilities |= BDI_CAP_STABLE_WRITES;
+
 	blk_queue_prep_rq(mq->queue, mmc_prep_request);
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
 	if (mmc_can_erase(card))
--
