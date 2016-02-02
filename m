From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sanitize 'bus width' in debug output
Date: Tue, 2 Feb 2016 14:11:21 +0100
Message-ID: <CAPDyKFp9dtUbpzdUw4a-JtJm0y3JdTWLSV=jA4CUc3-9Ct2C0Q@mail.gmail.com>
References: <1454056070-6164-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:32991 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbcBBNLW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 08:11:22 -0500
Received: by mail-yk0-f176.google.com with SMTP id z13so81590422ykd.0
        for <linux-mmc@vger.kernel.org>; Tue, 02 Feb 2016 05:11:21 -0800 (PST)
In-Reply-To: <1454056070-6164-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On 29 January 2016 at 09:27, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> The bus width is sometimes the actual bus width, and sometimes indices
> to different arrays encoding the bus width. In my debugging case "2"
> could mean 8-bit as well as 4-bit, which was extremly confusing. Let's
> use the human-readable actual bus width in all places.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 2 +-
>  drivers/mmc/core/mmc.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index f95d41ffc766e5..746de248defced 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1033,7 +1033,7 @@ static inline void mmc_set_ios(struct mmc_host *host)
>                 "width %u timing %u\n",
>                  mmc_hostname(host), ios->clock, ios->bus_mode,
>                  ios->power_mode, ios->chip_select, ios->vdd,
> -                ios->bus_width, ios->timing);
> +                1 << ios->bus_width, ios->timing);
>
>         host->ops->set_ios(host, ios);
>  }
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 07a135bc893057..4dbe3df8024b2c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -945,7 +945,7 @@ static int mmc_select_bus_width(struct mmc_card *card)
>                         break;
>                 } else {
>                         pr_warn("%s: switch to bus width %d failed\n",
> -                               mmc_hostname(host), ext_csd_bits[idx]);
> +                               mmc_hostname(host), 1 << bus_width);
>                 }
>         }
>
> --
> 2.6.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
