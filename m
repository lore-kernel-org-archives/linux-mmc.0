From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] sdhci: don't finish commands in flight
Date: Wed, 22 Dec 2010 08:08:21 +0000
Message-ID: <20101222080821.GB19898@void.printf.net>
References: <1293004871-1918-1-git-send-email-olof@lixom.net> <1293004871-1918-3-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52869 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab0LVIIX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Dec 2010 03:08:23 -0500
Content-Disposition: inline
In-Reply-To: <1293004871-1918-3-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Hi Olof,

On Wed, Dec 22, 2010 at 02:01:10AM -0600, Olof Johansson wrote:
> Don't schedule the finish_tasklet unless the command complete bit is
> set in the interrupt status register.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Could we have some more detail here, please?  What are the symptoms of
running without this patch?  Should we apply it to the stable tree too?

> ---
>  drivers/mmc/host/sdhci.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c0094c1..562aaea 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1432,7 +1432,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
>  		host->cmd->error = -EILSEQ;
>  
>  	if (host->cmd->error) {
> -		tasklet_schedule(&host->finish_tasklet);
> +		if (intmask & SDHCI_INT_RESPONSE)
> +			tasklet_schedule(&host->finish_tasklet);
>  		return;
>  	}
>  

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
