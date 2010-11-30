From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: on error print out SD CMD and CAPABILITY_1
	Register
Date: Tue, 30 Nov 2010 06:01:13 +0000
Message-ID: <20101130060113.GA4151@void.printf.net>
References: <8D8E1470-A817-4A97-962E-DC94DA424953@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50564 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab0K3GBP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Nov 2010 01:01:15 -0500
Content-Disposition: inline
In-Reply-To: <8D8E1470-A817-4A97-962E-DC94DA424953@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Philip,

On Thu, Oct 07, 2010 at 09:05:58PM -0700, Philip Rakity wrote:
> More information should be shown when sdhci_dumpregs is called.
> 
> 
> Knowing the command is useful for debugging.
> Capability 1 is useful for sdio v3
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    5 ++++-
>  drivers/mmc/host/sdhci.h |    2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9cb60ba..ea8472b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -77,8 +77,11 @@ static void sdhci_dumpregs(struct sdhci_host *host)
>  	printk(KERN_DEBUG DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
>  		sdhci_readw(host, SDHCI_ACMD12_ERR),
>  		sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
> -	printk(KERN_DEBUG DRIVER_NAME ": Caps:     0x%08x | Max curr: 0x%08x\n",
> +	printk(KERN_DEBUG DRIVER_NAME ": Caps:     0x%08x | Caps_1:   0x%08x\n",
>  		sdhci_readl(host, SDHCI_CAPABILITIES),
> +		sdhci_readl(host, SDHCI_CAPABILITIES_1));
> +	printk(KERN_DEBUG DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
> +		sdhci_readw(host, SDHCI_COMMAND),
>  		sdhci_readl(host, SDHCI_MAX_CURRENT));
>  
>  	if (host->flags & SDHCI_USE_ADMA)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index bfcd611..38ae340 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -161,7 +161,7 @@
>  #define  SDHCI_CAN_VDD_180	0x04000000
>  #define  SDHCI_CAN_64BIT	0x10000000
>  
> -/* 44-47 reserved for more caps */
> +#define SDHCI_CAPABILITIES_1	0x44
>  
>  #define SDHCI_MAX_CURRENT	0x48
>  

Pushed to mmc-next (which is now rebased onto .37-rc4), thanks very much.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
