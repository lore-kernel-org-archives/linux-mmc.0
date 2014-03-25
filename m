From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 4/4] Limit max_discard_sectors to UINT_MAX>>9
Date: Tue, 25 Mar 2014 16:48:26 -0700
Message-ID: <1395791307-23727-5-git-send-email-gwendal@chromium.org>
References: <1395791307-23727-1-git-send-email-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1395791307-23727-1-git-send-email-gwendal@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: axboe@kernel.dk, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

max_discard_sectors can not be larger than UINT_MAX>>9,
otherwise, there is a risk that discard requests would be merged
into a request larger than 4GB.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mtd/mtd_blkdevs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 5073cbc..e74090c 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -416,7 +416,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 
 	if (tr->discard) {
 		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, new->rq);
-		new->rq->limits.max_discard_sectors = UINT_MAX;
+		new->rq->limits.max_discard_sectors = UINT_MAX >> 9;
 	}
 
 	gd->queue = new->rq;
-- 
1.9.1.423.g4596e3a


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
