From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 1/2] sdhci: sdhci.c: Add pre / post reset processing for
 chip specific reset
Date: Sun, 13 Feb 2011 23:08:51 -0800
Message-ID: <34AA1352-6C6B-400C-8883-9D9EC2E655D5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:38487 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751707Ab1BNHKh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:10:37 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


pxa controllers have private registers that may need to be
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
index 1a88303..7207b57 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -158,6 +158,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 		ier = sdhci_readl(host, SDHCI_INT_ENABLE);
 
+	if (host->ops->platform_reset_enter)
+		host->ops->platform_reset_enter(host, mask);
+
 	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
 
 	if (mask & SDHCI_RESET_ALL)
@@ -178,6 +181,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 		mdelay(1);
 	}
 
+	if (host->ops->platform_reset_exit)
+		host->ops->platform_reset_exit(host, mask);
+
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 1f032c0..4f62505 100644
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


