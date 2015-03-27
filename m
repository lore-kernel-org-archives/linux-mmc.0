From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [RFC] i.MX25/35/SDHCI: switch off DMA usage
Date: Fri, 27 Mar 2015 19:44:03 +0800
Message-ID: <20150327114400.GA20277@shlinux1.ap.freescale.net>
References: <201503271152.04348.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201503271152.04348.jbe@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Juergen Borleis <jbe@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 27, 2015 at 11:52:04AM +0100, Juergen Borleis wrote:
> DMA and the required overhead on very small data blocks seems an expensive
> operation. Due to erratum ENGCM07207 for i.MX25 and i.MX35 SoCs the
> support for multiblock transfers is disabled which results into a huge
> amount of single 512 byte sector transfers and interrupts. This slows down
> the transmission speed to below 500 kiB/s (even at 50 MHz SD card clock).
> Using PIO instead of DMA to avoid ENGCM07207 happens and re-enabling
> multiblock transfers again improve the transmission capability up to about
> 2.5 MiB/s.
> 
> I'm still not sure if ENGCM07207 is related to DMA only and can not happen
> when PIO is used instead. Someone out there with experience regarding this
> topic?

The errata does not state it's related to DMA only.
http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf
I could double check with our IC guys to confirm it.

Regards
Dong Aisheng

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 10ef8244a239..f5fd569a17c3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -976,8 +976,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  
>  	if (imx_data->socdata->flags & ESDHC_FLAG_ENGCM07207)
>  		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
> -		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
> -			| SDHCI_QUIRK_BROKEN_ADMA;
> +		host->quirks |=
> +			SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_DMA;
>  
>  	/*
>  	 * The imx6q ROM code will change the default watermark level setting
> -- 
> 1.7.10.4
> 
> Juergen
