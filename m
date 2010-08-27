From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] ARM: SAMSUNG: MMC: Fix build error when both DMA
	and PIO mode selected
Date: Fri, 27 Aug 2010 20:46:01 +0100
Message-ID: <20100827194601.GI23079@void.printf.net>
References: <4BFB80EA.4040807@vscht.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33124 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596Ab0H0TqD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:46:03 -0400
Content-Disposition: inline
In-Reply-To: <4BFB80EA.4040807@vscht.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Pinkava J." <Jiri.Pinkava@vscht.cz>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org

From: Jiri Pinkava <jiri.pinkava@vscht.cz>
Date: Tue, 25 May 2010 09:48:58 +0200

Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
[cjb: fix line-wrapped patch]
---
 drivers/mmc/host/s3cmci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 2fdf768..4426a4b 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1600,7 +1600,7 @@ static int __devinit s3cmci_probe(struct platform_device *pdev)
 	host->pio_active 	= XFER_NONE;

 #ifdef CONFIG_MMC_S3C_PIODMA
-	host->dodma		= host->pdata->dma;
+	host->dodma		= host->pdata->use_dma;
 #endif

 	host->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.1

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
