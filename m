From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [RFC 1/3] mmc: sdhci: pass signal_voltage as an argument to voltage_switch callback
Date: Wed,  2 Sep 2015 01:02:16 +0530
Message-ID: <1441135938-8056-2-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34383 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbbIATfZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Sep 2015 15:35:25 -0400
Received: by padhy1 with SMTP id hy1so5419131pad.1
        for <linux-mmc@vger.kernel.org>; Tue, 01 Sep 2015 12:35:24 -0700 (PDT)
In-Reply-To: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Kevin Liu <kliu5@marvell.com>

In order to do particular voltage specific configuration in
sdhci_ops->voltage_switch() callback function, we need to
pass respective voltage value as well.
So this patch adds an extra argument for signal voltage to the
callback function.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c         | 2 +-
 drivers/mmc/host/sdhci.h         | 2 +-
 drivers/mmc/host/sdhci_f_sdh30.c | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1dbe932..3dd295f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1782,7 +1782,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 
 		/* Some controller need to do more when switching */
 		if (host->ops->voltage_switch)
-			host->ops->voltage_switch(host);
+			host->ops->voltage_switch(host, MMC_SIGNAL_VOLTAGE_180);
 
 		/* 1.8V regulator output should be stable within 5 ms */
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5521d29..9b0e2a8 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -537,7 +537,7 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
-	void	(*voltage_switch)(struct sdhci_host *host);
+	void	(*voltage_switch)(struct sdhci_host *host, u8 signal_voltage);
 	int	(*select_drive_strength)(struct sdhci_host *host,
 					 struct mmc_card *card,
 					 unsigned int max_dtr, int host_drv,
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 983b8b3..7ab1c20 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -49,7 +49,8 @@ struct f_sdhost_priv {
 	struct device *dev;
 };
 
-static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
+static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host,
+						u8 signal_voltage)
 {
 	struct f_sdhost_priv *priv = sdhci_priv(host);
 	u32 ctrl = 0;
-- 
1.9.1

