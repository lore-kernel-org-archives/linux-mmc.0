From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/5] mmc: omap_hsmmc: fix request done for sbc error case
Date: Tue, 21 Jan 2014 19:54:39 +0530
Message-ID: <1390314282-20520-3-git-send-email-balajitk@ti.com>
References: <1390314282-20520-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1390314282-20520-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

mrq is not populated for set block count(cmd23) command.
Use block read/write mmc_commond pointer for request done and
avoid NULL pointer access in error case for sbc (cmd23).

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8d0048d..d3774b8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -893,7 +893,7 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
 		}
 	}
 	if ((host->data == NULL && !host->response_busy) || cmd->error)
-		omap_hsmmc_request_done(host, cmd->mrq);
+		omap_hsmmc_request_done(host, host->mrq);
 }
 
 /*
-- 
1.7.5.4

