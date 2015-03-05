From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [patch] mmc: sdhci-esdhc-imx: silence a false curly braces warning
Date: Thu, 5 Mar 2015 14:48:36 +0100
Message-ID: <CAPDyKFp+sZBhwSWS_SWeBUJebOYMOU_hKTO1jA427Yo6X6GsNg@mail.gmail.com>
References: <20150226203755.GD6820@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20150226203755.GD6820@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chris Ball <chris@printf.net>, Aisheng Dong <b29396@freescale.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 26 February 2015 at 21:37, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Static checkers suggest that probably we intended to put curly braces
> around the writel() to make it part of the else path.  But, I think
> actually the indenting is off and the code works fine as is.
>
> The stray tab was introduced in 0322191e6298 ('mmc: sdhci-esdhc-imx: add
> sd3.0 SDR clock tuning support')
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks!

Kind regards
Uffe


>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 10ef824..9cce5cf 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -416,7 +416,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>                         new_val |= ESDHC_VENDOR_SPEC_FRC_SDCLK_ON;
>                 else
>                         new_val &= ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON;
> -                       writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
> +               writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
>                 return;
>         case SDHCI_HOST_CONTROL2:
>                 new_val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
