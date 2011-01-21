From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH] mmc: clear all interrupt in suspend before free_irq
Date: Fri, 21 Jan 2011 05:27:16 -0500
Message-ID: <AANLkTi=M5M=uaGJ-+8K0fLDssDR7bnD=K0Saxz-Gww6y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62075 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab1AUK1R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jan 2011 05:27:17 -0500
Received: by qyj19 with SMTP id 19so369685qyj.19
        for <linux-mmc@vger.kernel.org>; Fri, 21 Jan 2011 02:27:16 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Nicolas Pitre <nico@fluxnic.net>, Ohad Ben-Cohen <ohad@wizery.com>, Bing Zhao <bzhao@marvell.com>, Chris Ball <cjb@laptop.org>

>From b7be39e0bbac3950057078ac66900ebc0871f77e Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Fri, 21 Jan 2011 18:02:47 -0500
Subject: [PATCH] mmc: clear all interrupt in suspend before free_irq

	When debugging wifi host sleep, race condition about
SDHCI_INT_CARD_INT happens.
	Host free_irq in suspend and request_irq when resume back.
	However SDHCI_INT_CARD_INT is not cleared, so interrupt will
immediately happen after request_irq.
	mmc_signal_sdio_irq will be called and wakeup sdio_irq_thread.
	As a result irq_handler in sdio driver is called even before host resume back.

	The correct case is mmc_sdio_resume calls mmc_signal_sdio_irq to
wakeup sdio_irq_thread

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aacd78c..97074ae 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1707,6 +1707,7 @@ int sdhci_suspend_host(struct sdhci_host *host,
pm_message_t state)
 	ret = mmc_suspend_host(host->mmc);
 	if (ret)
 		return ret;
+	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, 0);

 	free_irq(host->irq, host);

-- 
1.7.0.4
