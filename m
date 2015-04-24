From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] mmc: sdhci_f_sdh30: Staticize local functions
Date: Fri, 24 Apr 2015 15:00:29 +0800
Message-ID: <1429858829.18906.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36112 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbbDXHAe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Apr 2015 03:00:34 -0400
Received: by pdea3 with SMTP id a3so40805532pde.3
        for <linux-mmc@vger.kernel.org>; Fri, 24 Apr 2015 00:00:34 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andy Green <andy.green@linaro.org>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Make local functions static.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 2fe8b91..5397e27 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -49,7 +49,7 @@ struct f_sdhost_priv {
 	struct device *dev;
 };
 
-void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
+static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
 {
 	struct f_sdhost_priv *priv = sdhci_priv(host);
 	u32 ctrl = 0;
@@ -77,12 +77,12 @@ void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
 	sdhci_writel(host, ctrl, F_SDH30_TUNING_SETTING);
 }
 
-unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
+static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
 {
 	return F_SDH30_MIN_CLOCK;
 }
 
-void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
+static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
 {
 	if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
 		sdhci_writew(host, 0xBC01, SDHCI_CLOCK_CONTROL);
-- 
2.1.0



