From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] esdhc: fix DMA_MASK to not break mx25 DMA access
Date: Thu, 19 Jul 2012 02:51:21 -0400
Message-ID: <871uk89rbq.fsf@octavius.laptop.org>
References: <AF702D0F-8919-4E98-BD6C-DF05E0EE4DDE@savantav.com>
	<3DC84FDD-7D96-46D6-A9F2-C3F8A47E9051@comcast.net>
	<20120716214711.GX30009@pengutronix.de>
	<8D8658B1-9B29-4677-8CA8-EBEE0C42D3E6@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52572 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907Ab2GSGv3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Jul 2012 02:51:29 -0400
In-Reply-To: <8D8658B1-9B29-4677-8CA8-EBEE0C42D3E6@comcast.net> (Wilson &
	Cassie's message of "Tue, 17 Jul 2012 12:32:05 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wilson & Cassie <griscruf@comcast.net>
Cc: linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, wilson.callan@savantsystems.com

Hi,

On Tue, Jul 17 2012, Wilson & Cassie wrote:
> Patch to not set reserved bits in i.MX25 PROCTL register.  DMA stops working if those bits get set.
>
> Signed-off-by: Wilson Callan <wilson.callan at savantsystems.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> --- linux-3.4.4/drivers/mmc/host/sdhci-esdhc-imx.c.orig	2012-07-04 13:58:16.239979741 -0400
> +++ linux-3.4.4/drivers/mmc/host/sdhci-esdhc-imx.c	2012-07-04 14:34:38.939949292 -0400
> @@ -310,8 +310,10 @@ static void esdhc_writeb_le(struct sdhci
>  				SDHCI_CTRL_D3CD);
>  		/* ensure the endianess */
>  		new_val |= ESDHC_HOST_CONTROL_LE;
> -		/* DMA mode bits are shifted */
> -		new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
> +		if (!is_imx25_esdhc(imx_data)) { // bits 8&9 are reserved on mx25
> +			/* DMA mode bits are shifted */
> +			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
> +		}
>  
>  		esdhc_clrset_le(host, 0xffff, new_val, reg);
>  		return;

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
