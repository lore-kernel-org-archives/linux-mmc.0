From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/2] mmc: renesas_sdhi_internal_dmac: Fix missing unmap in error patch
Date: Thu, 28 Jun 2018 19:29:04 +0900
Message-ID: <1530181745-10519-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1530181745-10519-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1530181745-10519-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: stable-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

This patch fixes an issue that lacks the dma_unmap_sg() calling in
the error patch of renesas_sdhi_internal_dmac_start_dma().

Fixes: 0cbc94daa554 ("mmc: renesas_sdhi_internal_dmac: limit DMA RX for old SoCs")
Cc: <stable@vger.kernel.org> # v4.17+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index f7f9773..d503511 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -173,8 +173,11 @@
 	if (data->flags & MMC_DATA_READ) {
 		dtran_mode |= DTRAN_MODE_CH_NUM_CH1;
 		if (test_bit(SDHI_INTERNAL_DMAC_ONE_RX_ONLY, &global_flags) &&
-		    test_and_set_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags))
+		    test_and_set_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags)) {
+			dma_unmap_sg(&host->pdev->dev, sg, host->sg_len,
+				     mmc_get_dma_dir(data));
 			goto force_pio;
+		}
 	} else {
 		dtran_mode |= DTRAN_MODE_CH_NUM_CH0;
 	}
-- 
1.9.1
