From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/3] mmc: host: omap_hsmmc: Fix DTO and DCRC handling
Date: Tue, 16 Jun 2015 16:07:17 +0530
Message-ID: <1434451039-18195-2-git-send-email-vigneshr@ti.com>
References: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, NeilBrown <neilb@suse.de>, Vignesh R <vigneshr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

DTO/DCRC errors were not being informed to the mmc core since
commit ae4bf788ee9b ("mmc: omap_hsmmc: consolidate error report handling of
HSMMC IRQ"). This commit made sure 'end_trans' is never set on DTO/DCRC
errors. This is because after this commit 'host->data' is checked after
it has been cleared to NULL by omap_hsmmc_dma_cleanup().

Because 'end_trans' is never set, omap_hsmmc_xfer_done() is never invoked
making core layer not to be aware of DTO/DCRC errors. Because of this
any command invoked after DTO/DCRC error leads to a hang.

Fix this by checking for 'host->data' before it is actually cleared.

Fixes: ae4bf788ee9b ("mmc: omap_hsmmc: consolidate error report handling of
HSMMC IRQ")

CC: stable@vger.kernel.org
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9df2b6801f76..d0abdffb0d7c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1062,6 +1062,10 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 
 		if (status & (CTO_EN | CCRC_EN))
 			end_cmd = 1;
+		if (host->data || host->response_busy) {
+			end_trans = !end_cmd;
+			host->response_busy = 0;
+		}
 		if (status & (CTO_EN | DTO_EN))
 			hsmmc_command_incomplete(host, -ETIMEDOUT, end_cmd);
 		else if (status & (CCRC_EN | DCRC_EN))
@@ -1081,10 +1085,6 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 			}
 			dev_dbg(mmc_dev(host->mmc), "AC12 err: 0x%x\n", ac12);
 		}
-		if (host->data || host->response_busy) {
-			end_trans = !end_cmd;
-			host->response_busy = 0;
-		}
 	}
 
 	OMAP_HSMMC_WRITE(host->base, STAT, status);
-- 
2.4.1

