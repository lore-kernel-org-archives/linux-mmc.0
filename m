From: "Yuan, Juntao" <juntao.yuan@intel.com>
Subject: [PATCH] mmc: block: Correct response type of stop command for sdcard
Date: Wed, 13 Apr 2016 05:59:21 +0000
Message-ID: <588D8A7789B2934A9950BF189ED6F50A20061122@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:30096 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759306AbcDMF71 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 01:59:27 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "Hunter, Adrian" <adrian.hunter@intel.com>


According to Physical Layer Simplified Specification Version 4.10, SD
card needs a R1b response for stop command.

Signed-off-by: Yuan Juntao <juntao.yuan@intel.com>
---
 drivers/mmc/card/block.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 3bdbe50..aa8fc98b 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1533,9 +1533,14 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
    if (rq_data_dir(req) == READ) {
        brq->cmd.opcode = readcmd;
        brq->data.flags = MMC_DATA_READ;
-       if (brq->mrq.stop)
-           brq->stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
-                   MMC_CMD_AC;
+       if (brq->mrq.stop) {
+           if (mmc_card_mmc(card))
+               brq->stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
+                       MMC_CMD_AC;
+           else
+               brq->stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B |
+                       MMC_CMD_AC;
+       }
    } else {
        brq->cmd.opcode = writecmd;
        brq->data.flags = MMC_DATA_WRITE;
--
1.7.9.5



Thanks.
Juntao.

