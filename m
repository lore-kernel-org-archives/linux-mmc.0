From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] sdhci-of-esdhc: Pre divider starts at 1
Date: Tue, 5 May 2015 10:34:19 +0200
Message-ID: <CAPDyKFpZU9rNqC5DTe_eoMKZaRrZ+Q+tS9bvXRMbXqekDFQxdg@mail.gmail.com>
References: <1429564333-30474-1-git-send-email-joakim.tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34708 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782AbbEEIeU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 04:34:20 -0400
Received: by qkgx75 with SMTP id x75so101205013qkg.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 01:34:20 -0700 (PDT)
In-Reply-To: <1429564333-30474-1-git-send-email-joakim.tjernlund@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 20 April 2015 at 23:12, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
> For PowerPC esdhc pre divider starts at 1, fixing the increases
> the actual clock from 40KHz to 50 KHz.
>
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>

Thanks, applied.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 7130130..ffd5625 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -207,7 +207,7 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
>
>  static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
> -       int pre_div = 2;
> +       int pre_div = 1;
>         int div = 1;
>         u32 temp;
>
> @@ -237,7 +237,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>
>         dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
>                 clock, host->max_clk / pre_div / div);
> -
> +       host->mmc->actual_clock = host->max_clk / pre_div / div;
>         pre_div >>= 1;
>         div--;
>
> --
> 2.0.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
