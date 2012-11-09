From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 2/3] mmc: omap_hsmmc: no reset of cmd state machine for DCRC
Date: Fri, 9 Nov 2012 21:36:15 +0530
Message-ID: <1352477176-6673-3-git-send-email-balajitk@ti.com>
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

Avoid soft reset of command internal state machine on data errors.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 245d7b5..d931e08 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -971,8 +971,8 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 static void hsmmc_command_incomplete(struct omap_hsmmc_host *host,
 					int err, int end_cmd)
 {
-	omap_hsmmc_reset_controller_fsm(host, SRC);
 	if (end_cmd) {
+		omap_hsmmc_reset_controller_fsm(host, SRC);
 		if (host->cmd)
 			host->cmd->error = err;
 	}
-- 
1.7.5.4

