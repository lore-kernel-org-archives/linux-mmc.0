From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 1/3] mmc: core: Remove some redundant validations in
 mmc_erase() function
Date: Tue, 6 Sep 2016 14:17:43 +0200
Message-ID: <CAPDyKFotQk5XYU1WkTJruWfrRy=Td2ARNdbSj5-2fQBOx9dUsg@mail.gmail.com>
References: <2b6b5b930d0f37a219d5786a6b56b17516a90abd.1473130123.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35896 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755737AbcIFMRp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2016 08:17:45 -0400
Received: by mail-wm0-f49.google.com with SMTP id b187so60983855wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 06 Sep 2016 05:17:45 -0700 (PDT)
In-Reply-To: <2b6b5b930d0f37a219d5786a6b56b17516a90abd.1473130123.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, David Jander <david@protonic.nl>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On 6 September 2016 at 04:55, Baolin Wang <baolin.wang@linaro.org> wrote:
> Before issuing mmc_erase() function, users always have checked if it can
> erase with mmc_can_erase/trim/discard() function, thus remove the redundant
> erase checking in mmc_erase() function.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> Changes since v3:
>  - Split into 3 separate patches.
>  - Add test tag by Shawn.
>
> Changes since v2:
>  - Add nr checking and other optimization in mmc_erase() function.
>
> Changes since v1:
>  - Add the alignment if card->erase_size is not power of 2.
> ---
>  drivers/mmc/core/core.c |    7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e55cde6..7d7209d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2217,13 +2217,6 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>         unsigned int rem, to = from + nr;
>         int err;
>
> -       if (!(card->host->caps & MMC_CAP_ERASE) ||
> -           !(card->csd.cmdclass & CCC_ERASE))
> -               return -EOPNOTSUPP;
> -
> -       if (!card->erase_size)
> -               return -EOPNOTSUPP;
> -

Could we postpone this until after a clean-up-series of the mmc erase functions?

Until the function remains an exported API, I think it should keep
doing this validations.

>         if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
>                 return -EOPNOTSUPP;
>
> --
> 1.7.9.5
>

Kind regards
Uffe
