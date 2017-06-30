From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/4] mmc: tmio: no magic values when enabling DMA
Date: Fri, 30 Jun 2017 12:56:48 +0200
Message-ID: <20170630105649.16137-4-wsa+renesas@sang-engineering.com>
References: <20170630105649.16137-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34650 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbdF3K5P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 30 Jun 2017 06:57:15 -0400
In-Reply-To: <20170630105649.16137-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Use a proper define.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 drivers/mmc/host/tmio_mmc.h          | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index be806d3e9afeec..dd215723fa4312 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -459,7 +459,7 @@ static int renesas_sdhi_multi_io_quirk(struct mmc_card *card,
 
 static void renesas_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
-	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
+	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? DMA_ENABLE_DMASDRW : 0);
 
 	/* enable 32bit access if DMA mode if possibile */
 	renesas_sdhi_sdbuf_width(host, enable ? 32 : 16);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index e3e96178acaab4..3e6ff892144034 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -97,6 +97,9 @@
 
 #define TMIO_SDIO_SETBITS_MASK	0x0006
 
+/* Definitions for values the CTL_DMA_ENABLE register can take */
+#define DMA_ENABLE_DMASDRW	BIT(1)
+
 /* Define some IRQ masks */
 /* This is the mask used at reset by the chip */
 #define TMIO_MASK_ALL           0x837f031d
-- 
2.11.0

