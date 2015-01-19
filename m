From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [PATCH v4 1/4] mmc: sdhci: add a voltage switch callback function
Date: Mon, 19 Jan 2015 18:48:26 +0800
Message-ID: <1421664509-1807-2-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1421664509-1807-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:47530 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbbASKtc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jan 2015 05:49:32 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb1so3682018pad.10
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2015 02:49:32 -0800 (PST)
In-Reply-To: <1421664509-1807-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux@arm.linux.org.uk, chris@printf.net, ulf.hansson@linaro.org, andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, Vincent Yang <Vincent.Yang@tw.fujitsu.com>

This patch adds a callback function to do
controller-specific actions when switching voltages.
It is a preparation and will be used by Fujitsu
SDHCI controller f_sdh30 driver.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f1a488e..144b561 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1832,6 +1832,10 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 		ctrl |= SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
+		/* Some controller need to do more when switching */
+		if (host->ops->voltage_switch)
+			host->ops->voltage_switch(host);
+
 		/* 1.8V regulator output should be stable within 5 ms */
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (ctrl & SDHCI_CTRL_VDD_180)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 41a2c34..0315e18 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -339,6 +339,7 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
+	void	(*voltage_switch)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.9.0

