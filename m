From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/5] mmc: tmio: name 0xd8 as CTL_DMA_ENABLE
Date: Mon, 20 Jun 2011 15:06:51 +0900
Message-ID: <1308550015-15717-2-git-send-email-horms@verge.net.au>
References: <1308550015-15717-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1308550015-15717-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

This reflects at least the current usage of this register
and I think it improves the readability of the code ever so slightly.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

Dependencies: none known
---
 drivers/mmc/host/tmio_mmc_dma.c |    2 +-
 include/linux/mmc/tmio.h        |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 25f1ad6..9c4da66 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -26,7 +26,7 @@ static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
 #if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
 	/* Switch DMA mode on or off - SuperH specific? */
-	writew(enable ? 2 : 0, host->ctl + (0xd8 << host->bus_shift));
+	writew(enable ? 2 : 0, host->ctl + (CTL_DMA_ENABLE << host->bus_shift));
 #endif
 }
 
diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
index 19490b9..0a6e40d 100644
--- a/include/linux/mmc/tmio.h
+++ b/include/linux/mmc/tmio.h
@@ -30,6 +30,7 @@
 #define CTL_TRANSACTION_CTL 0x34
 #define CTL_SDIO_STATUS 0x36
 #define CTL_SDIO_IRQ_MASK 0x38
+#define CTL_DMA_ENABLE 0xd8
 #define CTL_RESET_SD 0xe0
 #define CTL_SDIO_REGS 0x100
 #define CTL_CLK_AND_WAIT_CTL 0x138
-- 
1.7.4.4

