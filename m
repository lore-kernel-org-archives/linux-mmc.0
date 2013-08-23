From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: core: do power-off with resume failure
Date: Fri, 23 Aug 2013 10:36:37 +0200
Message-ID: <CAPDyKFq2uXxsjMZcKK=u0dNJnw5fXj5L0=Rd=OP=nk41Zadong@mail.gmail.com>
References: <002201ce9e6b$e0b32850$a21978f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:43358 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105Ab3HWIgi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 04:36:38 -0400
Received: by mail-vb0-f49.google.com with SMTP id w16so232037vbb.8
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 01:36:37 -0700 (PDT)
In-Reply-To: <002201ce9e6b$e0b32850$a21978f0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 21 August 2013 14:42, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Currently there is no mmc_power_off() when resume failed.
> Somehow, state from mmc_power_on() will be kept. This change
> makes a pair with its use in case of failure.

Hi Seungwon,

To be safe, we can not power off, even if a resume failures. The
reason is that the bus/card/host is still available for sending
commands to it and those will then likely hang since IP controllers
internal registers is configured for "power off" state.

Instead, we must leave the power off to be handled from the next
rescan work when the card is no longer properly "detected". For
NONREMOVABLE we will instead at error path try to do a
"power_restore_host".

Kind regards
Ulf Hansson


>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/core/mmc.c  |    3 +++
>  drivers/mmc/core/sd.c   |    3 +++
>  drivers/mmc/core/sdio.c |    3 +++
>  3 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6d02012..704a561 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1536,6 +1536,9 @@ static int mmc_resume(struct mmc_host *host)
>         mmc_power_up(host);
>         mmc_select_voltage(host, host->ocr);
>         err = mmc_init_card(host, host->ocr, host->card);
> +       if (err)
> +               mmc_power_off(host);
> +
>         mmc_release_host(host);
>
>         return err;
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 176d125..2690ae1 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1099,6 +1099,9 @@ static int mmc_sd_resume(struct mmc_host *host)
>         mmc_power_up(host);
>         mmc_select_voltage(host, host->ocr);
>         err = mmc_sd_init_card(host, host->ocr, host->card);
> +       if (err)
> +               mmc_power_off(host);
> +
>         mmc_release_host(host);
>
>         return err;
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 80d89cf..8c65669 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1033,6 +1033,9 @@ static int mmc_sdio_resume(struct mmc_host *host)
>                 }
>         }
>
> +       if (err && !mmc_card_keep_power(host))
> +               mmc_power_off(host);
> +
>         host->pm_flags &= ~MMC_PM_KEEP_POWER;
>         return err;
>  }
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
