From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [RFC PATCH 3/7] mmc: sdhci: add quirk for tuning work around
Date: Fri, 20 Jun 2014 17:35:24 +0800
Message-ID: <1403256928-11359-4-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36767 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933582AbaFTJfl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jun 2014 05:35:41 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so2930791pad.28
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jun 2014 02:35:41 -0700 (PDT)
In-Reply-To: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, linux-mmc@vger.kernel.org
Cc: anton@enomsg.org, linuxppc-dev@lists.ozlabs.org, patches@linaro.org, andy.green@linaro.org, Vincent.Yang@tw.fujitsu.com

This patch defines a quirk for tuning work
around for some sdhci host controller. It sets
both SDHCI_CTRL_EXEC_TUNING and SDHCI_CTRL_TUNED_CLK
for tuning.
It is a preparation and will be used by Fujitsu
SDHCI controller f_sdh30 driver.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 drivers/mmc/host/sdhci.c  | 2 ++
 include/linux/mmc/sdhci.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 98d996f..fe69cc5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1867,6 +1867,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 	ctrl |= SDHCI_CTRL_EXEC_TUNING;
+	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
+		ctrl |= SDHCI_CTRL_TUNED_CLK;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	/*
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 13ab139..5690a1f 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -102,6 +102,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_NO_3_0_V				(1<<8)
 /* Do a callback when switching voltages so do controller-specific actions */
 #define SDHCI_QUIRK2_VOLTAGE_SWITCH			(1<<9)
+/* forced tuned clock */
+#define SDHCI_QUIRK2_TUNING_WORK_AROUND		(1<<10)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0

