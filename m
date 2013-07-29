From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/9] dma: edma: Write out and handle MAX_NR_SG at a given time
Date: Mon, 29 Jul 2013 08:29:48 -0500
Message-ID: <1375104595-16018-3-git-send-email-joelf@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1375104595-16018-1-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Benoit Cousson <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Gururaja Hebbar <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Process SG-elements in batches of MAX_NR_SG if they are greater
than MAX_NR_SG. Due to this, at any given time only those many
slots will be used in the given channel no matter how long the
scatter list is. We keep track of how much has been written
inorder to process the next batch of elements in the scatter-list
and detect completion.

For such intermediate transfer completions (one batch of MAX_NR_SG),
make use of pause and resume functions instead of start and stop
when such intermediate transfer is in progress or completed as we
donot want to clear any pending events.

Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
---
 drivers/dma/edma.c |   79 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 0b68f94..d9a151b 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -56,6 +56,7 @@ struct edma_desc {
 	struct list_head		node;
 	int				absync;
 	int				pset_nr;
+	int				total_processed;
 	struct edmacc_param		pset[0];
 };
 
@@ -104,22 +105,36 @@ static void edma_desc_free(struct virt_dma_desc *vdesc)
 /* Dispatch a queued descriptor to the controller (caller holds lock) */
 static void edma_execute(struct edma_chan *echan)
 {
-	struct virt_dma_desc *vdesc = vchan_next_desc(&echan->vchan);
+	struct virt_dma_desc *vdesc;
 	struct edma_desc *edesc;
-	int i;
+	struct device *dev = echan->vchan.chan.device->dev;
 
-	if (!vdesc) {
-		echan->edesc = NULL;
-		return;
+	int i, j, total_left, total_process;
+
+	/* If either we processed all psets or we're still not started */
+	if (!echan->edesc ||
+	    echan->edesc->pset_nr == echan->edesc->total_processed) {
+		/* Get next vdesc */
+		vdesc = vchan_next_desc(&echan->vchan);
+		if (!vdesc) {
+			echan->edesc = NULL;
+			return;
+		}
+		list_del(&vdesc->node);
+		echan->edesc = to_edma_desc(&vdesc->tx);
 	}
 
-	list_del(&vdesc->node);
+	edesc = echan->edesc;
+
+	/* Find out how many left */
+	total_left = edesc->pset_nr - edesc->total_processed;
+	total_process = total_left > MAX_NR_SG ? MAX_NR_SG : total_left;
 
-	echan->edesc = edesc = to_edma_desc(&vdesc->tx);
 
 	/* Write descriptor PaRAM set(s) */
-	for (i = 0; i < edesc->pset_nr; i++) {
-		edma_write_slot(echan->slot[i], &edesc->pset[i]);
+	for (i = 0; i < total_process; i++) {
+		j = i + edesc->total_processed;
+		edma_write_slot(echan->slot[i], &edesc->pset[j]);
 		dev_dbg(echan->vchan.chan.device->dev,
 			"\n pset[%d]:\n"
 			"  chnum\t%d\n"
@@ -132,24 +147,31 @@ static void edma_execute(struct edma_chan *echan)
 			"  bidx\t%08x\n"
 			"  cidx\t%08x\n"
 			"  lkrld\t%08x\n",
-			i, echan->ch_num, echan->slot[i],
-			edesc->pset[i].opt,
-			edesc->pset[i].src,
-			edesc->pset[i].dst,
-			edesc->pset[i].a_b_cnt,
-			edesc->pset[i].ccnt,
-			edesc->pset[i].src_dst_bidx,
-			edesc->pset[i].src_dst_cidx,
-			edesc->pset[i].link_bcntrld);
+			j, echan->ch_num, echan->slot[i],
+			edesc->pset[j].opt,
+			edesc->pset[j].src,
+			edesc->pset[j].dst,
+			edesc->pset[j].a_b_cnt,
+			edesc->pset[j].ccnt,
+			edesc->pset[j].src_dst_bidx,
+			edesc->pset[j].src_dst_cidx,
+			edesc->pset[j].link_bcntrld);
 		/* Link to the previous slot if not the last set */
-		if (i != (edesc->pset_nr - 1))
+		if (i != (total_process - 1))
 			edma_link(echan->slot[i], echan->slot[i+1]);
 		/* Final pset links to the dummy pset */
 		else
 			edma_link(echan->slot[i], echan->ecc->dummy_slot);
 	}
 
-	edma_start(echan->ch_num);
+	edesc->total_processed += total_process;
+
+	edma_resume(echan->ch_num);
+
+	if (edesc->total_processed <= MAX_NR_SG) {
+		dev_dbg(dev, "first transfer starting %d\n", echan->ch_num);
+		edma_start(echan->ch_num);
+	}
 }
 
 static int edma_terminate_all(struct edma_chan *echan)
@@ -369,19 +391,26 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
 	struct edma_desc *edesc;
 	unsigned long flags;
 
-	/* Stop the channel */
-	edma_stop(echan->ch_num);
+	/* Pause the channel */
+	edma_pause(echan->ch_num);
 
 	switch (ch_status) {
 	case DMA_COMPLETE:
-		dev_dbg(dev, "transfer complete on channel %d\n", ch_num);
-
 		spin_lock_irqsave(&echan->vchan.lock, flags);
 
 		edesc = echan->edesc;
 		if (edesc) {
+			if (edesc->total_processed == edesc->pset_nr) {
+				dev_dbg(dev, "transfer complete." \
+					" stopping channel %d\n", ch_num);
+				edma_stop(echan->ch_num);
+				vchan_cookie_complete(&edesc->vdesc);
+			} else {
+				dev_dbg(dev, "Intermediate transfer complete" \
+					" on channel %d\n", ch_num);
+			}
+
 			edma_execute(echan);
-			vchan_cookie_complete(&edesc->vdesc);
 		}
 
 		spin_unlock_irqrestore(&echan->vchan.lock, flags);
-- 
1.7.9.5
