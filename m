From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 12/14] mmc: sh-mmcif: reset DMA completion immediately before starting DMA
Date: Wed, 12 Dec 2012 15:38:16 +0100
Message-ID: <1355323098-18061-13-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58563 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab2LLOi0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Dec 2012 09:38:26 -0500
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

DMA completion can be signalled from the DMA callback and from the error
handler. If both are called, the completion struct can enter an
inconsistent state. To prevent this move completion initialisation
immediately before activating DMA.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 03493e4..1dd7fc0 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -419,8 +419,6 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
 	if (ret < 0)
 		goto ecfgrx;
 
-	init_completion(&host->dma_complete);
-
 	return;
 
 ecfgrx:
@@ -1061,6 +1059,12 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 	if (!data)
 		return false;
 
+	/*
+	 * Completion can be signalled from DMA callback and error, so, have to
+	 * reset here, before setting .dma_active
+	 */
+	init_completion(&host->dma_complete);
+
 	if (data->flags & MMC_DATA_READ) {
 		if (host->chan_rx)
 			sh_mmcif_start_dma_rx(host);
-- 
1.7.2.5

