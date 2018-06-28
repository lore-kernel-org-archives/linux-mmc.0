From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/2] mmc: renesas_sdhi_internal_dmac: Cannot clear the RX_IN_USE in abort
Date: Thu, 28 Jun 2018 19:29:05 +0900
Message-ID: <1530181745-10519-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1530181745-10519-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1530181745-10519-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: stable-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

This patch is fixes an issue that the SDHI_INTERNAL_DMAC_RX_IN_USE
flag cannot be cleared because tmio_mmc_core sets the host->data
to NULL before the tmio_mmc_core calls tmio_mmc_abort_dma().

So, this patch clears the SDHI_INTERNAL_DMAC_RX_IN_USE in
the renesas_sdhi_internal_dmac_abort_dma() anyway. This doesn't
cause any side effects.

Fixes: 0cbc94daa554 ("mmc: renesas_sdhi_internal_dmac: limit DMA RX for old SoCs")
Cc: <stable@vger.kernel.org> # v4.17+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index d503511..3669981 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -139,8 +139,7 @@
 	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_RST,
 					    RST_RESERVED_BITS | val);
 
-	if (host->data && host->data->flags & MMC_DATA_READ)
-		clear_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags);
+	clear_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags);
 
 	renesas_sdhi_internal_dmac_enable_dma(host, true);
 }
-- 
1.9.1
