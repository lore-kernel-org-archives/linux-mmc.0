From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw-mmc: relocate the position called
 dw_mci_setup_bus()
Date: Fri, 26 Oct 2012 19:20:09 +0900
Message-ID: <007001cdb363$7a131ea0$6e395be0$%jun@samsung.com>
References: <5089FC09.6090101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17192 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391Ab2JZKUL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Oct 2012 06:20:11 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MCH00HNAWPFZWP0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 26 Oct 2012 19:20:09 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MCH00F94WPL4450@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 26 Oct 2012 19:20:09 +0900 (KST)
In-reply-to: <5089FC09.6090101@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <James.Hogan@imgtec.com>, 'Kyungmin Park' <kyungmin.park@samsung.com>

Friday, October 26, 2012, Jaehoon Chung <jh80.chung@samsung.com>
> I think right that dw_mci_setup_bus() is called into set_ios().
> Actually clock is enabled at dw_mci_setup_bus() in now.
> Then didn't ensure to wait the 74clock.
This will be ensured when first command is sent
with 'send_initialization' flag of CMD register.
But I feel this change is reasonable.
Looks good to me if commit message is modified.

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks.
Seungwon Jeon

> To stable clock is relocated the position into dw_mci_set_ios().
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 250aa18..9001844 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -682,9 +682,6 @@ static void __dw_mci_start_request(struct dw_mci *host,
>  	if (host->pdata->select_slot)
>  		host->pdata->select_slot(slot->id);
> 
> -	/* Slot specific timing and width adjustment */
> -	dw_mci_setup_bus(slot);
> -
>  	host->cur_slot = slot;
>  	host->mrq = mrq;
> 
> @@ -810,6 +807,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	if (slot->host->drv_data->set_ios)
>  		slot->host->drv_data->set_ios(slot->host, ios);
> 
> +	/* Slot specific timing and width adjustment */
> +	dw_mci_setup_bus(slot);
> +
>  	switch (ios->power_mode) {
>  	case MMC_POWER_UP:
>  		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
> --
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

