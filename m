From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: core: Proper signal voltage switch
Date: Tue, 25 Sep 2012 09:25:24 +0200
Message-ID: <CAPDyKFrwQGAW8ApGci7F1Vu6_N-E6=FBDU5uYenY5SOupFBNOQ@mail.gmail.com>
References: <1348556622-2068-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62588 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab2IYHZ0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 03:25:26 -0400
Received: by wgbdr13 with SMTP id dr13so4454477wgb.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Sep 2012 00:25:24 -0700 (PDT)
In-Reply-To: <1348556622-2068-1-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>

Hi Johan,

On 25 September 2012 09:03, Johan Rudholm <johan.rudholm@stericsson.com> wrote:
> When switching SD and SDIO cards from 3.3V to 1.8V signal levels, the
> clock should be gated for 5 ms during the step. Failure by the card to
> switch is indicated by dat0 being pulled low. The host should check for
> this condition and power-cycle the card if failure is indicated.
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> ---
> Changelog v2:
>         - Keep calls to mmc_host_clk_hold / mmc_host_clk_release
> ---
>  drivers/mmc/core/core.c  |   22 ++++++++++++++++++++++
>  include/linux/mmc/host.h |    3 +++
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6612163..dae6744 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1220,6 +1220,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
>  {
>         struct mmc_command cmd = {0};
>         int err = 0;
> +       unsigned char old_voltage = host->ios.signal_voltage;
>
>         BUG_ON(!host);
>
> @@ -1243,8 +1244,29 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, bool cmd11
>         host->ios.signal_voltage = signal_voltage;
>
>         if (host->ops->start_signal_voltage_switch) {
> +               u32 clock = host->ios.clock;
> +
>                 mmc_host_clk_hold(host);
> +               host->ios.clock = 0;
> +               mmc_set_ios(host);
>                 err = host->ops->start_signal_voltage_switch(host, &host->ios);
> +
> +               /* Hold clock for at least 5 ms according to spec */

This also potentially affects eMMC. Is that really what you want?
According to commit msg you will only fixup something for SD and SDIO.

By the way, it seems like some fixes for drivers/mmc/core/sdio.c
should be included in this patch as well? Or do you intend to send
those changes as a separate patch?

> +               mmc_delay(5);
> +               host->ios.clock = clock;
> +               mmc_set_ios(host);
> +
> +               /* Wait for at least 1 ms until we check if card is ready */
> +               mmc_delay(1);
> +
> +               /* Check busy */
> +               if (cmd11 && host->ops->card_busy &&
> +                                               host->ops->card_busy(host)) {
> +                       host->ios.signal_voltage = old_voltage;

Why bother about restoring signal voltage state? Could that not be
handled from upper layer?

> +                       host->ops->start_signal_voltage_switch(host,
> +                                                       &host->ios);
> +                       err = -EAGAIN;
> +               }
>                 mmc_host_clk_release(host);
>         }
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index d5d9bd4..b58641a 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -131,6 +131,9 @@ struct mmc_host_ops {
>
>         int     (*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
>
> +       /* Check if the card is pulling dat0 low */
> +       int     (*card_busy)(struct mmc_host *host);
> +
>         /* The tuning command opcode value is different for SD and eMMC cards */
>         int     (*execute_tuning)(struct mmc_host *host, u32 opcode);
>         void    (*enable_preset_value)(struct mmc_host *host, bool enable);
> --
> 1.7.10
>

Kind regards
Ulf Hansson
