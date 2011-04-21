From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] sdhci: add quirk to support shared bus controller
Date: Thu, 21 Apr 2011 01:51:03 -0700
Message-ID: <BANLkTi=7h_gBQ1CGqYgUUhZabcwVuoRhCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35662 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1DUIvX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 04:51:23 -0400
Received: by qwk3 with SMTP id 3so742499qwk.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 01:51:23 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: bin.shi@csr.com, Binghua.Duan@csr.com

From: Bin Shi <bin.shi@csr.com>

some controllers share data bus or other pins between
multi-controllers and need to switch the functions of shared pins
runtime
this patch requested those shared pins before actual hardware access
and release them after access

Signed-off-by: Bin Shi <bin.shi@csr.com>
Cc: Binghua Duan <binghua.duan@csr.com>
Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/mmc/host/sdhci.c  |   13 +++++++++++++
 drivers/mmc/host/sdhci.h  |    2 ++
 include/linux/mmc/sdhci.h |    2 ++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f31077d..7b07152 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1379,6 +1379,13 @@ static void sdhci_tasklet_finish(unsigned long param)
 		sdhci_reset(host, SDHCI_RESET_DATA);
 	}

+	/*
+	 * some controllers share data bus or other pins between multi-controller
+	 * and need to switch the function of pins runtime
+	 */
+	if (host->quirks & SDHCI_QUIRK_SHARED_PINS)
+		host->ops->get_shared_pins(host);
+
 	host->mrq = NULL;
 	host->cmd = NULL;
 	host->data = NULL;
@@ -1391,6 +1398,12 @@ static void sdhci_tasklet_finish(unsigned long param)
 	spin_unlock_irqrestore(&host->lock, flags);

 	mmc_request_done(host->mmc, mrq);
+
+	/*
+	 * release shared pins so that other controllers can use them
+	 */
+	if (host->quirks & SDHCI_QUIRK_SHARED_PINS)
+		host->ops->get_shared_pins(host);
 }

 static void sdhci_timeout_timer(unsigned long data)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 85750a9..9d918a5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -229,6 +229,8 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
+	unsigned int    (*get_shared_pins)(struct sdhci_host *host);
+	unsigned int    (*put_shared_pins)(struct sdhci_host *host);
 };

 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 83bd9f7..32ab422 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -85,6 +85,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
 /* Controller treats ADMA descriptors with length 0000h incorrectly */
 #define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
+/* Controller shared data bus or other pins with other controllers */
+#define SDHCI_QUIRK_SHARED_PINS                         (1<<31)

 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.1
