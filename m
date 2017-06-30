From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/4] mmc: sdhi: use maximum width for the sdbuf register
Date: Fri, 30 Jun 2017 12:56:49 +0200
Message-ID: <20170630105649.16137-5-wsa+renesas@sang-engineering.com>
References: <20170630105649.16137-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34654 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752374AbdF3K5P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 30 Jun 2017 06:57:15 -0400
In-Reply-To: <20170630105649.16137-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

We can derive the sd_buf width from the bus_shift parameter which tells
us how far registers are apart. Remove the obvious comment, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index dd215723fa4312..48da28dfef6465 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -461,8 +461,7 @@ static void renesas_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
 	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? DMA_ENABLE_DMASDRW : 0);
 
-	/* enable 32bit access if DMA mode if possibile */
-	renesas_sdhi_sdbuf_width(host, enable ? 32 : 16);
+	renesas_sdhi_sdbuf_width(host, enable ? (16 << host->bus_shift) : 16);
 }
 
 int renesas_sdhi_probe(struct platform_device *pdev,
-- 
2.11.0

