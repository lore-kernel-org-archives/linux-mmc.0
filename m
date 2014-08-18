From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] sdhci : recompute timeout_clk when needed
Date: Mon, 18 Aug 2014 13:15:00 +0200
Message-ID: <CAPDyKFp2mDmyTZLjRa5R14XsnmhWtGKbpUcaWwittPy20um-6Q@mail.gmail.com>
References: <1408024998-4097-1-git-send-email-matthieu.castet@parrot.com>
	<1408024998-4097-2-git-send-email-matthieu.castet@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:39329 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaHRLPC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 07:15:02 -0400
Received: by mail-qa0-f49.google.com with SMTP id dc16so4229841qab.22
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2014 04:15:01 -0700 (PDT)
In-Reply-To: <1408024998-4097-2-git-send-email-matthieu.castet@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 14 August 2014 16:03, Matthieu CASTET <matthieu.castet@parrot.com> wrote:
> when SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is set, timeout_clk is sdclk.
> We need to update it when we change sdclk in sdhci_set_clock.
> This allow to have a more precisse timeout and max_busy_timeout. This
> can help for command that need a big busy wait (erase, ...).
>
> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>

Thanks! Applied for next.

This one didn't pass checkpatch, but I fixed it this time.

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9df59a4..76b1aab 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1192,8 +1192,13 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>         }
>
>  clock_set:
> -       if (real_div)
> +       if (real_div) {
>                 host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
> +               if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) {
> +                       host->timeout_clk = host->mmc->actual_clock / 1000;
> +                       host->mmc->max_busy_timeout = (1 << 27) / host->timeout_clk;
> +               }
> +       }
>
>         clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>         clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
> --
> 2.1.0.rc1
>
