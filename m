From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 3/3] mmc: omap_hsmmc: update error code for response_busy cmd
Date: Fri, 9 Nov 2012 21:36:16 +0530
Message-ID: <1352477176-6673-4-git-send-email-balajitk@ti.com>
References: <20121109145218.GA10873@arwen.pp.htv.fi>
 <1352477176-6673-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1352477176-6673-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, svenkatr@ti.com, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

update error code to cmd->error for commands with response_busy and no data

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d931e08..1503808 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -980,8 +980,8 @@ static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
 	if (host->data) {
 		omap_hsmmc_reset_controller_fsm(host, SRD);
 		omap_hsmmc_dma_cleanup(host, err);
-	}
-
+	} else if (host->mrq && host->mrq->cmd)
+		host->mrq->cmd->error = err;
 }
 
 static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
-- 
1.7.5.4

