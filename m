From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: highspeed:  check for mmc as well as sd cards
Date: Fri, 8 Oct 2010 00:52:54 +0100
Message-ID: <20101007235254.GA15409@void.printf.net>
References: <41A82D88-6200-469C-986D-EF46B0C6A773@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53536 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680Ab0JGXw4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Oct 2010 19:52:56 -0400
Content-Disposition: inline
In-Reply-To: <41A82D88-6200-469C-986D-EF46B0C6A773@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Philip,

On Wed, Oct 06, 2010 at 11:57:23AM -0700, Philip Rakity wrote:
> 
> when examining the code in the mmc directory the SD and MMC code
> set highspeed using a different constant.  Change the sd driver
> to recognize this and switch to high speed.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d3f924b..1d3f4d8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1194,8 +1194,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	else
>  		ctrl &= ~SDHCI_CTRL_4BITBUS;
>  
> -	if (ios->timing == MMC_TIMING_SD_HS &&
> -	    !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
> +	if ((ios->timing == MMC_TIMING_SD_HS
> +			|| ios->timing == MMC_TIMING_MMC_HS)
> +		&& !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
>  		ctrl |= SDHCI_CTRL_HISPD;
>  	else
>  		ctrl &= ~SDHCI_CTRL_HISPD;
> -- 

Thanks, applied to mmc-next.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
