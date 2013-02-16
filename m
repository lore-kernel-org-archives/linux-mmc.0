From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: FW: [PATCH v2] mmc: host: sdhci: Fix parameter of sdhci_do_start_signal_voltage_switch()
Date: Sat, 16 Feb 2013 12:22:06 +0800
Message-ID: <CADz5_gLDcVNdG+hisNDinKXmjJsNn=bnqdL47C_t4BpDfDDZsg@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDE525A28@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39094 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab3BPEWH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Feb 2013 23:22:07 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so4236024obc.19
        for <linux-mmc@vger.kernel.org>; Fri, 15 Feb 2013 20:22:06 -0800 (PST)
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C0BDE525A28@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

> -----Original Message-----
> From: Fabio Estevam [mailto:fabio.estevam@freescale.com]
> Sent: Thursday, February 14, 2013 8:35 PM
> To: cjb@laptop.org
> Cc: Kevin Liu; linux-mmc@vger.kernel.org; ulf.hansson@linaro.org; Fabio Estevam
> Subject: [PATCH v2] mmc: host: sdhci: Fix parameter of sdhci_do_start_signal_voltage_switch()
>
> Commit 3714f4315354 (mmc: sdhci: update signal voltage switch code) changed the
> type of the second parameter of sdhci_do_start_signal_voltage_switch(), from
> "struct mmc_ios *ios" to "int signal_voltage" which causes the following build
> warning:
>
> drivers/mmc/host/sdhci.c:2044:2: warning: initialization from incompatible pointer type [enabled by default]
> drivers/mmc/host/sdhci.c:2044:2: warning: (near initialization for 'sdhci_ops.start_signal_voltage_switch') [enabled by default]
>
> Use the previous type so that it matches the start_signal_voltage_switch()
> definition from host.h.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Fix it inside sdhci to avoid breakage on other mmc controllers
>
>  drivers/mmc/host/sdhci.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 735526b..51bbba4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1675,7 +1675,7 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  }
>
>  static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
> -                                               int signal_voltage)
> +                                               struct mmc_ios *ios)
>  {
>         u16 ctrl;
>         int ret;
> @@ -1689,7 +1689,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>
>         ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>
> -       switch (signal_voltage) {
> +       switch (ios->signal_voltage) {
>         case MMC_SIGNAL_VOLTAGE_330:
>                 /* Set 1.8V Signal Enable in the Host Control2 register to 0 */
>                 ctrl &= ~SDHCI_CTRL_VDD_180;
> @@ -1762,7 +1762,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>  }
>
>  static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> -       int signal_voltage)
> +       struct mmc_ios *ios)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
>         int err;
> @@ -1770,7 +1770,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>         if (host->version < SDHCI_SPEC_300)
>                 return 0;
>         sdhci_runtime_pm_get(host);
> -       err = sdhci_do_start_signal_voltage_switch(host, signal_voltage);
> +       err = sdhci_do_start_signal_voltage_switch(host, ios);
>         sdhci_runtime_pm_put(host);
>         return err;
>  }

Fabio,

Thanks a lot for finding this and quick fix!
My original purpose is to change the argument type from ios to
signal_voltage. But the code change for mmc core was not integrated
into Johan's final patchset ([PATCH v6 5/5] mmc: core: Fixup signal
voltage switch).
So I still prefer your first version. I submit below patch for this just now:
"[PATCH] mmc: core: update start_signal_voltage_switch argument type"
Please help to reivew and can I add your name to the signoff?

Chris,

Can I suggest to combine my above patch with Fabio's patch? I think
they are related.

Thanks
Kevin
