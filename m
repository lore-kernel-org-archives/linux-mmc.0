From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v2, 1/8] mmc: sdhci: add a callback of signal voltage switching
Date: Fri, 16 Oct 2015 15:18:57 +0200
Message-ID: <CAPDyKFrKYUr5yqYYHQ+KJBG8Wnn4k+JJgRo+kWwznbU4Ts4pBA@mail.gmail.com>
References: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37805 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbbJPNS6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 09:18:58 -0400
Received: by wijq8 with SMTP id q8so10503719wij.0
        for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2015 06:18:57 -0700 (PDT)
In-Reply-To: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 17 September 2015 at 07:50, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> Add a signal voltage switching callback to let host use its own
> switching process.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>

Sorry for the delay!

Unless you haven't noticed my recent statement around sdhci's
callbacks and quirks, please read these.
https://lkml.org/lkml/2015/10/8/734
https://lkml.org/lkml/2015/10/6/158

That said, I won't pick any of the patches from these patchset.

I would also encourage you and other people to help turning shdci into
a bunch of library functions.

Kind regards
Uffe

> ---
> Changes for v2:
>         - Modified commit message
>         - Added SDR50 support patches
> ---
>  drivers/mmc/host/sdhci.c | 5 +++++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 64b7fdb..9b3d4c2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1757,6 +1757,11 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>         if (host->version < SDHCI_SPEC_300)
>                 return 0;
>
> +       if (host->ops->signal_voltage_switch) {
> +               host->ops->signal_voltage_switch(host, ios->signal_voltage);
> +               return 0;
> +       }
> +
>         ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>
>         switch (ios->signal_voltage) {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 7c02ff4..723f034 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -544,6 +544,8 @@ struct sdhci_ops {
>                                          struct mmc_card *card,
>                                          unsigned int max_dtr, int host_drv,
>                                          int card_drv, int *drv_type);
> +       void    (*signal_voltage_switch)(struct sdhci_host *host,
> +                                        unsigned char signal_voltage);
>  };
>
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> --
> 2.1.0.27.g96db324
>
