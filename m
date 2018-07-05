From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-xenon: mark expected switch fall-through
Date: Thu, 5 Jul 2018 15:09:18 +0200
Message-ID: <CAPDyKFrQEnA4jYH4cVBq1-AFHWKHKuXSh63M1f0XVyi-7h53Rw@mail.gmail.com>
References: <20180703225659.GA14443@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703225659.GA14443@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Hu Ziji <huziji@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 4 July 2018 at 00:56, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Warning level 2 was used: -Wimplicit-fallthrough=2
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index a35804b..c335052 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -526,6 +526,7 @@ static bool xenon_emmc_phy_slow_mode(struct sdhci_host *host,
>                         ret = true;
>                         break;
>                 }
> +               /* else: fall through */
>         default:
>                 reg &= ~XENON_TIMING_ADJUST_SLOW_MODE;
>                 ret = false;
> --
> 2.7.4
>
