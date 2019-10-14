From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
Date: Tue, 15 Oct 2019 00:08:49 +0530
Message-ID: <20191014183849.14864-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, asutoshd@codeaurora.org, riteshh@codeaurora.org, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Add a write memory barrier to make sure that descriptors are actually
written to memory before ringing the doorbell.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---

This patch fixes a very infrequent ADMA error (1 out of 100 times) that
I have been seeing after enabling command queuing for J721e.
Also looking at memory-barriers.txt and this commit[1],
it looks like we should be doing this before any descriptor write
followed by a doorbell ring operation. It'll be nice if someone with more
expertise in memory barriers can comment.

[1] ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the
    doorbell")

 drivers/mmc/host/cqhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index f7bdae5354c3..5047f7343ffc 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -611,7 +611,8 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	cq_host->slot[tag].flags = 0;
 
 	cq_host->qcnt += 1;
-
+	/* Make sure descriptors are ready before ringing the doorbell */
+	wmb();
 	cqhci_writel(cq_host, 1 << tag, CQHCI_TDBR);
 	if (!(cqhci_readl(cq_host, CQHCI_TDBR) & (1 << tag)))
 		pr_debug("%s: cqhci: doorbell not set for tag %d\n",
-- 
2.19.2
