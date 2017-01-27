From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: core/mmci: restore pre/post_req behaviour
Date: Fri, 27 Jan 2017 15:04:54 +0100
Message-ID: <20170127140454.7990-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

commit 64b12a68a9f74bb32d8efd7af1ad8a2ba02fc884
"mmc: core: fix prepared requests while doing bkops"
is fixing a bug in the wrong way. A bug in the MMCI
device driver is fixed by amending the MMC core.

Thinking about it: what the pre- and post-callbacks
are doing is to essentially map and unmap SG lists
for DMA transfers. Why would we not be able to do that
just because a BKOPS command is sent inbetween?
Having to unprepare/prepare the next asynchronous
request for DMA seems wrong.

Looking the backtrace in that commit we can see what
the real problem actually is:

mmci_data_irq() is calling mmci_dma_unmap() twice
which is goung to call arm_dma_unmap_sg() twice
and v7_dma_inv_range() twice for the same sglist
and that will crash.

This happens because a request is prepared, then
a BKOPS is sent. The IRQ completing the BKOPS command
goes through mmci_data_irq() and thinks that a DMA
operation has just been completed because
dma_inprogress() reports true. It then proceeds to
unmap the sglist.

But that was wrong! dma_inprogress() should NOT be
true because no DMA was actually in progress! We had
just prepared the sglist, and the DMA channel
dma_current has been configured, but NOT started!

Because of this, the sglist is already unmapped when
we get our actual data completion IRQ, and we are
unmapping the sglist once more, and we get this crash.

Therefore, we need to revert this solution pushing
the problem to the core and causing problems, and
instead augment the implementation such that
dma_inprogress() only reports true if some DMA has
actually been started.

After this we can keep the request prepared during the
BKOPS and we need not unprepare/reprepare it.

Fixes: 64b12a68a9f7 ("mmc: core: fix prepared requests while doing bkops")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This was found when trying to refactor the stack to complete
requests from the mmc_request_done() call: pretty tricky to
do this when you don't have the previous and next-to-run
asynchronous request available. Luckily I think it is just
a bug fix done the wrong way.

I will build further patches on this one.
---
 drivers/mmc/core/core.c | 9 ---------
 drivers/mmc/host/mmci.c | 7 ++++++-
 drivers/mmc/host/mmci.h | 3 ++-
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ed1768cf464a..a160c3a7777a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -676,16 +676,7 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 		    ((mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1) ||
 		     (mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1B)) &&
 		    (host->areq->mrq->cmd->resp[0] & R1_EXCEPTION_EVENT)) {
-
-			/* Cancel the prepared request */
-			if (areq)
-				mmc_post_req(host, areq->mrq, -EINVAL);
-
 			mmc_start_bkops(host->card, true);
-
-			/* prepare the request again */
-			if (areq)
-				mmc_pre_req(host, areq->mrq);
 		}
 	}
 
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 01a804792f30..bc5fd04acd0f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -507,6 +507,7 @@ static void mmci_dma_data_error(struct mmci_host *host)
 {
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
 	dmaengine_terminate_all(host->dma_current);
+	host->dma_in_progress = false;
 	host->dma_current = NULL;
 	host->dma_desc_current = NULL;
 	host->data->host_cookie = 0;
@@ -565,6 +566,7 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
 		mmci_dma_release(host);
 	}
 
+	host->dma_in_progress = false;
 	host->dma_current = NULL;
 	host->dma_desc_current = NULL;
 }
@@ -665,6 +667,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	dev_vdbg(mmc_dev(host->mmc),
 		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
 		 data->sg_len, data->blksz, data->blocks, data->flags);
+	host->dma_in_progress = true;
 	dmaengine_submit(host->dma_desc_current);
 	dma_async_issue_pending(host->dma_current);
 
@@ -740,8 +743,10 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 		if (host->dma_desc_current == next->dma_desc)
 			host->dma_desc_current = NULL;
 
-		if (host->dma_current == next->dma_chan)
+		if (host->dma_current == next->dma_chan) {
+			host->dma_in_progress = false;
 			host->dma_current = NULL;
+		}
 
 		next->dma_desc = NULL;
 		next->dma_chan = NULL;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 56322c6afba4..4a8bef1aac8f 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -245,8 +245,9 @@ struct mmci_host {
 	struct dma_chan		*dma_tx_channel;
 	struct dma_async_tx_descriptor	*dma_desc_current;
 	struct mmci_host_next	next_data;
+	bool			dma_in_progress;
 
-#define dma_inprogress(host)	((host)->dma_current)
+#define dma_inprogress(host)	((host)->dma_in_progress)
 #else
 #define dma_inprogress(host)	(0)
 #endif
-- 
2.9.3
