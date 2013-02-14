From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: core: Fix start_signal_voltage_switch argument type
Date: Thu, 14 Feb 2013 09:57:42 -0200
Message-ID: <CAOMZO5DKNmqiYs7wHSB5MktgxwczTrhn3fQA0Frkm=bNbUYUdw@mail.gmail.com>
References: <1360808084-9128-1-git-send-email-festevam@gmail.com>
	<CAPDyKFpKTA=Sqsyz_nB+kvBzdbRckVCCNDUGRaWdYVYxcoqk4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:37412 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934253Ab3BNL5n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Feb 2013 06:57:43 -0500
Received: by mail-vc0-f170.google.com with SMTP id p16so1419047vcq.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Feb 2013 03:57:42 -0800 (PST)
In-Reply-To: <CAPDyKFpKTA=Sqsyz_nB+kvBzdbRckVCCNDUGRaWdYVYxcoqk4w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: cjb@laptop.org, kliu5@marvell.com, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Ulf,

On Thu, Feb 14, 2013 at 8:33 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> No. Fixup shall be done in SDHCI instead. Otherwise other host drivers
> will break instead.

Do you mean like this?

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1675,7 +1675,7 @@ static void sdhci_enable_sdio_irq(struct
mmc_host *mmc, int enable)
 }

 static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
-                                               int signal_voltage)
+                                               struct mmc_ios *ios)
 {
        u16 ctrl;
        int ret;
@@ -1689,7 +1689,7 @@ static int
sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,

        ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);

-       switch (signal_voltage) {
+       switch (ios->signal_voltage) {
        case MMC_SIGNAL_VOLTAGE_330:
                /* Set 1.8V Signal Enable in the Host Control2 register to 0 */
                ctrl &= ~SDHCI_CTRL_VDD_180;
@@ -1762,7 +1762,7 @@ static int
sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 }

 static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
-       int signal_voltage)
+       struct mmc_ios *ios)
 {
        struct sdhci_host *host = mmc_priv(mmc);
        int err;
@@ -1770,7 +1770,7 @@ static int
sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
        if (host->version < SDHCI_SPEC_300)
                return 0;
        sdhci_runtime_pm_get(host);
-       err = sdhci_do_start_signal_voltage_switch(host, signal_voltage);
+       err = sdhci_do_start_signal_voltage_switch(host, ios);
        sdhci_runtime_pm_put(host);
        return err;
 }
