From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] mmc: wbsd: implement check for dma mapping error
Date: Sat, 12 Nov 2016 00:42:44 +0300
Message-ID: <1478900564-5086-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:54942 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756014AbcKKVmz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 11 Nov 2016 16:42:55 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

wbsd_request_dma() does not check for dma mapping errors.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/mmc/host/wbsd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index c3fd16d997ca..80a3b11f3217 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1395,23 +1395,25 @@ static void wbsd_request_dma(struct wbsd_host *host, int dma)
 	 */
 	host->dma_addr = dma_map_single(mmc_dev(host->mmc), host->dma_buffer,
 		WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(mmc_dev(host->mmc), host->dma_addr))
+		goto kfree;
 
 	/*
 	 * ISA DMA must be aligned on a 64k basis.
 	 */
 	if ((host->dma_addr & 0xffff) != 0)
-		goto kfree;
+		goto unmap;
 	/*
 	 * ISA cannot access memory above 16 MB.
 	 */
 	else if (host->dma_addr >= 0x1000000)
-		goto kfree;
+		goto unmap;
 
 	host->dma = dma;
 
 	return;
 
-kfree:
+unmap:
 	/*
 	 * If we've gotten here then there is some kind of alignment bug
 	 */
@@ -1421,6 +1423,7 @@ static void wbsd_request_dma(struct wbsd_host *host, int dma)
 		WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
 	host->dma_addr = 0;
 
+kfree:
 	kfree(host->dma_buffer);
 	host->dma_buffer = NULL;
 
@@ -1434,7 +1437,7 @@ static void wbsd_request_dma(struct wbsd_host *host, int dma)
 
 static void wbsd_release_dma(struct wbsd_host *host)
 {
-	if (host->dma_addr) {
+	if (!dma_mapping_error(mmc_dev(host->mmc), host->dma_addr)) {
 		dma_unmap_single(mmc_dev(host->mmc), host->dma_addr,
 			WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
 	}
-- 
2.7.4

