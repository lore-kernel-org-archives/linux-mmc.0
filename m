From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] MMC: add workaround for controllers with broken
 multiblock reads
Date: Thu, 06 Oct 2011 14:50:33 -0600
Message-ID: <20111006205030.7083.79614.stgit@dusk>
References: <20111006205002.7083.94088.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20111006205002.7083.94088.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dave Hylands <dhylands@gmail.com>, Steve Sakoman <sakoman@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Due to hardware bugs, some MMC host controllers don't support
multiple-block reads[1].  To resolve, add a new MMC capability flag,
MMC_CAP_NO_MULTI_READ, which can be set by affected host controller
drivers.  When this capability is set, all reads will be issued one
sector at a time.

1. See for example Advisory 2.1.1.128 "MMC: Multiple Block Read
Operation Issue" in _OMAP3530/3525/3515/3503 Silicon Errata_
Revision F (October 2010) (SPRZ278F), available from
http://focus.ti.com/lit/er/sprz278f/sprz278f.pdf

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Dave Hylands <dhylands@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/card/block.c |   21 ++++++++++++++-------
 include/linux/mmc/host.h |    1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1ff5486..927f9d5 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -954,13 +954,20 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	if (brq->data.blocks > card->host->max_blk_count)
 		brq->data.blocks = card->host->max_blk_count;
 
-	/*
-	 * After a read error, we redo the request one sector at a time
-	 * in order to accurately determine which sectors can be read
-	 * successfully.
-	 */
-	if (disable_multi && brq->data.blocks > 1)
-		brq->data.blocks = 1;
+	if (brq->data.blocks > 1) {
+		/*
+		 * After a read error, we redo the request one sector
+		 * at a time in order to accurately determine which
+		 * sectors can be read successfully.
+		 */
+		if (disable_multi)
+			brq->data.blocks = 1;
+
+		/* Some controllers can't do multiblock reads due to hw bugs */
+		if (card->host->caps & MMC_CAP_NO_MULTI_READ &&
+		    rq_data_dir(req) == READ)
+			brq->data.blocks = 1;
+	}
 
 	if (brq->data.blocks > 1 || do_rel_wr) {
 		/* SPI multiblock writes terminate using a special
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1d09562..745f506 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -229,6 +229,7 @@ struct mmc_host {
 #define MMC_CAP_MAX_CURRENT_600	(1 << 28)	/* Host max current limit is 600mA */
 #define MMC_CAP_MAX_CURRENT_800	(1 << 29)	/* Host max current limit is 800mA */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
+#define MMC_CAP_NO_MULTI_READ	(1 << 31)	/* Multiblock reads don't work */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 


