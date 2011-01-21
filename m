From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: Add pre and post reset processing for chip specific
 reset
Date: Fri, 21 Jan 2011 11:26:40 -0800
Message-ID: <49807409-2DDA-4C6D-AD98-ECDEF8B3B633@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:54055 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753971Ab1AUT0y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 14:26:54 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


Marvell pxa controllers have private registers that may need to be
modified before and after a reset is done.

For example, the SD reset
operation, RESET_ALL,  will reset the private registers to their
default state.  This will cause the clock adjustment registers that
may have been programmed to have incorrect values.

RESET_DATA sometimes needs to be delayed before the reset is done
(depending on SoC) to enable any transactions being handled by the
SDIO card to be completed.  Needed in pre SD 3.0 silicon to handle
clock gating.

Implement hooks to allow this to happen.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    6 ++++++
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d5febe5..f439881 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -157,6 +157,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 		ier = sdhci_readl(host, SDHCI_INT_ENABLE);
 
+	if (host->ops->platform_reset_enter)
+		host->ops->platform_reset_enter(host, mask);
+
 	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
 
 	if (mask & SDHCI_RESET_ALL)
@@ -177,6 +180,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 		mdelay(1);
 	}
 
+	if (host->ops->platform_reset_exit)
+		host->ops->platform_reset_exit(host, mask);
+
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..9dd7bc1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -222,6 +222,8 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
+	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
+	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0.4


