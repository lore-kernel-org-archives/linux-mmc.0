From: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Subject: [PATCH 1/4] mmc: sdhci: add quirk for voltage switch callback
Date: Sun, 13 Jul 2014 13:21:07 +0800
Message-ID: <1405228870-5088-2-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:38205 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaGMFWa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Jul 2014 01:22:30 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so654054pdb.41
        for <linux-mmc@vger.kernel.org>; Sat, 12 Jul 2014 22:22:29 -0700 (PDT)
In-Reply-To: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, arnd@arndb.de, olof@lixom.net, linux@arm.linux.org.uk, chris@printf.net, anton@enomsg.org, t.takinishi@jp.fujitsu.com, mollie.wu@linaro.org, Vincent.Yang@tw.fujitsu.com

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
index 47055f3..d62262b 100644
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
index 08abe99..5433f04 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -98,6 +98,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_BROKEN_HS200			(1<<6)
 /* Controller does not support DDR50 */
 #define SDHCI_QUIRK2_BROKEN_DDR50			(1<<7)
+/* Do a callback when switching voltages so do controller-specific actions */
+#define SDHCI_QUIRK2_VOLTAGE_SWITCH			(1<<8)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0

