From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: [PATCH 1/4] mmc: sdhci: add a voltage switch callback function
Date: Fri, 21 Nov 2014 08:51:37 +0800
Message-ID: <1416531100-26707-2-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:40385 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487AbaKUAw6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 19:52:58 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so3664538pab.34
        for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2014 16:52:58 -0800 (PST)
In-Reply-To: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
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
index ada1a3e..66ad318 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1790,6 +1790,10 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
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
index 31896a7..b6080ac 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -296,6 +296,7 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
+	void	(*voltage_switch)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.9.0

