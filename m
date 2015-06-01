From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: insmod followed by rmmod will hung for eMMC
Date: Mon, 01 Jun 2015 12:45:10 +0900
Message-ID: <556BD546.1060208@samsung.com>
References: <705D14B1C7978B40A723277C067CEDE245184BC7@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:41905 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175AbbFADpN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 May 2015 23:45:13 -0400
In-reply-to: <705D14B1C7978B40A723277C067CEDE245184BC7@IN01WEMBXB.internal.synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prabu Thangamuthu <Prabu.T@synopsys.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Manjunath M Bettegowda <Manjunath.MB@synopsys.com>

Hi, Prabu.

Thanks for resending the patch.
Will apply this patch at my tree.

Thanks!

Best Regards,
Jaehoon Chung

On 05/28/2015 09:21 PM, Prabu Thangamuthu wrote:
> Remove module of dw_mmc driver will hung for eMMC devices if we follow the
> steps which are listed below,
> 	insmod dw_mmc.ko
> 	insmod dw_mmc-pci.ko
> 	rmmod dw_mmc-pci.ko
> 
> The root cause for this issue is, dw_mci_remove() will disable all the
> interrupts by programming 0x0 to INTMASK register then it will call
> dw_mci_cleanup_slot(). But dw_mci_cleanup_slot() is issuing CMD6 to
> disable the eMMC boot partition and it is waiting for Command Complete
> interrupt. Since INTMASK was already cleared by dw_mci_remove(), Command
> Complete interrupt is not reaching the system. This leads to process hung.
> 
> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
> ---
> Change log v2:
> 	-Added prefix "mmc:" to the commit message header.
> 	-Updated the Commit Message.
> 
>  drivers/mmc/host/dw_mmc.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 55179f1..40e9d8e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2926,15 +2926,15 @@ void dw_mci_remove(struct dw_mci *host)
>  {
>  	int i;
>  
> -	mci_writel(host, RINTSTS, 0xFFFFFFFF);
> -	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
> -
>  	for (i = 0; i < host->num_slots; i++) {
>  		dev_dbg(host->dev, "remove slot %d\n", i);
>  		if (host->slot[i])
>  			dw_mci_cleanup_slot(host->slot[i], i);
>  	}
>  
> +	mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
> +
>  	/* disable clock to CIU */
>  	mci_writel(host, CLKENA, 0);
>  	mci_writel(host, CLKSRC, 0);
> 

