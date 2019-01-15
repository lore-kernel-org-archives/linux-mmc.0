From: Alamy Liu <alamy.liu@gmail.com>
Subject: [PATCH] mmc: cqhci: data size depending on queue depth
Date: Tue, 15 Jan 2019 11:13:50 -0800
Message-ID: <20190115191356.32714-1-alamy.liu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

CQE_DCMD is not necessary to be enabled when CQE is enabled.
(Software could halt CQE to send command, or via DCMD)

In the case that CQE_DCMD is not enabled, it still needs to allocate
space for data transfer. For instance:
  CQE_DCMD is enabled:  32 slots space
  CQE_DCMD is disabled: 31 slots space (is good enough)

Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
---
 drivers/mmc/host/cqhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 4cc7863c13..974997b6cb 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -202,7 +202,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
 	cq_host->desc_size = cq_host->slot_sz * cq_host->num_slots;
 
 	cq_host->data_size = cq_host->trans_desc_len * cq_host->mmc->max_segs *
-		(cq_host->num_slots - 1);
+		cq_host->mmc->cqe_qdepth;
 
 	pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
 		 mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,
-- 
2.17.1
