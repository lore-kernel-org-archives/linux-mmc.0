From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mxcmmc: Internal error: Oops: 17 [#1] ARM from sg->offset
Date: Wed, 22 Jan 2014 07:42:31 +0100
Message-ID: <20140122064231.GZ16215@pengutronix.de>
References: <1390365159-29239-1-git-send-email-chris.ruehl@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40524 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbaAVGmg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2014 01:42:36 -0500
Content-Disposition: inline
In-Reply-To: <1390365159-29239-1-git-send-email-chris.ruehl@gtsys.com.hk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc: mpa@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm@lists.infradead.org

On Wed, Jan 22, 2014 at 12:32:39PM +0800, Chris Ruehl wrote:
> Function mxcmci_request() throw an exception on a imx27 cpu.
> This patch fix the problem by test the pointer before access it.
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index f7199c8..8645d6a 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -347,7 +347,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
>  		return 0;
>  
>  	for_each_sg(data->sg, sg, data->sg_len, i) {
> -		if (sg->offset & 3 || sg->length & 3 || sg->length < 512) {
> +		if (sg && (sg->offset & 3 || sg->length & 3 || sg->length < 512)) {

The question is why sg is NULL. I think this shouldn't happen.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
