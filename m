From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC]  sdhci: 8 bit bus width changes
Date: Fri, 19 Nov 2010 21:40:02 +0000
Message-ID: <20101119214002.GA19272@void.printf.net>
References: <B76798A1-FA3F-4D7D-A22A-52289A4062FB@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36750 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232Ab0KSVkF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Nov 2010 16:40:05 -0500
Content-Disposition: inline
In-Reply-To: <B76798A1-FA3F-4D7D-A22A-52289A4062FB@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Philip,

I'd like to take this patch.  One comment, though: 

On Fri, Oct 01, 2010 at 03:45:50PM -0700, Philip Rakity wrote:
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 73a94fe..ec103c3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1182,17 +1182,31 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	else
>  		sdhci_set_power(host, ios->vdd);
>  
> -	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  
> -	if (ios->bus_width == MMC_BUS_WIDTH_8)
> -		ctrl |= SDHCI_CTRL_8BITBUS;
> -	else
> -		ctrl &= ~SDHCI_CTRL_8BITBUS;
> +	/*
> +	 * use platform_8_bit_width if not v3 controller
> +	 * or if special hw/board specific processing is needed
> +	 */
> +	if (host->ops->platform_8bit_width)
> +		host->ops->platform_8bit_width(host, ios->bus_width);
> +	else {
> +		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +		if (ios->bus_width == MMC_BUS_WIDTH_8) {
> +			ctrl &= ~SDHCI_CTRL_4BITBUS;
> +			if (host->version >= SDHCI_SPEC_300)
> +				ctrl |= SDHCI_CTRL_8BITBUS;
> +		} else {
> +			if (host->version >= SDHCI_SPEC_300)
> +				ctrl &= ~SDHCI_CTRL_8BITBUS;
> +			if (ios->bus_width == MMC_BUS_WIDTH_4)
> +				ctrl |= SDHCI_CTRL_4BITBUS;
> +			else
> +				ctrl &= ~SDHCI_CTRL_4BITBUS;
> +		}
> +		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +	}
>  
> -	if (ios->bus_width == MMC_BUS_WIDTH_4)
> -		ctrl |= SDHCI_CTRL_4BITBUS;
> -	else
> -		ctrl &= ~SDHCI_CTRL_4BITBUS;
> +	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);

I don't see why we should re-read ctrl here, since we've already written
it back to the device at this point, and we don't use it anywhere below
this line.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
