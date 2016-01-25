From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/9] mmc: tmio_dma: remove debug messages with little information
Date: Mon, 25 Jan 2016 20:15:08 +0100
Message-ID: <1453749316-1848-2-git-send-email-wsa@the-dreams.de>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

When compiling the driver with CONFIG_MMC_DEBUG set, I get:

===
drivers/mmc/host/tmio_mmc_dma.c: In function 'tmio_mmc_start_dma':
include/linux/device.h:1186:2: warning: 'cookie' may be used uninitialized in this function [-Wmaybe-uninitialized]
...

drivers/mmc/host/tmio_mmc_dma.c:52:15: note: 'cookie' was declared here
  dma_cookie_t cookie;
...

drivers/mmc/host/tmio_mmc_dma.c:128:15: note: 'cookie' was declared here
  dma_cookie_t cookie;
===

Because these debug messages look random anyhow (some duplicate
information printed etc), let's just drop them and rather re-add
something consistent if that should ever be needed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_dma.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index e4b05dbb9ca822..67543587382312 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -95,9 +95,6 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 			ret = cookie;
 		}
 	}
-	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
-		__func__, host->sg_len, ret, cookie, host->mrq);
-
 pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
@@ -115,9 +112,6 @@ pio:
 		dev_warn(&host->pdev->dev,
 			 "DMA failed: %d, falling back to PIO\n", ret);
 	}
-
-	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d, sg[%d]\n", __func__,
-		desc, cookie, host->sg_len);
 }
 
 static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
@@ -175,9 +169,6 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 			ret = cookie;
 		}
 	}
-	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
-		__func__, host->sg_len, ret, cookie, host->mrq);
-
 pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
@@ -195,9 +186,6 @@ pio:
 		dev_warn(&host->pdev->dev,
 			 "DMA failed: %d, falling back to PIO\n", ret);
 	}
-
-	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d\n", __func__,
-		desc, cookie);
 }
 
 void tmio_mmc_start_dma(struct tmio_mmc_host *host,
-- 
2.1.4

