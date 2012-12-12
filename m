From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 09/14] mmc: sh-mmcif: (cosmetic) simplify boolean return blocks
Date: Wed, 12 Dec 2012 15:38:13 +0100
Message-ID: <1355323098-18061-10-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58916 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab2LLOi0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Dec 2012 09:38:26 -0500
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

Use "return condition" instead of "if (condition) return true; return false"
in functions, returning bool.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index d8d65c0..1a7c602 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -542,10 +542,7 @@ static bool sh_mmcif_next_block(struct sh_mmcif_host *host, u32 *p)
 		host->pio_ptr = p;
 	}
 
-	if (host->sg_idx == data->sg_len)
-		return false;
-
-	return true;
+	return host->sg_idx != data->sg_len;
 }
 
 static void sh_mmcif_single_read(struct sh_mmcif_host *host,
@@ -1071,9 +1068,7 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 
 	if (!host->dma_active) {
 		data->error = sh_mmcif_data_trans(host, host->mrq, cmd->opcode);
-		if (!data->error)
-			return true;
-		return false;
+		return !data->error;
 	}
 
 	/* Running in the IRQ thread, can sleep */
-- 
1.7.2.5

