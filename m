From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [PATCH 2/4] mmc: sdhci: add a quirk for tuning work around
Date: Fri, 21 Nov 2014 08:51:38 +0800
Message-ID: <1416531100-26707-3-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:37880 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbaKUAxf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 19:53:35 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so4061345pdb.8
        for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2014 16:53:35 -0800 (PST)
In-Reply-To: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux@arm.linux.org.uk, chris@printf.net, ulf.hansson@linaro.org, andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, Vincent Yang <Vincent.Yang@tw.fujitsu.com>

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
index 66ad318..e245ba2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1891,6 +1891,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 	ctrl |= SDHCI_CTRL_EXEC_TUNING;
+	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
+		ctrl |= SDHCI_CTRL_TUNED_CLK;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	/*
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index dba793e..5a78cd6 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -100,6 +100,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_BROKEN_DDR50			(1<<7)
 /* Stop command (CMD12) can set Transfer Complete when not using MMC_RSP_BUSY */
 #define SDHCI_QUIRK2_STOP_WITH_TC			(1<<8)
+/* forced tuned clock */
+#define SDHCI_QUIRK2_TUNING_WORK_AROUND			(1<<9)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0

