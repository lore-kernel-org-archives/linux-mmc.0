From: "Paul Parsons" <lost.distance@yahoo.com>
Subject: [PATCH] mmc: tmio: Fix build errors
Date: Sun, 15 May 2011 13:24:52 +0000
Message-ID: <E1QLbJV-0007eN-AF@outmx05.plus.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:26800 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754153Ab1EONYy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 May 2011 09:24:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ian@mnementh.co.uk

Conditional code in tmio_mmc.h selects dummy tmio_mmc_start_dma(), tmio_mmc_request_dma() and tmio_mmc_release_dma() inline functions instead of the required declarations. This breaks the build of tmio_mmc_dma.c

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---
diff -uprN clean-2.6.39-rc7/drivers/mmc/host/tmio_mmc.h linux-2.6.39-rc7/drivers/mmc/host/tmio_mmc.h
--- clean-2.6.39-rc7/drivers/mmc/host/tmio_mmc.h	2011-05-11 00:54:17.647289808 +0100
+++ linux-2.6.39-rc7/drivers/mmc/host/tmio_mmc.h	2011-05-14 16:30:47.208267896 +0100
@@ -98,26 +98,8 @@ static inline void tmio_mmc_kunmap_atomi
 	local_irq_restore(*flags);
 }
 
-#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 void tmio_mmc_start_dma(struct tmio_mmc_host *host, struct mmc_data *data);
 void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata);
 void tmio_mmc_release_dma(struct tmio_mmc_host *host);
-#else
-static inline void tmio_mmc_start_dma(struct tmio_mmc_host *host,
-			       struct mmc_data *data)
-{
-}
-
-static inline void tmio_mmc_request_dma(struct tmio_mmc_host *host,
-				 struct tmio_mmc_data *pdata)
-{
-	host->chan_tx = NULL;
-	host->chan_rx = NULL;
-}
-
-static inline void tmio_mmc_release_dma(struct tmio_mmc_host *host)
-{
-}
-#endif
 
 #endif

