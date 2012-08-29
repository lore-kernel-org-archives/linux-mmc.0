From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Quieten "could not set regulator OCR" error.
Date: Wed, 29 Aug 2012 14:09:17 +0200
Message-ID: <CAPDyKFofwC-t-7vhxjF5PUZKTiqYxZh8Kh6J6cLCTFuDTw1-eQ@mail.gmail.com>
References: <87a9xfyko6.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60675 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab2H2MJT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Aug 2012 08:09:19 -0400
Received: by weyx8 with SMTP id x8so271424wey.19
        for <linux-mmc@vger.kernel.org>; Wed, 29 Aug 2012 05:09:18 -0700 (PDT)
In-Reply-To: <87a9xfyko6.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Chris,

On 28 August 2012 01:33, Chris Ball <cjb@laptop.org> wrote:
> Some distributions build with CONFIG_REGULATOR_DUMMY=y -- this makes
> regulator setup succeed harmlessly, but then trying to set the voltage
> on the dummy regulator will fail as below:
>
> [ 6.413866] sdhci-pci 0000:03:00.0: SDHCI controller found [1180:e822]
> (rev 0)
> [ 6.414081] _regulator_get: 0000:03:00.0 supply vmmc not found, using
> dummy regulator
> [ 6.415252] mmc0: SDHCI controller on PCI [0000:03:00.0] using DMA
> [ 6.415294] sdhci-pci 0000:03:00.0: could not set regulator OCR (-22)
> [ 6.444241] sdhci-pci 0000:03:00.0: could not set regulator OCR (-22)
> [ 6.473648] sdhci-pci 0000:03:00.0: could not set regulator OCR (-22)
> [..]
>
> Since this isn't an error in this case, move the error to pr_debug().
> Reference: https://bugs.archlinux.org/task/29008
>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/core/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 835c9f0..30d9357 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1017,8 +1017,9 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
>         }
>
>         if (result)
> -               dev_err(mmc_dev(mmc),
> -                       "could not set regulator OCR (%d)\n", result);
> +               pr_debug("%s: could not set regulator OCR (%d)\n",
> +                        mmc_hostname(mmc), result);
> +

I am not sure this is the correct solution. Would it be possible
prevent sdhci-* from calling mmc_regulator_set_ocr when it has gotten
a "dummy" regulator some how?

In the other scenarios were we use a real regulator, I would interpret
this error as critical, since the power to the card could not be set
according to the vdd bit.
Of course an option could be to leave the error printing to the caller
of mmc_regulator_set_ocr.. :-)

>         return result;
>  }
>  EXPORT_SYMBOL_GPL(mmc_regulator_set_ocr);
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson
