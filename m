From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 1/4] mmc: dw-mmc: relocate the position called
 dw_mci_setup_bus()
Date: Thu, 22 Nov 2012 17:09:26 +0900
Message-ID: <50ADDDB6.7090107@samsung.com>
References: <509B6ED1.7030707@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:29241 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135Ab2KVUT6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Nov 2012 15:19:58 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDV00365QNTFJE0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 22 Nov 2012 17:09:37 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MDV0089SQNWLBB0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 22 Nov 2012 17:09:37 +0900 (KST)
In-reply-to: <509B6ED1.7030707@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

Hi Mr, Seungwon.

Do you have any opinion about this patch and others?
If you have, let me know, plz.

Best Regards,
Jaehoon Chung

On 11/08/2012 05:35 PM, Jaehoon Chung wrote:
> To ensure the stable clock need to enable before set the DW_MMC_CARD_NEED_INIT flag.
> If set DW_MMC_CARD_NEED_INIT flag, wait for 80-clock before first command after power-up.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> Changelog v2-v3:
> 	- Modified the commit-message
>  drivers/mmc/host/dw_mmc.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> ---
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c0667c8..a1369aa 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -683,9 +683,6 @@ static void __dw_mci_start_request(struct dw_mci *host,
>  	if (host->pdata->select_slot)
>  		host->pdata->select_slot(slot->id);
>  
> -	/* Slot specific timing and width adjustment */
> -	dw_mci_setup_bus(slot);
> -
>  	host->cur_slot = slot;
>  	host->mrq = mrq;
>  
> @@ -812,6 +809,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	if (drv_data && drv_data->set_ios)
>  		drv_data->set_ios(slot->host, ios);
>  
> +	/* Slot specific timing and width adjustment */
> +	dw_mci_setup_bus(slot);
> +
>  	switch (ios->power_mode) {
>  	case MMC_POWER_UP:
>  		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
> 

