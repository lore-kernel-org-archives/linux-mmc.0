From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 2/4] sdhci: add quirk for broken sdio irq
Date: Tue, 14 Dec 2010 22:49:34 -0600
Message-ID: <1292388576-25600-3-git-send-email-olof@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:38596 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab0LOE5b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Dec 2010 23:57:31 -0500
In-Reply-To: <1292388576-25600-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Olof Johansson <olof@lixom.net>

Some controllers can't handle SDIO IRQ properly. Give a way to
disable it.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/mmc/host/sdhci.c  |    6 +++++-
 include/linux/mmc/sdhci.h |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c0094c1..98f3d3d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1871,7 +1871,10 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
 
 	mmc->f_max = host->max_clk;
-	mmc->caps |= MMC_CAP_SDIO_IRQ;
+	mmc->caps = 0;
+
+	if (!(host->quirks & SDHCI_QUIRK_NO_SDIO_IRQ))
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
 
 	/*
 	 * A controller may support 8-bit width, but the board itself
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index dfb2106..97d547e 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -85,6 +85,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
 /* Controller treats ADMA descriptors with length 0000h incorrectly */
 #define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
+/* Controller should not use SDIO IRQ */
+#define SDHCI_QUIRK_NO_SDIO_IRQ				(1<<31)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.3.GIT

