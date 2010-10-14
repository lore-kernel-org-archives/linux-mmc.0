From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: refine DDR support
Date: Thu, 14 Oct 2010 03:03:12 +0100
Message-ID: <20101014020312.GB3553@void.printf.net>
References: <20101011094342.27911.94016.sendpatchset@ahunter-work.research.nokia.com> <20101011094350.27911.9006.sendpatchset@ahunter-work.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38612 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754005Ab0JNCDN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Oct 2010 22:03:13 -0400
Content-Disposition: inline
In-Reply-To: <20101011094350.27911.9006.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>

Hi Adrian,

On Mon, Oct 11, 2010 at 12:43:50PM +0300, Adrian Hunter wrote:
> >From f92528a3ebbff6e3f73fc2cb0d197ece9180324e Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Mon, 11 Oct 2010 12:30:25 +0300
> Subject: [PATCH] mmc: refine DDR support
> 
> One flaw with DDR support is that MMC core does
> not inform the driver which DDR mode it has
> selected.  This patch expands the ios->ddr flag
> to do that.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
>  drivers/mmc/core/core.c  |    7 ++++---
>  drivers/mmc/core/core.h  |    3 ++-
>  drivers/mmc/core/mmc.c   |    6 +++---
>  include/linux/mmc/host.h |    3 ++-
>  4 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c94565d..ce5f4a5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -653,10 +653,11 @@ void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode)
>  /*
>   * Change data bus width and DDR mode of a host.
>   */
> -void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width, int ddr)
> +void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
> +			   unsigned int ddr)
>  {
>  	host->ios.bus_width = width;
> -	host->ios.ddr = ddr ? MMC_DDR_MODE : MMC_SDR_MODE;
> +	host->ios.ddr = ddr;
>  	mmc_set_ios(host);
>  }
>  
> @@ -665,7 +666,7 @@ void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width, int ddr)
>   */
>  void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
>  {
> -	mmc_set_bus_width_ddr(host, width, 0);
> +	mmc_set_bus_width_ddr(host, width, MMC_SDR_MODE);
>  }
>  
>  /**
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 90e0ac7..77240cd 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -35,7 +35,8 @@ void mmc_set_chip_select(struct mmc_host *host, int mode);
>  void mmc_set_clock(struct mmc_host *host, unsigned int hz);
>  void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
>  void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
> -void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width, int ddr);
> +void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
> +			   unsigned int ddr);
>  u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
>  void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>  
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 31a8bbe..995261f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -375,7 +375,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	struct mmc_card *oldcard)
>  {
>  	struct mmc_card *card;
> -	int err, ddr = 0;
> +	int err, ddr = MMC_SDR_MODE;
>  	u32 cid[4];
>  	unsigned int max_dtr;
>  
> @@ -523,10 +523,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	if (mmc_card_highspeed(card)) {
>  		if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
>  			&& (host->caps & (MMC_CAP_1_8V_DDR)))
> -				ddr = 1;
> +				ddr = MMC_1_8V_DDR_MODE;
>  		else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
>  			&& (host->caps & (MMC_CAP_1_2V_DDR)))
> -				ddr = 1;
> +				ddr = MMC_1_2V_DDR_MODE;
>  	}
>  
>  	/*
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c3ffad8..6d87f68 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -54,7 +54,8 @@ struct mmc_ios {
>  	unsigned char	ddr;			/* dual data rate used */
>  
>  #define MMC_SDR_MODE		0
> -#define MMC_DDR_MODE		1
> +#define MMC_1_2V_DDR_MODE	1
> +#define MMC_1_8V_DDR_MODE	2
>  };
>  
>  struct mmc_host_ops {
> -- 

Thanks, applied to mmc-next.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
