From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: allow for eMMC 74 clock generation by controller
Date: Fri, 8 Oct 2010 00:58:50 +0100
Message-ID: <20101007235850.GB15409@void.printf.net>
References: <4B9DEAE2.3030707@nokia.com> <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com> <4BA72971.1070804@nokia.com> <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com> <4BB052F6.5080808@nokia.com> <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com> <20100920061459.GA9353@pengutronix.de> <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com> <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com> <55175F2E-72DD-4BB2-8EDD-70D8B553F7B6@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33322 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab0JGX6w (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Oct 2010 19:58:52 -0400
Content-Disposition: inline
In-Reply-To: <55175F2E-72DD-4BB2-8EDD-70D8B553F7B6@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, Mark Brown <markb@marvell.com>

Hi Philip,

On Thu, Sep 23, 2010 at 08:24:32AM -0700, Philip Rakity wrote:
> From: Philip Rakity <prakity@marvell.com>
> Date: Thu, 23 Sep 2010 08:15:03 -0700
> Subject: [PATCH] sdhci: allow for initial eMMC 74 clock generation by controller
> 
> resend of patch to fit into 80 char line lengths:
> 
> snippet of code for how adaption layer should handle the call.
> 
> 
> /*
>  * eMMC spec calls for the host to send 74 clocks to the card
>  * during initialization, right after voltage stabilization.
>  * create the clocks manually right here.
>  */
> void generate_init_clocks_A0(struct sdhci_host *host, u8 power_mode)
> {
> 	struct sdhci_mmc_slot *slot = sdhci_priv(host);
> 
> 	DBG ("%s: ENTER %s: slot->power_mode = %d, ios->power_mode = %d\n",
> 	 	__func__, 
> 		mmc_hostname(host->mmc),
> 		slot->power_mode, 
> 		power_mode);
> 
> 	if (slot->power_mode == MMC_POWER_UP 
> 	&& power_mode == MMC_POWER_ON) {
> 	
> 		/* controller specific code here */
> 		/* slot->power_mode holds previous power setting */
> 	}
> 	slot->power_mode = power_mode;
> }
> 
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    3 +++
>  drivers/mmc/host/sdhci.h |    2 ++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6b8ca32..ba8f9a0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1169,6 +1169,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	else
>  		sdhci_set_power(host, ios->vdd);
>  
> +	if (host->ops->platform_send_init_74_clocks)
> +		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
> +
>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  
>  	if (ios->bus_width == MMC_BUS_WIDTH_8)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 290b5a8..d73685a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -325,6 +325,8 @@ struct sdhci_ops {
>  	unsigned int	(*get_max_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_min_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
> +	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
> +		u8 power_mode);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> -- 

Thanks, applied to mmc-next.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
