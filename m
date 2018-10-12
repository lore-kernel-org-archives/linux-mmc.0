From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] mmc: uniphier-sd: avoid using broken DMA RX channel
Date: Fri, 12 Oct 2018 23:57:38 +0900
Message-ID: <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

host->chan_rx is NULL when UNIPHIER_SD_CAP_BROKEN_DMA_RX quirk flag
is set. In this case, it should not set up DMA.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/uniphier-sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 10d49aa..1ee9fd0 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -251,6 +251,9 @@ static void uniphier_sd_internal_dma_start(struct tmio_mmc_host *host,
 	u32 dma_mode;
 	int sg_len;
 
+	if ((data->flags & MMC_DATA_READ) && !host->chan_rx)
+		goto force_pio;
+
 	if (WARN_ON(host->sg_len != 1))
 		goto force_pio;
 
-- 
2.7.4
