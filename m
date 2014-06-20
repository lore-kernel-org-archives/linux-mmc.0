From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [RFC PATCH 2/7] mmc: sdhci: add quirk for voltage switch callback
Date: Fri, 20 Jun 2014 17:35:23 +0800
Message-ID: <1403256928-11359-3-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:64233 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933582AbaFTJfj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jun 2014 05:35:39 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so2917457pad.14
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jun 2014 02:35:38 -0700 (PDT)
In-Reply-To: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, linux-mmc@vger.kernel.org
Cc: anton@enomsg.org, linuxppc-dev@lists.ozlabs.org, patches@linaro.org, andy.green@linaro.org, Vincent.Yang@tw.fujitsu.com

This patch defines a quirk to do a callback when
switching voltages so do controller-specific
actions.
It is a preparation and will be used by Fujitsu
SDHCI controller f_sdh30 driver.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 drivers/mmc/host/sdhci.c  | 5 +++++
 drivers/mmc/host/sdhci.h  | 1 +
 include/linux/mmc/sdhci.h | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 523075f..98d996f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1763,6 +1763,11 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 		ctrl |= SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
+		/* Some controller need to do more when switching */
+		if ((host->quirks2 & SDHCI_QUIRK2_VOLTAGE_SWITCH) &&
+		    host->ops->voltage_switch)
+			host->ops->voltage_switch(host);
+
 		/* Wait for 5ms */
 		usleep_range(5000, 5500);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4a5cd5e..63c7a46 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -292,6 +292,7 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
+	void	(*voltage_switch)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index cac0958..13ab139 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -100,6 +100,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_BROKEN_DDR50			(1<<7)
 /* The system physically doesn't support 3.0v, even if the host does */
 #define SDHCI_QUIRK2_NO_3_0_V				(1<<8)
+/* Do a callback when switching voltages so do controller-specific actions */
+#define SDHCI_QUIRK2_VOLTAGE_SWITCH			(1<<9)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0

