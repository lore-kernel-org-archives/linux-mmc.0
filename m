From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci-s3c: add platform_8bit_width()
Date: Wed, 12 Jan 2011 02:20:30 +0000
Message-ID: <20110112022030.GA27414@void.printf.net>
References: <4D2CF631.4080402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33837 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756393Ab1ALCUd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 Jan 2011 21:20:33 -0500
Content-Disposition: inline
In-Reply-To: <4D2CF631.4080402@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Ben Dooks <ben-linux@fluff.org>

Hi Jaehoon,

Looks fine, just style corrections:

On Wed, Jan 12, 2011 at 09:30:41AM +0900, Jaehoon Chung wrote:
> This patch is added platform_8bit_width() function in sdhci-s3c.
             ^ adds

> 
> We has 8-bit width support but is not a v3 controller.
     ^ have

> So we need platform_8bit_width() to support 8-bit buswidth.
> 
> Also we need MMC_CAP_8_BIT_DATA, so we added them in platdata.
                                         ^ add it

> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 70cc3d7..4dc7d6d 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -276,10 +276,39 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>  	host->clock = clock;
>  }
>  
> +/*
> + * sdhci_s3c_platform_8bit_width - support 8bit buswidth
> + *
> + * We has 8-bit width support but is not a v3 controller.
         ^ have

> + * So we add  platform_8bit_width() and support 8bit width.
                ^ extra space here
> + **/

> +static int sdhci_s3c_platform_8bit_width(struct sdhci_host *host,
> +		int bus_width)

This will (just) fit on one line.

> +{
> +	u8 ctrl;
> +
> +	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +
> +	if (bus_width == MMC_BUS_WIDTH_8)
> +		ctrl |= SDHCI_CTRL_8BITBUS;
> +	else
> +		ctrl &= ~SDHCI_CTRL_8BITBUS;
> +
> +	if (bus_width == MMC_BUS_WIDTH_4)
> +		ctrl |= SDHCI_CTRL_4BITBUS;
> +	else
> +		ctrl &= ~SDHCI_CTRL_4BITBUS;

You could use a switch statement here.

> +
> +	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +
> +	return 0;
> +}
> +
>  static struct sdhci_ops sdhci_s3c_ops = {
>  	.get_max_clock		= sdhci_s3c_get_max_clk,
>  	.set_clock		= sdhci_s3c_set_clock,
>  	.get_min_clock		= sdhci_s3c_get_min_clock,
> +	.platform_8bit_width	= sdhci_s3c_platform_8bit_width,
>  };
>  
>  static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
> @@ -472,6 +501,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>  		host->mmc->caps = MMC_CAP_NONREMOVABLE;
>  
> +	if (pdata->host_caps)
> +		host->mmc->caps |= pdata->host_caps;
> +
>  	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>  			 SDHCI_QUIRK_32BIT_DMA_SIZE);

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
