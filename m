From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc: mxcmmc: fix SD cards not being detected sometimes.
Date: Wed, 19 Sep 2012 18:50:03 +0200
Message-ID: <20120919165003.GH6180@pengutronix.de>
References: <1348053667-10389-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57868 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab2ISQuH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 12:50:07 -0400
Content-Disposition: inline
In-Reply-To: <1348053667-10389-1-git-send-email-javier.martin@vista-silicon.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, cjb@laptop.org

On Wed, Sep 19, 2012 at 01:21:07PM +0200, Javier Martin wrote:
> When a SD card is initialized some data transfers of 64 and 8 bytes
> are issued. It seems the DMA has some problems dealing with these kind
> of "short" transfers, leading sometimes to the SD card not being detected.
> 
> In order to solve this problem, do not use DMA for transfer sizes lower
> than the sector size.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
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
> +		if (sg->offset & 3 || sg->length < 512) {

This drops the check for sg->length & 3. The mmc framework probably
never issues such transfers, but can we be sure?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
