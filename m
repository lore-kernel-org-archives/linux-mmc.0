From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 1/2] mmc: sdhci: add quirk SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST
Date: Thu, 17 Sep 2015 10:16:19 +0200
Message-ID: <1442477780-30994-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:19923 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbbIQIQV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Sep 2015 04:16:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, Ludovic Desroches <ludovic.desroches@atmel.com>

The Atmel sdhci device needs a new quirk. sdhci_set_clock set the Clock
Control Register to 0 before computing the new value and writing it.
It disables the internal clock which causes a reset mecanism. If we
write the new value before this reset mecanism is done, it will prevent
the stabilisation of the internal clock, so a delay is needed. This
delay is about 2-3 cycles of the base clock. To be safe, a 1 ms delay is
used.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
Hi Ulf,

Can you take these patches as fixes? I thought it was better to introduce a
quirk instead of duplicating a part of the sdhci_set_clock function to
implement my own set_clock function.

Regards


 drivers/mmc/host/sdhci.c | 2 ++
 drivers/mmc/host/sdhci.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 64b7fdb..fbc7efd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1160,6 +1160,8 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	host->mmc->actual_clock = 0;
 
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
+		mdelay(1);
 
 	if (clock == 0)
 		return;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7c02ff4..9d4aa31 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -412,6 +412,11 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/*
+ * When internal clock is disabled, a delay is needed before modifying the
+ * SD clock frequency or enabling back the internal clock.
+ */
+#define SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST	(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.5.0

