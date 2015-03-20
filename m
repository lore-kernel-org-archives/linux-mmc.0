From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] Revert "mmc: sdhci-esdhc-imx: Call mmc_of_parse()"
Date: Fri, 20 Mar 2015 10:24:45 +0100
Message-ID: <CAPDyKFqVDsNTfPAL12vK_-We_prwD_f7DW1DADCLkTmthx0=4g@mail.gmail.com>
References: <1426802354-3272-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34690 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbCTJYp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Mar 2015 05:24:45 -0400
Received: by qgh62 with SMTP id 62so87727488qgh.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2015 02:24:45 -0700 (PDT)
In-Reply-To: <1426802354-3272-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 19 March 2015 at 22:59, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Commit 46a3b345d38518 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()") caused
> regression on some mx6q platforms:
>
> [    1.478666] sdhci: Secure Digital Host Controller Interface driver
> [    1.484912] sdhci: Copyright(c) Pierre Ossman
> [    1.489333] sdhci-pltfm: SDHCI platform and OF driver helper
> [    1.496441] sdhci-esdhc-imx 2194000.usdhc: could not get ultra high speed state, work on normal mode
> [    1.505878] sdhci-esdhc-imx: probe of 2194000.usdhc failed with error -16
>
> Reported-by: Olof's autobooter <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Olof, Fabio,

Thanks for looking into this.

Since I rebase my branch quite frequently, I preferred to just drop
the original patch instead of applying the revert. So that done now!

Kind regards
Uffe

> ---
> I don't have hardware access at the moment to debug this issue, so reverting it
> for now.
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 631e136..9cce5cf 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1075,11 +1075,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                 host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>         }
>
> -       /* call to generic mmc_of_parse to support additional capabilities */
> -       err = mmc_of_parse(host->mmc);
> -       if (err)
> -               goto disable_clk;
> -
>         err = sdhci_add_host(host);
>         if (err)
>                 goto disable_clk;
> --
> 1.9.1
>
