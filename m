From: "Huang Changming-R66093" <r66093@freescale.com>
Subject: RE: [PATCH 3/3] MMC/SD: add callback function to detect card
Date: Wed, 6 Jan 2010 10:40:33 +0800
Message-ID: <AB6F3DC934B5CA4F85B023CE4B5B2547E9FF6F@zch01exm24.fsl.freescale.net>
References: <1259913309-27146-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:39089 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab0AFCke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jan 2010 21:40:34 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id o062eYpq010516
	for <linux-mmc@vger.kernel.org>; Tue, 5 Jan 2010 19:40:34 -0700 (MST)
Received: from zch01exm24.fsl.freescale.net (zch01exm24.ap.freescale.net [10.192.129.208])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o062eaq4021915
	for <linux-mmc@vger.kernel.org>; Tue, 5 Jan 2010 20:40:36 -0600 (CST)
Content-class: urn:content-classes:message
In-Reply-To: <1259913309-27146-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <R66093@freescale.com>, linux-mmc@vger.kernel.org

Dear all,
Have any advice about these patchs for SDHC?

Thanks and Best Regards
Jerry Huang
 
Beijing office, Freescale Semiconductor
 

> -----Original Message-----
> From: Huang Changming-R66093 
> Sent: Friday, December 04, 2009 3:55 PM
> To: linux-mmc@vger.kernel.org
> Cc: Huang Changming-R66093
> Subject: [PATCH 3/3] MMC/SD: add callback function to detect card
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> Add callback function to check if the card has been removed.
> 
> in order to check if the card has been removed, the function 
> mmc_send_status will send commad CMD13 to card and ask the 
> card to send its status register to driver, which will 
> generate interrupt repeatly and make the system bad.
> Therefore, get_cd callback is used to detect the card if the 
> driver has.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
>  drivers/mmc/core/mmc.c |    5 ++++-
>  drivers/mmc/core/sd.c  |    5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c 
> index 06084db..c5c676d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -494,7 +494,10 @@ static void mmc_detect(struct mmc_host *host)
>  	/*
>  	 * Just check if our card has been removed.
>  	 */
> -	err = mmc_send_status(host->card, NULL);
> +	if (host->ops->get_cd)
> +		err = !host->ops->get_cd(host);
> +	else
> +		err = mmc_send_status(host->card, NULL);
>  
>  	mmc_release_host(host);
>  
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c 
> index cd81c39..3cf1f38 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -548,7 +548,10 @@ static void mmc_sd_detect(struct mmc_host *host)
>  	/*
>  	 * Just check if our card has been removed.
>  	 */
> -	err = mmc_send_status(host->card, NULL);
> +	if (host->ops->get_cd)
> +		err = !host->ops->get_cd(host);
> +	else
> +		err = mmc_send_status(host->card, NULL);
>  
>  	mmc_release_host(host);
>  
> --
> 1.6.4
> 
> 
