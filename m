From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 02/15] mmc: core: Enable / disable re-tuning
Date: Tue, 21 Apr 2015 10:59:01 +0200
Message-ID: <CAPDyKFrx+yX2j5U6jrBh8eiN3fo5sDztaLLTeXYu0zbOa32smw@mail.gmail.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
	<1429531796-21987-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35412 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbDUI7C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Apr 2015 04:59:02 -0400
Received: by qkhg7 with SMTP id g7so206237355qkh.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2015 01:59:01 -0700 (PDT)
In-Reply-To: <1429531796-21987-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 20 April 2015 at 14:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Enable re-tuning when tuning is executed and
> disable re-tuning when card is no longer initialized.
>
> In the case of SDIO suspend, the card can keep power.
> In that case, re-tuning need not be disabled, but ensure
> the re-tuning timer is disabled.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c | 4 ++++
>  drivers/mmc/core/sdio.c | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c296bc0..dd43f9b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1109,6 +1109,8 @@ int mmc_execute_tuning(struct mmc_card *card)
>
>         if (err)
>                 pr_err("%s: tuning execution failed\n", mmc_hostname(host));
> +       else
> +               mmc_retune_enable(host);
>
>         return err;
>  }
> @@ -1140,6 +1142,8 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
>   */
>  void mmc_set_initial_state(struct mmc_host *host)
>  {
> +       mmc_retune_disable(host);
> +
>         if (mmc_host_is_spi(host))
>                 host->ios.chip_select = MMC_CS_HIGH;
>         else
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 5bc6c7d..ee7bfd4 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -936,6 +936,8 @@ static int mmc_sdio_suspend(struct mmc_host *host)
>
>         if (!mmc_card_keep_power(host))
>                 mmc_power_off(host);
> +       else
> +               mmc_retune_timer_stop(host);
>

We also need to re-start the timer at the end of mmc_sdio_resume() in
case of mmc_card_keep_power().

>         return 0;
>  }
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Uffe
