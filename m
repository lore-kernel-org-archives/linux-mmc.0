From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 11/22] mmc: renesas_sdhi: remove always false condition
Date: Sat, 25 Nov 2017 01:24:46 +0900
Message-ID: <1511540697-27387-12-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

renesas_sdhi_probe() always sets host->dma as follows:

        host->dma               = dma_priv;

!host->dma is always false.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Newly added

 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 9ab1043..e210644 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -360,8 +360,8 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 					      struct tmio_mmc_data *pdata)
 {
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
-	if (!host->dma || (!host->pdev->dev.of_node &&
-			   (!pdata->chan_priv_tx || !pdata->chan_priv_rx)))
+	if (!host->pdev->dev.of_node &&
+	    (!pdata->chan_priv_tx || !pdata->chan_priv_rx))
 		return;
 
 	if (!host->chan_tx && !host->chan_rx) {
-- 
2.7.4
