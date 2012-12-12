From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 01/14] mmc: sh_mmcif: force to fail CMD52 immediately
Date: Wed, 12 Dec 2012 15:38:05 +0100
Message-ID: <1355323098-18061-2-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Teppei Kamijou <teppei.kamijou.yb@renesas.com>, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
List-Id: linux-mmc@vger.kernel.org

From: Teppei Kamijou <teppei.kamijou.yb@renesas.com>

mmc_rescan() sends CMD52 (SD_IO_RW_DIRECT) to reset SDIO card during
card detection. CMD52 should be ignored by SD/eMMC cards, but we can
also abort it in the driver immediately, since MMCIF doesn't support
SDIO cards anyway.

Signed-off-by: Teppei Kamijou <teppei.kamijou.yb@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 9a4c151..543f6ce 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -911,6 +911,7 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		if ((mrq->cmd->flags & MMC_CMD_MASK) != MMC_CMD_BCR)
 			break;
 	case MMC_APP_CMD:
+	case SD_IO_RW_DIRECT:
 		host->state = STATE_IDLE;
 		mrq->cmd->error = -ETIMEDOUT;
 		mmc_request_done(mmc, mrq);
-- 
1.7.2.5

