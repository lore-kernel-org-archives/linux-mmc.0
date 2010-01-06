From: "Huang Changming-R66093" <r66093@freescale.com>
Subject: RE: [PATCH 1/3] MMC/SD: power on before detecting card
Date: Wed, 6 Jan 2010 10:40:27 +0800
Message-ID: <AB6F3DC934B5CA4F85B023CE4B5B2547E9FF6E@zch01exm24.fsl.freescale.net>
References: <1259913281-27045-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:39074 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab0AFCk3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jan 2010 21:40:29 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id o062eT53010491
	for <linux-mmc@vger.kernel.org>; Tue, 5 Jan 2010 19:40:29 -0700 (MST)
Received: from zch01exm24.fsl.freescale.net (zch01exm24.ap.freescale.net [10.192.129.208])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o062kUmm019185
	for <linux-mmc@vger.kernel.org>; Tue, 5 Jan 2010 20:46:31 -0600 (CST)
Content-class: urn:content-classes:message
In-Reply-To: <1259913281-27045-1-git-send-email-r66093@freescale.com>
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
> Subject: [PATCH 1/3] MMC/SD: power on before detecting card
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> power on before detecting card.
> 
> The driver will not get the right status when using the 
> callback function 'get_cd' to check if the card is present 
> because the power is not on.
> Therefore, the controller must be power on before detecting 
> the card status.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
>  drivers/mmc/core/core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 7dab2e5..7b3aee1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1067,12 +1067,13 @@ void mmc_rescan(struct work_struct *work)
>  	 */
>  	mmc_bus_put(host);
>  
> +	mmc_power_up(host);
> +
>  	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
>  		goto out;
>  
>  	mmc_claim_host(host);
>  
> -	mmc_power_up(host);
>  	mmc_go_idle(host);
>  
>  	mmc_send_if_cond(host, host->ocr_avail);
> -- 
> 1.6.4
> 
> 
