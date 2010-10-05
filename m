From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: adjust sd 3.0 host controller spec clock divider
Date: Tue, 5 Oct 2010 03:34:01 +0100
Message-ID: <20101005023401.GB9044@void.printf.net>
References: <CDD4A6CE-487A-4740-87BA-96EEBF1E8217@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57221 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193Ab0JECeF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 4 Oct 2010 22:34:05 -0400
Content-Disposition: inline
In-Reply-To: <CDD4A6CE-487A-4740-87BA-96EEBF1E8217@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>, Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi David,

On Thu, Sep 30, 2010 at 08:03:14PM -0700, Philip Rakity wrote:
> From: Philip Rakity <prakity@marvell.com>
> Date: Thu, 30 Sep 2010 15:34:24 -0700
> Subject: [PATCH] sdhci: adjust sd 3.0 host controller spec clock divider
> 
> The sd 3.0 host spec does not require the clock divider to be a power of 2.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 96c7f60..73a94fe 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1003,14 +1003,12 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  		goto out;
>  
>  	if (host->version >= SDHCI_SPEC_300) {
> -		/* Version 3.00 divisors must be a multiple of 2. */
>  		if (host->max_clk <= clock)
>  			div = 1;
>  		else {
> -			for (div = 2; div < SDHCI_MAX_DIV_SPEC_300; div += 2) {
> -				if ((host->max_clk / div) <= clock)
> -					break;
> -			}
> +			div = host->max_clk/clock;
> +			if (host->max_clk % clock)
> +				div++;
>  		}
>  	} else {
>  		/* Version 2.00 divisors must be a power of 2. */
> -- 

Would you mind reviewing this, please?  I don't have access to the 3.0
spec.

Thanks very much,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
