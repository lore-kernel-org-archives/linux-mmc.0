From: ludovic.desroches@atmel.com
Subject: [PATCH 2/2] mmc: atmel-mci: fix typo
Date: Thu,  9 Feb 2012 16:33:54 +0100
Message-ID: <e3d27dde7a46fcd0e440e17e4a66469f6b22697f.1328801500.git.ludovic.desroches@atmel.com>
References: <7ef1b8ff1e9425fc99bd737faaa9f63aa4f4f8b4.1328801500.git.ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:50697 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757549Ab2BINfH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 08:35:07 -0500
In-Reply-To: <7ef1b8ff1e9425fc99bd737faaa9f63aa4f4f8b4.1328801500.git.ludovic.desroches@atmel.com>
In-Reply-To: <7ef1b8ff1e9425fc99bd737faaa9f63aa4f4f8b4.1328801500.git.ludovic.desroches@atmel.com>
References: <7ef1b8ff1e9425fc99bd737faaa9f63aa4f4f8b4.1328801500.git.ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: cjb@laptop.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index e71a158..09ac13b 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1968,7 +1968,7 @@ static bool atmci_configure_dma(struct atmel_mci *host)
 		return false;
 	} else {
 		dev_info(&host->pdev->dev,
-					"Using %s for DMA transfers\n",
+					"using %s for DMA transfers\n",
 					dma_chan_name(host->dma.chan));
 		return true;
 	}
-- 
1.7.5.4

