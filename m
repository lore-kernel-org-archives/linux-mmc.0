From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 13/54] mmc: sdhci: Move host->data warning
Date: Wed, 29 Jun 2016 16:24:26 +0300
Message-ID: <1467206707-30185-14-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35817 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932080AbcF2NaI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:30:08 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

In order to support commands during data transfer, it will be possible
that host->data is not NULL when preparing a new request. Move a warning
that assumes otherwise.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3835b20877a5..ee4363b82f8c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -744,14 +744,14 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	u8 ctrl;
 	struct mmc_data *data = cmd->data;
 
-	WARN_ON(host->data);
-
 	if (data || (cmd->flags & MMC_RSP_BUSY))
 		sdhci_set_timeout(host, cmd);
 
 	if (!data)
 		return;
 
+	WARN_ON(host->data);
+
 	/* Sanity checks */
 	BUG_ON(data->blksz * data->blocks > 524288);
 	BUG_ON(data->blksz > host->mmc->max_blk_size);
-- 
1.9.1

