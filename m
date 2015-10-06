From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 1/8] mmc: sdhci-pxav3: remove broken clock base quirk for Armada 38x sdhci driver
Date: Tue, 06 Oct 2015 16:43:48 +0200
Message-ID: <87k2r09hwb.fsf@free-electrons.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
	<1444094562-31165-2-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444094562-31165-2-git-send-email-mw@semihalf.com> (Marcin
	Wojtas's message of "Tue, 6 Oct 2015 03:22:35 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, jaz@semihalf.com, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Marcin,
 
 On mar., oct. 06 2015, Marcin Wojtas <mw@semihalf.com> wrote:

> From: Nadav Haklai <nadavh@marvell.com>
>
> shci-pxav3 driver is enabling by default the
> SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN quirk. However this quirk is not
> required for Armada 38x and leads to wrong clock setting in the divider.
>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Cc: <stable@vger.kernel.org> # v4.2

Seems OK.

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 946d37f..976cddd 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -135,6 +135,7 @@ static int armada_38x_quirks(struct platform_device *pdev,
>  	struct sdhci_pxa *pxa = pltfm_host->priv;
>  	struct resource *res;
>  
> +	host->quirks &= ~SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
>  	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  					   "conf-sdio3");
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
