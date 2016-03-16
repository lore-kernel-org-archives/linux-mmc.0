From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Fix override of timeout clk wrt max_busy_timeout
Date: Wed, 16 Mar 2016 12:37:56 +0100
Message-ID: <CAPDyKFoQQZie_3+iN6t9qXQm--DnN3p8i6oK592jod=FqZskUQ@mail.gmail.com>
References: <1457350435-25025-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34401 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935072AbcCPLiC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 07:38:02 -0400
Received: by mail-wm0-f46.google.com with SMTP id p65so185569314wmp.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 04:38:01 -0700 (PDT)
In-Reply-To: <1457350435-25025-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 7 March 2016 at 12:33, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Normally the timeout clock frequency is read from the capabilities
> register.  It is also possible to set the value prior to calling
> sdhci_add_host() in which case that value will override the
> capabilities register value.  However that was being done after
> calculating max_busy_timeout so that max_busy_timeout was being
> calculated using the wrong value of timeout_clk.
>
> Fix that by moving the override before max_busy_timeout is
> calculated.
>
> The result is that the max_busy_timeout and max_discard
> increase for BSW devices so that, for example, the time for
> mkfs.ext4 on a 64GB eMMC drops from about 1 minute 40 seconds
> to about 20 seconds.
>
> Note, in the future, the capabilities setting will be tidied up
> and this override won't be used anymore.  However this fix is
> needed for stable.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # v3.18+

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 03fbb36580f7..4ae394e9e560 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3016,14 +3016,14 @@ int sdhci_add_host(struct sdhci_host *host)
>                 if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
>                         host->timeout_clk *= 1000;
>
> +               if (override_timeout_clk)
> +                       host->timeout_clk = override_timeout_clk;
> +
>                 mmc->max_busy_timeout = host->ops->get_max_timeout_count ?
>                         host->ops->get_max_timeout_count(host) : 1 << 27;
>                 mmc->max_busy_timeout /= host->timeout_clk;
>         }
>
> -       if (override_timeout_clk)
> -               host->timeout_clk = override_timeout_clk;
> -
>         mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
>         mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
>
> --
> 1.9.1
>
