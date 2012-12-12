From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 06/14] mmc: sh_mmcif: Avoid unnecessary mmc_delay() at mmc_card_sleepawake()
Date: Wed, 12 Dec 2012 15:38:10 +0100
Message-ID: <1355323098-18061-7-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56316 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333Ab2LLOiZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Dec 2012 09:38:25 -0500
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Teppei Kamijou <teppei.kamijou.yb@renesas.com>, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

From: Teppei Kamijou <teppei.kamijou.yb@renesas.com>

SH/R-Mobile MMCIF host controller can wait while the card signals busy.
Set MMC_CAP_WAIT_WHILE_BUSY to inform an upper layer (core/mmc_ops.c)
not to insert unnecessary mmc_delay().

Signed-off-by: Teppei Kamijou <teppei.kamijou.yb@renesas.com>
Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 1665ae4..092c415 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -758,6 +758,7 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 	}
 	switch (opc) {
 	/* RBSY */
+	case MMC_SLEEP_AWAKE:
 	case MMC_SWITCH:
 	case MMC_STOP_TRANSMISSION:
 	case MMC_SET_WRITE_PROT:
@@ -851,6 +852,7 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 
 	switch (opc) {
 	/* response busy check */
+	case MMC_SLEEP_AWAKE:
 	case MMC_SWITCH:
 	case MMC_STOP_TRANSMISSION:
 	case MMC_SET_WRITE_PROT:
@@ -1357,7 +1359,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	mmc->ops = &sh_mmcif_ops;
 	sh_mmcif_init_ocr(host);
 
-	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
+	mmc->caps = MMC_CAP_MMC_HIGHSPEED | MMC_CAP_WAIT_WHILE_BUSY;
 	if (pd && pd->caps)
 		mmc->caps |= pd->caps;
 	mmc->max_segs = 32;
-- 
1.7.2.5

