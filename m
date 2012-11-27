From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3 1/4] mmc: dw-mmc: relocate the position called
 dw_mci_setup_bus()
Date: Tue, 27 Nov 2012 16:58:11 +0900
Message-ID: <001401cdcc74$f20d6850$d62838f0$%jun@samsung.com>
References: <509B6ED1.7030707@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51972 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758170Ab2K0H6N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Nov 2012 02:58:13 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0ME400GMPZFXXQA0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 27 Nov 2012 16:58:11 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0ME4006Q2ZGZ3B40@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 27 Nov 2012 16:58:11 +0900 (KST)
In-reply-to: <509B6ED1.7030707@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <James.Hogan@imgtec.com>

On Thursday, November 08, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> To ensure the stable clock need to enable before set the DW_MMC_CARD_NEED_INIT flag.
> If set DW_MMC_CARD_NEED_INIT flag, wait for 80-clock before first command after power-up.
As we have discussed, the location of 'dw_mci_setup_bus' seems proper in 'dw_mci_set_ios'.
But commit message doesn't really hit me. Origin code can also ensure the same.
Mr. Newton, do you have any opinion?

Thanks,
Seungwon Jeon
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
> --
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

