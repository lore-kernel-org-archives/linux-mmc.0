From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: renesas_sdhi: use extra flag for CBSY usage
Date: Wed,  9 Aug 2017 21:00:41 +0200
Message-ID: <20170809190041.1052-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33345 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbdHITAs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Aug 2017 15:00:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Chris Brandt <chris.brandt@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

There is one SDHI instance on Gen2 which does not have the CBSY bit.
So, turn CBSY usage into an extra flag and set it accordingly. This has
the additional advantage that we can also set it for other incarnations
later.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Tested on a M3-W Salvator-X and H2 Lager (with both SDHI instances). I could
move large files around without problems. Note that on the special incarnation
without the CBSY bit, the old code still worked, so there might be a CBSY bit.
But it is not documented, so we better play safe.

Chris: according to the specs I have, we can enable it for RZ as well. I'll
send a patch for that in a minute. If you could test this on top of this one,
that would be much appreciated! Thanks.


 drivers/mmc/host/renesas_sdhi_core.c          | 6 +++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 ++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 6 ++++--
 include/linux/mfd/tmio.h                      | 3 +++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index a252145097d6a5..e46504edc9fcb4 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -429,7 +429,7 @@ static int renesas_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 	case CTL_TRANSACTION_CTL:
 	case CTL_DMA_ENABLE:
 	case EXT_ACC:
-		if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
+		if (host->pdata->flags & TMIO_MMC_HAVE_CBSY)
 			bit = TMIO_STAT_CMD_BUSY;
 		/* fallthrough */
 	case CTL_SD_CARD_CLK_CTL:
@@ -589,6 +589,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (ret < 0)
 		goto efree;
 
+	/* One Gen2 SDHI incarnation does NOT have a CBSY bit */
+	if (sd_ctrl_read16(host, CTL_VERSION) == SDHI_VER_GEN2_SDR50)
+		mmc_data->flags &= ~TMIO_MMC_HAVE_CBSY;
+
 	/* Enable tuning iff we have an SCC and a supported mode */
 	if (of_data && of_data->scc_offset &&
 	    (host->mmc->caps & MMC_CAP_UHS_SDR104 ||
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 6717003888e292..fa4e71d3b47d47 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -72,7 +72,8 @@ static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
 
 static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_HAVE_CBSY |
+			  TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23,
 	.bus_shift	= 2,
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 718cb8a9d2ce8d..9b77f521cd2c2f 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -58,7 +58,8 @@ static struct renesas_sdhi_scc rcar_gen2_scc_taps[] = {
 
 static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_HAVE_CBSY |
+			  TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23,
 	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
@@ -78,7 +79,8 @@ static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
 
 static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_HAVE_CBSY |
+			  TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23,
 	.bus_shift	= 2,
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 18b17a39d465ed..b572955e6de6ab 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -107,6 +107,9 @@
  */
 #define TMIO_MMC_CLK_ACTUAL		BIT(10)
 
+/* Some controllers have a CBSY bit */
+#define TMIO_MMC_HAVE_CBSY		BIT(11)
+
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
 void tmio_core_mmc_pwr(void __iomem *cnf, int shift, int state);
-- 
2.11.0

