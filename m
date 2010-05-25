From: "Pinkava J." <Jiri.Pinkava@vscht.cz>
Subject: [PATCH] ARM: SAMSUNG: MMC: Fix build error when both DMA and PIO
 mode selected
Date: Tue, 25 May 2010 09:48:58 +0200
Message-ID: <4BFB80EA.4040807@vscht.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ns.vscht.cz ([147.33.15.5]:48256 "EHLO ns.vscht.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484Ab0EYIGi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 May 2010 04:06:38 -0400
Received: from SMTPgw.vscht.cz (smtpgw.vscht.cz [147.33.10.26])
	by ns.vscht.cz (8.13.8/8.13.8) with ESMTP id o4P7mx6p006044
	for <linux-mmc@vger.kernel.org>; Tue, 25 May 2010 09:48:59 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org


Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 drivers/mmc/host/s3cmci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 2fdf768..4426a4b 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1600,7 +1600,7 @@ static int __devinit s3cmci_probe(struct platform_device
*pdev)
 	host->pio_active 	= XFER_NONE;

 #ifdef CONFIG_MMC_S3C_PIODMA
-	host->dodma		= host->pdata->dma;
+	host->dodma		= host->pdata->use_dma;
 #endif

 	host->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.1
