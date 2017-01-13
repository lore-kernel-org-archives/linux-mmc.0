From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] mmc: wbsd: safer check if dma_addr is valid DMA address
Date: Sat, 14 Jan 2017 01:52:51 +0300
Message-ID: <1484347971-30829-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:60480 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbdAMWxP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 13 Jan 2017 17:53:15 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

host->dma_addr can store a value that is not returned by the DMA API,
so it is safer to check if is a valid DMA address indirectly.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/mmc/host/wbsd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 80a3b11f3217..bd04e8bae010 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1437,11 +1437,14 @@ static void wbsd_request_dma(struct wbsd_host *host, int dma)
 
 static void wbsd_release_dma(struct wbsd_host *host)
 {
-	if (!dma_mapping_error(mmc_dev(host->mmc), host->dma_addr)) {
+	/*
+	 * host->dma_addr is valid here iff host->dma_buffer is not NULL.
+	 */
+	if (host->dma_buffer) {
 		dma_unmap_single(mmc_dev(host->mmc), host->dma_addr,
 			WBSD_DMA_SIZE, DMA_BIDIRECTIONAL);
+		kfree(host->dma_buffer);
 	}
-	kfree(host->dma_buffer);
 	if (host->dma >= 0)
 		free_dma(host->dma);
 
-- 
2.7.4

