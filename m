From: "Huang Changming-R66093" <r66093@freescale.com>
Subject: RE: [PATCH 2/3] SDHCI: add sdhci_get_cd callback to detect the card
Date: Wed, 6 Jan 2010 10:40:16 +0800
Message-ID: <AB6F3DC934B5CA4F85B023CE4B5B2547E9FF6D@zch01exm24.fsl.freescale.net>
References: <1259913299-27102-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:39039 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab0AFCkS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jan 2010 21:40:18 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id o062eHhn010429
	for <linux-mmc@vger.kernel.org>; Tue, 5 Jan 2010 19:40:17 -0700 (MST)
Received: from zch01exm24.fsl.freescale.net (zch01exm24.ap.freescale.net [10.192.129.208])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o062jG3i026407
	for <linux-mmc@vger.kernel.org>; Tue, 5 Jan 2010 20:45:16 -0600 (CST)
Content-class: urn:content-classes:message
In-Reply-To: <1259913299-27102-1-git-send-email-r66093@freescale.com>
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
> Subject: [PATCH 2/3] SDHCI: add sdhci_get_cd callback to 
> detect the card
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> Add callback function sdhci_get_cd to detect the card.
> 
> In order to check if the card is present, we will read the 
> PRESENT STATE register and check the bit13 (Card detect pin level).
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
>  drivers/mmc/host/sdhci.c |   19 +++++++++++++++++++
>  drivers/mmc/host/sdhci.h |    2 +-
>  2 files changed, 20 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c 
> b/drivers/mmc/host/sdhci.c index 711cbcd..e5ac64b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1205,6 +1205,24 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>  	return !(present & SDHCI_WRITE_PROTECT);  }
>  
> +static int sdhci_get_cd(struct mmc_host *mmc) {
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	unsigned long flags;
> +	int present;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (host->flags & SDHCI_DEVICE_DEAD)
> +		present = 0;
> +	else
> +		present = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return (present & SDHCI_CARD_PRESENT); }
> +
>  static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int 
> enable)  {
>  	struct sdhci_host *host;
> @@ -1231,6 +1249,7 @@ static const struct mmc_host_ops sdhci_ops = {
>  	.request	= sdhci_request,
>  	.set_ios	= sdhci_set_ios,
>  	.get_ro		= sdhci_get_ro,
> +	.get_cd		= sdhci_get_cd,
>  	.enable_sdio_irq = sdhci_enable_sdio_irq,  };
>  
> diff --git a/drivers/mmc/host/sdhci.h 
> b/drivers/mmc/host/sdhci.h index cb8beea..438d32d 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -58,7 +58,7 @@
>  #define  SDHCI_DOING_READ	0x00000200
>  #define  SDHCI_SPACE_AVAILABLE	0x00000400
>  #define  SDHCI_DATA_AVAILABLE	0x00000800
> -#define  SDHCI_CARD_PRESENT	0x00010000
> +#define  SDHCI_CARD_PRESENT	0x00060000
>  #define  SDHCI_WRITE_PROTECT	0x00080000
>  
>  #define SDHCI_HOST_CONTROL 	0x28
> --
> 1.6.4
> 
> 
