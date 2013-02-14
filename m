From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Fix start_signal_voltage_switch argument type
Date: Thu, 14 Feb 2013 11:33:18 +0100
Message-ID: <CAPDyKFpKTA=Sqsyz_nB+kvBzdbRckVCCNDUGRaWdYVYxcoqk4w@mail.gmail.com>
References: <1360808084-9128-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:46887 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750Ab3BNKdW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Feb 2013 05:33:22 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so2132303lab.37
        for <linux-mmc@vger.kernel.org>; Thu, 14 Feb 2013 02:33:19 -0800 (PST)
In-Reply-To: <1360808084-9128-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: cjb@laptop.org, kliu5@marvell.com, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On 14 February 2013 03:14, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Since commit 3714f4315354 (mmc: sdhci: update signal voltage switch code) the
> second argument of start_signal_voltage_switch has 'int signal_voltage' type,
> so update mmc core and the mmc host struct definition accordingly.
>
> Fix the following build warning:
>
> drivers/mmc/host/sdhci.c:2044:2: warning: initialization from incompatible pointer type [enabled by default]
> drivers/mmc/host/sdhci.c:2044:2: warning: (near initialization for 'sdhci_ops.start_signal_voltage_switch') [enabled by default]
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/mmc/core/core.c  |    2 +-
>  include/linux/mmc/host.h |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 08a3cf2..c346bc7 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1325,7 +1325,7 @@ int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
>         host->ios.signal_voltage = signal_voltage;
>         if (host->ops->start_signal_voltage_switch) {
>                 mmc_host_clk_hold(host);
> -               err = host->ops->start_signal_voltage_switch(host, &host->ios);
> +               err = host->ops->start_signal_voltage_switch(host, signal_voltage);

No. Fixup shall be done in SDHCI instead. Otherwise other host drivers
will break instead.

>                 mmc_host_clk_release(host);
>         }
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index fd5fd5a..ad8b1a6 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -129,7 +129,8 @@ struct mmc_host_ops {
>         /* optional callback for HC quirks */
>         void    (*init_card)(struct mmc_host *host, struct mmc_card *card);
>
> -       int     (*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
> +       int     (*start_signal_voltage_switch)(struct mmc_host *host,
> +                                                       int signal_voltage);
>
>         /* Check if the card is pulling dat[0:3] low */
>         int     (*card_busy)(struct mmc_host *host);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson
