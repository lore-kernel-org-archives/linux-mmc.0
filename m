From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [RFC PATCH 1/7] mmc: sdhci: add quirk for broken 3.0V support
Date: Fri, 20 Jun 2014 17:35:22 +0800
Message-ID: <1403256928-11359-2-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35964 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933582AbaFTJfg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jun 2014 05:35:36 -0400
Received: by mail-pd0-f173.google.com with SMTP id r10so2797133pdi.4
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jun 2014 02:35:36 -0700 (PDT)
In-Reply-To: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, linux-mmc@vger.kernel.org
Cc: anton@enomsg.org, linuxppc-dev@lists.ozlabs.org, patches@linaro.org, andy.green@linaro.org, Vincent.Yang@tw.fujitsu.com

This patch defines a quirk for platforms unable
to enable 3.0V support.
It is a preparation and will be used by Fujitsu
SDHCI controller f_sdh30 driver.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 drivers/mmc/host/sdhci.c  | 3 +++
 include/linux/mmc/sdhci.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47055f3..523075f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3069,6 +3069,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	}
 #endif /* CONFIG_REGULATOR */
 
+	if (host->quirks2 & SDHCI_QUIRK2_NO_3_0_V)
+		caps[0] &= ~SDHCI_CAN_VDD_300;
+
 	/*
 	 * According to SD Host Controller spec v3.00, if the Host System
 	 * can afford more than 150mA, Host Driver should set XPC to 1. Also
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 08abe99..cac0958 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -98,6 +98,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_BROKEN_HS200			(1<<6)
 /* Controller does not support DDR50 */
 #define SDHCI_QUIRK2_BROKEN_DDR50			(1<<7)
+/* The system physically doesn't support 3.0v, even if the host does */
+#define SDHCI_QUIRK2_NO_3_0_V				(1<<8)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0

