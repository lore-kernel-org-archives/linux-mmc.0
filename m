From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] mmc: tmio, renesas_sdhi: Remove unneeded NULL check
Date: Tue, 9 Jan 2018 12:39:10 +0300
Message-ID: <20180109093910.sbwgcqilgyfhjfns@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The inconsistent NULL checking in this function causes static checker
warnings.

    drivers/mmc/host/renesas_sdhi_sys_dmac.c:360 renesas_sdhi_sys_dmac_issue_tasklet_fn()
    error: we previously assumed 'host' could be null (see line 351)

On reviewing this code, "host" can't ever be NULL so we can just remove
the check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index c8a74b2dee00..82d757c480b2 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -348,7 +348,7 @@ static void renesas_sdhi_sys_dmac_issue_tasklet_fn(unsigned long priv)
 
 	spin_lock_irq(&host->lock);
 
-	if (host && host->data) {
+	if (host->data) {
 		if (host->data->flags & MMC_DATA_READ)
 			chan = host->chan_rx;
 		else
