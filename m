From: "Maupin, Chase" <chase.maupin@ti.com>
Subject: RE: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
Date: Tue, 6 Mar 2012 12:54:34 +0000
Message-ID: <7D46E86EC0A8354091174257B2FED1012F050F72@DLEE12.ent.ti.com>
References: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39045 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab2CFMyg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Mar 2012 07:54:36 -0500
In-Reply-To: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Ping on this patch.  I have not seen any response on the list but if I have missed something please let me know.

> -----Original Message-----
> From: Maupin, Chase
> Sent: Thursday, March 01, 2012 11:26 AM
> To: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org
> Cc: Maupin, Chase
> Subject: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
> 
> * With certain SD cards timeouts like the following have been seen
>   due to an improper calculation of the dto value:
>     mmcblk0: error -110 transferring data, sector 4126233, nr 8,
>     card status 0xc00
> * By removing the dto calculation and setting the timeout value
>   to the maximum specified by the SD card specification part A2
>   section 2.2.15 these timeouts can be avoided.
> * This change has been used by beagleboard users as well as the
>   Texas Instruments SDK without a negative impact.
> * There are multiple discussion threads about this but the most
>   relevant ones are:
>     * http://talk.maemo.org/showthread.php?p=1000707#post1000707
>     * http://www.mail-archive.com/linux-
> omap@vger.kernel.org/msg42213.html
> * Original proposal for this fix was done by Sukumar Ghoral of
>   Texas Instruments
> 
> * Tested using a Texas Instruments AM335x EVM
> 
> Signed-off-by: Chase Maupin <Chase.Maupin@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   30 +++++------------------------
> -
>  1 files changed, 5 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c
> b/drivers/mmc/host/omap_hsmmc.c
> index fd0c661..afd7292 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1481,11 +1481,8 @@ static int
> omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
>  	return 0;
>  }
> 
> -static void set_data_timeout(struct omap_hsmmc_host *host,
> -			     unsigned int timeout_ns,
> -			     unsigned int timeout_clks)
> +static void set_data_timeout(struct omap_hsmmc_host *host)
>  {
> -	unsigned int timeout, cycle_ns;
>  	uint32_t reg, clkd, dto = 0;
> 
>  	reg = OMAP_HSMMC_READ(host->base, SYSCTL);
> @@ -1493,25 +1490,8 @@ static void set_data_timeout(struct
> omap_hsmmc_host *host,
>  	if (clkd == 0)
>  		clkd = 1;
> 
> -	cycle_ns = 1000000000 / (clk_get_rate(host->fclk) / clkd);
> -	timeout = timeout_ns / cycle_ns;
> -	timeout += timeout_clks;
> -	if (timeout) {
> -		while ((timeout & 0x80000000) == 0) {
> -			dto += 1;
> -			timeout <<= 1;
> -		}
> -		dto = 31 - dto;
> -		timeout <<= 1;
> -		if (timeout && dto)
> -			dto += 1;
> -		if (dto >= 13)
> -			dto -= 13;
> -		else
> -			dto = 0;
> -		if (dto > 14)
> -			dto = 14;
> -	}
> +    /* Use the maximum timeout value allowed in the standard of 14
> or 0xE */
> +	dto = 14;
> 
>  	reg &= ~DTO_MASK;
>  	reg |= dto << DTO_SHIFT;
> @@ -1534,13 +1514,13 @@ omap_hsmmc_prepare_data(struct
> omap_hsmmc_host *host, struct mmc_request *req)
>  		 * busy signal.
>  		 */
>  		if (req->cmd->flags & MMC_RSP_BUSY)
> -			set_data_timeout(host, 100000000U, 0);
> +			set_data_timeout(host);
>  		return 0;
>  	}
> 
>  	OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
>  					| (req->data->blocks << 16));
> -	set_data_timeout(host, req->data->timeout_ns, req->data-
> >timeout_clks);
> +	set_data_timeout(host);
> 
>  	if (host->use_dma) {
>  		ret = omap_hsmmc_start_dma_transfer(host, req);
> --
> 1.7.0.4

