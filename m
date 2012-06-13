From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2] mmc: tmio: Don't access hardware registers after
 stopping clocks
Date: Wed, 13 Jun 2012 15:27:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206131527080.17854@axis700.grange>
References: <1339536575-6578-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1339536575-6578-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 12 Jun 2012, Laurent Pinchart wrote:

> The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> width. When the mmc core requests the driver to power off the card, we
> inform runtime PM, that the controller can be suspended. This can lead
> to the MSTP clock being turned off.
> 
> Writing to any 16-bit hardware registers with the MSTP clock off leads
> to timeouts and errors being printed to the kernel log. This can occur
> both when stopping the MMC clock and when configuring the bus width.
> 
> To fix this, stop the MMC clock before calling put_runtime_pm(), and
> skip bus width configuration when power is off.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
>  drivers/mmc/host/tmio_mmc_pio.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 9a7996a..53d1de6 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -810,19 +810,21 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		if (host->set_pwr && ios->power_mode == MMC_POWER_OFF)
>  			host->set_pwr(host->pdev, 0);
>  		if (host->power) {
> +			tmio_mmc_clk_stop(host);
>  			host->power = false;
>  			pm_runtime_put(dev);
>  		}
> -		tmio_mmc_clk_stop(host);
>  	}
>  
> -	switch (ios->bus_width) {
> -	case MMC_BUS_WIDTH_1:
> -		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
> -	break;
> -	case MMC_BUS_WIDTH_4:
> -		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
> -	break;
> +	if (host->power) {
> +		switch (ios->bus_width) {
> +		case MMC_BUS_WIDTH_1:
> +			sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
> +		break;
> +		case MMC_BUS_WIDTH_4:
> +			sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
> +		break;
> +		}
>  	}
>  
>  	/* Let things settle. delay taken from winCE driver */
> -- 
> Regards,
> 
> Laurent Pinchart
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
