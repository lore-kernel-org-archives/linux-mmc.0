From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/3] mmc: parse new binding for eMMC fixed driver type
Date: Thu, 5 Oct 2017 11:27:06 +0200
Message-ID: <CAPDyKFptoNbNGbUUcjka778P7X9FBNMsa6GUe=1_voYfzj8uEg@mail.gmail.com>
References: <20171004173920.15232-1-wsa+renesas@sang-engineering.com> <20171004173920.15232-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:49144 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdJEJ1H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Oct 2017 05:27:07 -0400
Received: by mail-io0-f176.google.com with SMTP id f72so6407900ioj.5
        for <linux-mmc@vger.kernel.org>; Thu, 05 Oct 2017 02:27:07 -0700 (PDT)
In-Reply-To: <20171004173920.15232-3-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Adrian Hunter <adrian.hunter@intel.com>, Marek Vasut <marek.vasut@gmail.com>

On 4 October 2017 at 19:39, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Parse the new binding and store it in the host struct after doing some
> sanity checks. The code is designed to support fixed SD driver type if
> we ever need that.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Changes since RFC v1:
> * rebased to mmc/next based on 4.14-rc3
>
>  drivers/mmc/core/core.c  | 28 +++++++++++++++++++++++-----
>  drivers/mmc/core/host.c  | 11 ++++++++++-
>  include/linux/mmc/host.h |  2 ++
>  3 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c287d297710aa4..64b454efc924c5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1785,6 +1785,18 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
>         mmc_set_ios(host);
>  }
>
> +static int mmc_select_fixed_drive_strength(struct mmc_card *card,
> +                                      unsigned int max_dtr, int host_drv,
> +                                      int card_drv, int *drv_type)
> +{
> +       int ret = 0, preset = card->host->fixed_drv_type;
> +
> +       if (card->type == MMC_TYPE_MMC)
> +               ret = card_drv & mmc_driver_type_mask(preset) ? preset : 0;
> +
> +       return ret;
> +}

After a second thought, I would rather prefer to have this code
implemented in mmc.c, in mmc_select_driver_type(). If we later find a
case for SD/SDIO, we can consider to move this to core.c.

Moreover, I think when host->fixed_drv_type has a value set, using
that value should take precedence over calling
mmc_select_drive_strength(). That is not the case below.

Sorry for not realizing this in v1.

> +
>  int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
>                               int card_drv_type, int *drv_type)
>  {
> @@ -1793,7 +1805,7 @@ int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
>
>         *drv_type = 0;
>
> -       if (!host->ops->select_drive_strength)
> +       if (!host->ops->select_drive_strength && !host->fixed_drv_type)
>                 return 0;
>
>         /* Use SD definition of driver strength for hosts */
> @@ -1812,10 +1824,16 @@ int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
>          * information and let the hardware specific code
>          * return what is possible given the options
>          */
> -       return host->ops->select_drive_strength(card, max_dtr,
> -                                               host_drv_type,
> -                                               card_drv_type,
> -                                               drv_type);
> +       if (host->ops->select_drive_strength)
> +               return host->ops->select_drive_strength(card, max_dtr,
> +                                                       host_drv_type,
> +                                                       card_drv_type,
> +                                                       drv_type);
> +       else
> +               return mmc_select_fixed_drive_strength(card, max_dtr,
> +                                                       host_drv_type,
> +                                                       card_drv_type,
> +                                                       drv_type);
>  }

[...]

Kind regards
Uffe
