From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 1/2] mmc: block: make the card_busy_detect() more generic
Date: Thu, 5 Sep 2019 15:53:17 +0800
Message-ID: <20190905075318.15554-2-chaotian.jing@mediatek.com>
References: <20190905075318.15554-1-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905075318.15554-1-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>, Chaotian Jing <chaotian.jing@mediatek.com>, Avri Altman <avri.altman@wdc.com>, YueHaibing <yuehaibing@huawei.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>, Zachary Hays <zhays@lexmark.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

to use the card_busy_detect() to wait card levae the programming state,
there may be do not have the "struct request *" argument.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/block.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c71a434c915..aa7c19f7e298 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -981,7 +981,7 @@ static inline bool mmc_blk_in_tran_state(u32 status)
 }
 
 static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
-			    struct request *req, u32 *resp_errs)
+			    u32 *resp_errs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 	int err = 0;
@@ -992,8 +992,8 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 
 		err = __mmc_send_status(card, &status, 5);
 		if (err) {
-			pr_err("%s: error %d requesting status\n",
-			       req->rq_disk->disk_name, err);
+			dev_err(mmc_dev(card->host),
+				"error %d requesting status\n", err);
 			return err;
 		}
 
@@ -1006,9 +1006,9 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 		 * leaves the program state.
 		 */
 		if (done) {
-			pr_err("%s: Card stuck in wrong state! %s %s status: %#x\n",
-				mmc_hostname(card->host),
-				req->rq_disk->disk_name, __func__, status);
+			dev_err(mmc_dev(card->host),
+				"Card stuck in wrong state! %s status: %#x\n",
+				 __func__, status);
 			return -ETIMEDOUT;
 		}
 
@@ -1671,7 +1671,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 
 	mmc_blk_send_stop(card, timeout);
 
-	err = card_busy_detect(card, timeout, req, NULL);
+	err = card_busy_detect(card, timeout, NULL);
 
 	mmc_retune_release(card->host);
 
@@ -1895,7 +1895,7 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
 	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
 		return 0;
 
-	err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, req, &status);
+	err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, &status);
 
 	/*
 	 * Do not assume data transferred correctly if there are any error bits
-- 
2.18.0
