From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/13] mmc: core: Simplify by adding mmc_execute_tuning()
Date: Tue, 13 Jan 2015 12:19:55 +0100
Message-ID: <CAPDyKFpA30z-D2qqYsvNCcepaDtr=MgNcTQ8t04wS7Qg_AA3jA@mail.gmail.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
	<1417801271-15575-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:35346 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbbAMLT4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 06:19:56 -0500
Received: by mail-qa0-f45.google.com with SMTP id n8so1565058qaq.4
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jan 2015 03:19:55 -0800 (PST)
In-Reply-To: <1417801271-15575-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 5 December 2014 at 18:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
> For each MMC, SD and SDIO there is code that
> holds the clock, calls ops->execute_tuning, and
> releases the clock. Simplify the code a bit by
> providing a separate function to do that.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 24 ++++++++++++++++++++++++
>  drivers/mmc/core/core.h |  3 +++
>  drivers/mmc/core/mmc.c  | 14 +-------------
>  drivers/mmc/core/sd.c   | 13 ++++---------
>  drivers/mmc/core/sdio.c | 14 ++++----------
>  5 files changed, 36 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 9584bff..b329725 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1077,6 +1077,30 @@ void mmc_set_ungated(struct mmc_host *host)
>  }
>  #endif
>
> +int mmc_execute_tuning(struct mmc_card *card)
> +{
> +       struct mmc_host *host = card->host;
> +       u32 opcode;
> +       int err;
> +
> +       if (!host->ops->execute_tuning)
> +               return 0;
> +
> +       if (mmc_card_mmc(card))
> +               opcode = MMC_SEND_TUNING_BLOCK_HS200;
> +       else
> +               opcode = MMC_SEND_TUNING_BLOCK;
> +
> +       mmc_host_clk_hold(host);
> +       err = host->ops->execute_tuning(host, opcode);
> +       mmc_host_clk_release(host);
> +
> +       if (err)
> +               pr_err("%s: tuning execution failed\n", mmc_hostname(host));
> +
> +       return err;
> +}
> +
>  /*
>   * Change the bus mode (open drain/push-pull) of a host.
>   */
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index d76597c..1b022c9 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -82,5 +82,8 @@ void mmc_add_card_debugfs(struct mmc_card *card);
>  void mmc_remove_card_debugfs(struct mmc_card *card);
>
>  void mmc_init_context_info(struct mmc_host *host);
> +
> +int mmc_execute_tuning(struct mmc_card *card);
> +
>  #endif
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 02ad792..c712ba7 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1194,7 +1194,6 @@ EXPORT_SYMBOL(tuning_blk_pattern_8bit);
>  static int mmc_hs200_tuning(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> -       int err = 0;
>
>         /*
>          * Timing should be adjusted to the HS400 target
> @@ -1205,18 +1204,7 @@ static int mmc_hs200_tuning(struct mmc_card *card)
>                 if (host->ops->prepare_hs400_tuning)
>                         host->ops->prepare_hs400_tuning(host, &host->ios);
>
> -       if (host->ops->execute_tuning) {
> -               mmc_host_clk_hold(host);
> -               err = host->ops->execute_tuning(host,
> -                               MMC_SEND_TUNING_BLOCK_HS200);
> -               mmc_host_clk_release(host);
> -
> -               if (err)
> -                       pr_err("%s: tuning execution failed\n",
> -                               mmc_hostname(host));
> -       }
> -
> -       return err;
> +       return mmc_execute_tuning(card);
>  }
>
>  /*
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index d90a6de..7907544 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -660,15 +660,10 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>          * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
>          * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
>          */
> -       if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning &&
> -                       (card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
> -                        card->sd_bus_speed == UHS_SDR104_BUS_SPEED)) {
> -               mmc_host_clk_hold(card->host);
> -               err = card->host->ops->execute_tuning(card->host,
> -                                                     MMC_SEND_TUNING_BLOCK);
> -               mmc_host_clk_release(card->host);
> -       }
> -
> +       if (!mmc_host_is_spi(card->host) &&
> +           (card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
> +            card->sd_bus_speed == UHS_SDR104_BUS_SPEED))
> +               err = mmc_execute_tuning(card);
>  out:
>         kfree(status);
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index fd0750b..ce6cc47 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -567,17 +567,11 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
>          * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
>          * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
>          */
> -       if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning &&
> -                       ((card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50) ||
> -                        (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104))) {
> -               mmc_host_clk_hold(card->host);
> -               err = card->host->ops->execute_tuning(card->host,
> -                                                     MMC_SEND_TUNING_BLOCK);
> -               mmc_host_clk_release(card->host);
> -       }
> -
> +       if (!mmc_host_is_spi(card->host) &&
> +           ((card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50) ||
> +            (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104)))
> +               err = mmc_execute_tuning(card);
>  out:
> -
>         return err;
>  }
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
