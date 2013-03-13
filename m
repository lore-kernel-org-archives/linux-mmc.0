From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] dw_mmc: Don't loop when handling an interrupt
Date: Wed, 13 Mar 2013 17:31:47 +0900
Message-ID: <51403973.9080601@samsung.com>
References: <1363085593-22214-1-git-send-email-markos.chandras@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22647 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab3CMIbm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 04:31:42 -0400
In-reply-to: <1363085593-22214-1-git-send-email-markos.chandras@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 03/12/2013 07:53 PM, Markos Chandras wrote:
> There is no reason to loop when handling an interrupt. The "if" clauses
> will handle all of them sequentially. This also eliminates the extra loop
> we used to take with no pending interrupts and we ended up breaking out
> of the while loop.
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Chris Ball <cjb@laptop.org>
> ---
> The patch is based on Chris Ball's mmc-next branch
> 
>  drivers/mmc/host/dw_mmc.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 60063cc..78c7251 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1563,11 +1563,11 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  {
>  	struct dw_mci *host = dev_id;
>  	u32 pending;
> -	unsigned int pass_count = 0;
>  	int i;
>  
> -	do {
> -		pending = mci_readl(host, MINTSTS); /* read-only mask reg */
> +	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
> +
> +	if (pending) {
>  
>  		/*
>  		 * DTO fix - version 2.10a and below, and only if internal DMA
> @@ -1579,9 +1579,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  				pending |= SDMMC_INT_DATA_OVER;
>  		}
>  
> -		if (!pending)
> -			break;
> -
>  		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
>  			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
>  			host->cmd_status = pending;
> @@ -1642,7 +1639,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  			}
>  		}
>  
> -	} while (pass_count++ < 5);
> +	}
>  
>  #ifdef CONFIG_MMC_DW_IDMAC
>  	/* Handle DMA interrupts */
> 

