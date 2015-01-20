From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [PATCH v5 2/4] mmc: sdhci: add a quirk for tuning work around
Date: Tue, 20 Jan 2015 16:05:16 +0800
Message-ID: <1421741118-18743-3-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1421741118-18743-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40558 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbbATIHY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jan 2015 03:07:24 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so29948920pdj.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2015 00:07:24 -0800 (PST)
In-Reply-To: <1421741118-18743-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
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
index 144b561..ffe6340 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1964,6 +1964,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 	ctrl |= SDHCI_CTRL_EXEC_TUNING;
+	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
+		ctrl |= SDHCI_CTRL_TUNED_CLK;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	/*
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index f767a0d..bc973f7 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -106,6 +106,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD	(1<<10)
 /* Capability register bit-63 indicates HS400 support */
 #define SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400		(1<<11)
+/* forced tuned clock */
+#define SDHCI_QUIRK2_TUNING_WORK_AROUND			(1<<12)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0

