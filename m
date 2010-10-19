From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: sdhci_dumpregs: allow private information to be
 dumped on error
Date: Tue, 19 Oct 2010 11:27:22 -0700
Message-ID: <CF727CE6-DAE4-4B18-9BAE-BF373D6DF990@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41857 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755238Ab0JSS26 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Oct 2010 14:28:58 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Our controller has private registers that are useful to see on error.
define a new host->ops to allow these registers to be printed

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    2 ++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 782c0ee..fba6e28 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -85,6 +85,8 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 		printk(KERN_DEBUG DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
 		       readl(host->ioaddr + SDHCI_ADMA_ERROR),
 		       readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
+	if (host->ops->print_private_info)
+		host->ops->print_private_info(host);
 
 	printk(KERN_DEBUG DRIVER_NAME ": ===========================================\n");
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b7b8a3b..2e11ff9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -215,6 +215,7 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
+	void		(*print_private_info)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.6.0.4

