From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2] mmc: mxcmmc: fix SD cards not being detected
 sometimes.
Date: Fri, 2 Nov 2012 09:25:50 +0100
Message-ID: <20121102082550.GE1641@pengutronix.de>
References: <1351612447-18982-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46322 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab2KBIZz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Nov 2012 04:25:55 -0400
Content-Disposition: inline
In-Reply-To: <1351612447-18982-1-git-send-email-javier.martin@vista-silicon.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, cjb@laptop.org

On Tue, Oct 30, 2012 at 04:54:07PM +0100, Javier Martin wrote:
> When a SD card is initialized some data transfers of 64 and 8 bytes
> are issued. It seems the DMA has some problems dealing with these kind
> of "short" transfers, leading sometimes to the SD card not being detected.
> 
> In order to solve this problem, do not use DMA for transfer sizes lower
> than the sector size.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
> Changes since v1:
>  - Do not remove the check "sg->length & 3".
> 
> ---
>  drivers/mmc/host/mxcmmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index fc42a2e..a09637f 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -240,7 +240,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
>  		return 0;
>  
>  	for_each_sg(data->sg, sg, data->sg_len, i) {
> -		if (sg->offset & 3 || sg->length & 3) {
> +		if (sg->offset & 3 || sg->length & 3 || sg->length < 512) {
>  			host->do_dma = 0;
>  			return 0;
>  		}
> -- 
> 1.7.9.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
