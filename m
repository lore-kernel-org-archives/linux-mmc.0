From: Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH] mmc: sh_mmcif: Correct TX DMA channel allocation
Date: Wed, 10 Feb 2016 14:07:01 +0000
Message-ID: <1455113221-18117-1-git-send-email-chris.paterson2@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, ykaneko0929@gmail.com, arnd@arndb.de, geert+renesas@glider.be, laurent.pinchart@ideasonboard.com, kouichi.tomita.yn@renesas.com, takeshi.kihara.df@renesas.com, koji.matsuoka.xm@renesas.com, Chris Paterson <chris.paterson2@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Commit 27cbd7e815a8 ("mmc: sh_mmcif: rework dma channel handling")
introduced a typo causing the TX DMA channel allocation to be overwritten
by the requested RX DMA channel.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 drivers/mmc/host/sh_mmcif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index e0c076a..8d870ce 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -445,7 +445,7 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host)
 							pdata->slave_id_rx);
 	} else {
 		host->chan_tx = dma_request_slave_channel(dev, "tx");
-		host->chan_tx = dma_request_slave_channel(dev, "rx");
+		host->chan_rx = dma_request_slave_channel(dev, "rx");
 	}
 	dev_dbg(dev, "%s: got channel TX %p RX %p\n", __func__, host->chan_tx,
 		host->chan_rx);
-- 
1.9.1
