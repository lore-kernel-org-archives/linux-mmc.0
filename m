From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/4] mmc: sh_mmcif: process error interrupts first
Date: Wed, 14 Dec 2011 19:31:51 +0100
Message-ID: <1323887514-12650-2-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56409 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757724Ab1LNScH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 13:32:07 -0500
In-Reply-To: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

If an interrupt is coming with both error and data completion status bits
set, it has to be handled as an error interrupt, for which error interrupts
have to be processed first. The current version of the driver on the
contrary doesn't recognise such interrupts as an error event, which leads
to data corruption and breaks the error recovery.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 824fee5..63559d6 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -948,7 +948,12 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 
 	state = sh_mmcif_readl(host->addr, MMCIF_CE_INT);
 
-	if (state & INT_RBSYE) {
+	if (state & INT_ERR_STS) {
+		/* error interrupts - process first */
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
+		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
+		err = 1;
+	} else if (state & INT_RBSYE) {
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
 				~(INT_RBSYE | INT_CRSPE));
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MRBSYE);
@@ -976,11 +981,6 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
 				~(INT_CMD12RBE | INT_CMD12CRE));
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MCMD12RBE);
-	} else if (state & INT_ERR_STS) {
-		/* err interrupts */
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
-		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
-		err = 1;
 	} else {
 		dev_dbg(&host->pd->dev, "Unsupported interrupt: 0x%x\n", state);
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
-- 
1.7.2.5

