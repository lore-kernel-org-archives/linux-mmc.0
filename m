From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 13/31] mmc: sdhci: move FSL ESDHC reset handling quirk
 into esdhc code
Date: Tue, 18 Feb 2014 15:10:09 +0000
Message-ID: <E1WFmJF-0006me-7W@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40485 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755906AbaBRPKM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:10:12 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

The Freescale esdhc driver is the only driver which needs the interrupt
registers restored after a reset.  Move this quirk to be part of the
ESDHC driver implementation.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 +++++++++-
 drivers/mmc/host/sdhci-esdhc.h     |  3 +--
 drivers/mmc/host/sdhci.c           |  5 -----
 include/linux/mmc/sdhci.h          |  2 --
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b1d74fa33c5f..812c5772d900 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-esdhc-imx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -876,6 +876,14 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	return esdhc_change_pinstate(host, uhs);
 }
 
=+DO NOT APPLY+=static void esdhc_reset(struct sdhci_host *host, u8 mask)
=+DO NOT APPLY+={
=+DO NOT APPLY+=	sdhci_reset(host, mask);
=+DO NOT APPLY+=
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
=+DO NOT APPLY+=}
=+DO NOT APPLY+=
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -888,7 +896,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_ro = esdhc_pltfm_get_ro,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
-	.reset = sdhci_reset,
=+DO NOT APPLY+=	.reset = esdhc_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index a7d9f95a7b03..de69bddc3afc 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-esdhc.h
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-esdhc.h
@@ -22,8 +22,7 @@
 				SDHCI_QUIRK_NO_BUSY_IRQ | \
 				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
-				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
-				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
=+DO NOT APPLY+=				SDHCI_QUIRK_PIO_NEEDS_DELAY)
 
 #define ESDHC_SYSTEM_CONTROL	0x2c
 #define ESDHC_CLOCK_MASK	0x0000fff0
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 10540192d544..bcf4f9ec0ea4 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -203,11 +203,6 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 
 	host->ops->reset(host, mask);
 
-	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET) {
-		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
-		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
-	}
-
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		if ((host->ops->enable_dma) && (mask & SDHCI_RESET_ALL))
 			host->ops->enable_dma(host);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 493c57aee4cb..801579313789 100644
=-DO NOT APPLY-= a/include/linux/mmc/sdhci.h
=+DO NOT APPLY+= b/include/linux/mmc/sdhci.h
@@ -61,8 +61,6 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NONSTANDARD_CLOCK			(1<<17)
 /* Controller does not like fast PIO transfers */
 #define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
-/* Controller losing signal/interrupt enable states after reset */
-#define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
 /* Controller has to be forced to use block size of 2048 bytes */
 #define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
 /* Controller cannot do multi-block transfers */
-- 
1.8.3.1

