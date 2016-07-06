From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: core: Allow hosts to specify non-support for MMC commands
Date: Wed, 6 Jul 2016 18:21:59 +0200
Message-ID: <CAPDyKFpKMNe0Gb_amtXADjFJZ2AhPqhL3oqgek-rpOUZaKdZeQ@mail.gmail.com>
References: <1467359130-11409-1-git-send-email-shawn.lin@rock-chips.com> <1467359130-11409-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37340 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbcGFQWC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2016 12:22:02 -0400
Received: by mail-wm0-f52.google.com with SMTP id a66so199534939wme.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2016 09:22:01 -0700 (PDT)
In-Reply-To: <1467359130-11409-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 1 July 2016 at 09:45, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Host drivers which needs to valdiate for non-supported MMC
> commands and returnn error code for such requests.
>
> To improve and simplify the behaviour, let's invent MMC_CAP2_NO_MMC
> which these host drivers can set to tell the mmc core to skip sending MMC
> commands during card initialization.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Delaying patch2 and patch3 until I received acks from DT maintainers.

Kind regards
Uffe

>
> ---
>
>  drivers/mmc/core/core.c  | 5 +++--
>  include/linux/mmc/host.h | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 4c823df..94cbf4e 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2510,8 +2510,9 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>                 if (!mmc_attach_sd(host))
>                         return 0;
>
> -       if (!mmc_attach_mmc(host))
> -               return 0;
> +       if (!(host->caps2 & MMC_CAP2_NO_MMC))
> +               if (!mmc_attach_mmc(host))
> +                       return 0;
>
>         mmc_power_off(host);
>         return -EIO;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c22476d..aa4bfbf 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -310,6 +310,7 @@ struct mmc_host {
>  #define MMC_CAP2_NO_SDIO       (1 << 19)       /* Do not send SDIO commands during initialization */
>  #define MMC_CAP2_HS400_ES      (1 << 20)       /* Host supports enhanced strobe */
>  #define MMC_CAP2_NO_SD         (1 << 21)       /* Do not send SD commands during initialization */
> +#define MMC_CAP2_NO_MMC                (1 << 22)       /* Do not send (e)MMC commands during initialization */
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>
> --
> 2.3.7
>
>
