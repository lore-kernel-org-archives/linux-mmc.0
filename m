From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 26/31] mmc: sdhci: cache timing information locally
Date: Tue, 18 Feb 2014 15:11:16 +0000
Message-ID: <E1WFmKK-0006na-8P@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40556 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756252AbaBRPLS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:11:18 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

Rather than reading back the timing information from the registers,
cache it locally.  This allows implementations to translate the UHS
timing by overriding the set_uhs_signaling() method as required
without also having to emulate the SDHCI_HOST_CONTROL2 register.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci.c  | 23 ++++++++++++-----------
 include/linux/mmc/sdhci.h |  2 ++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d7e142ea55ef..01eed75d9404 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -1083,24 +1083,23 @@ static void sdhci_finish_command(struct sdhci_host *host)
 
 static u16 sdhci_get_preset_value(struct sdhci_host *host)
 {
-	u16 ctrl, preset = 0;
=+DO NOT APPLY+=	u16 preset = 0;
 
-	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-
-	switch (ctrl & SDHCI_CTRL_UHS_MASK) {
-	case SDHCI_CTRL_UHS_SDR12:
=+DO NOT APPLY+=	switch (host->timing) {
=+DO NOT APPLY+=	case MMC_TIMING_UHS_SDR12:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR12);
 		break;
-	case SDHCI_CTRL_UHS_SDR25:
=+DO NOT APPLY+=	case MMC_TIMING_UHS_SDR25:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR25);
 		break;
-	case SDHCI_CTRL_UHS_SDR50:
=+DO NOT APPLY+=	case MMC_TIMING_UHS_SDR50:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR50);
 		break;
-	case SDHCI_CTRL_UHS_SDR104:
=+DO NOT APPLY+=	case MMC_TIMING_UHS_SDR104:
=+DO NOT APPLY+=	case MMC_TIMING_MMC_HS200:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR104);
 		break;
-	case SDHCI_CTRL_UHS_DDR50:
=+DO NOT APPLY+=	case MMC_TIMING_UHS_DDR50:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_DDR50);
 		break;
 	default:
@@ -1530,6 +1529,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		}
 
 		host->ops->set_uhs_signaling(host, ios->timing);
=+DO NOT APPLY+=		host->timing = ios->timing;
 
 		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
 				((ios->timing == MMC_TIMING_UHS_SDR12) ||
@@ -1828,12 +1828,13 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * If the Host Controller supports the HS200 mode then the
 	 * tuning function has to be executed.
 	 */
-	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR50) &&
=+DO NOT APPLY+=	if (host->timing == MMC_TIMING_UHS_SDR50 &&
 	    (host->flags & SDHCI_SDR50_NEEDS_TUNING ||
 	     host->flags & SDHCI_SDR104_NEEDS_TUNING))
 		requires_tuning_nonuhs = true;
 
-	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR104) ||
=+DO NOT APPLY+=	if (host->timing == MMC_TIMING_MMC_HS200 ||
=+DO NOT APPLY+=	    host->timing == MMC_TIMING_UHS_SDR104 ||
 	    requires_tuning_nonuhs)
 		ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	else {
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 20daa39e3a68..54fff6156d1b 100644
=-DO NOT APPLY-= a/include/linux/mmc/sdhci.h
=+DO NOT APPLY+= b/include/linux/mmc/sdhci.h
@@ -170,6 +170,8 @@ struct sdhci_host {
 	unsigned int            ocr_avail_mmc;
 	u32 ocr_mask;		/* available voltages */
 
=+DO NOT APPLY+=	unsigned		timing;		/* Current timing */
=+DO NOT APPLY+=
 	u32			thread_isr;
 
 	/* cached registers */
-- 
1.8.3.1

