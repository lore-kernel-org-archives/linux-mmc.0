From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: tegra: properly disable card clock
Date: Fri, 4 Mar 2016 10:41:22 +0100
Message-ID: <CAPDyKFoJfNE7HcL3BcbRQpw6uOvQYrD=bEYvgUxjvOaX36o=fA@mail.gmail.com>
References: <1456779385-18996-1-git-send-email-dev@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35588 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759559AbcCDJlY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 04:41:24 -0500
Received: by mail-wm0-f43.google.com with SMTP id l68so26420864wml.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2016 01:41:23 -0800 (PST)
In-Reply-To: <1456779385-18996-1-git-send-email-dev@lynxeye.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 29 February 2016 at 21:56, Lucas Stach <dev@lynxeye.de> wrote:
> The new code to do the clock rate setting externally to the SDMMC
> module has a shortcut to not propagate changes with a 0 rate to
> the CAR by simply bailing out. This breaks proper cutting of the
> card clock. Fix it by directly calling the correct sdhci function.
>
> Fixes: a8e326a911d3 "mmc: tegra: implement module external clock change"
> Signed-off-by: Lucas Stach <dev@lynxeye.de>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 212d51f..46a6bd1 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -194,7 +194,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>         unsigned long host_clk;
>
>         if (!clock)
> -               return;
> +               return sdhci_set_clock(host, clock);;
>
>         host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
>         clk_set_rate(pltfm_host->clk, host_clk);
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
