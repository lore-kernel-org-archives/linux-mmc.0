From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Handle the Hardware Locked Write Error(HLE)
Date: Fri, 02 Aug 2013 13:14:16 +0900
Message-ID: <51FB3218.7040309@samsung.com>
References: <1375415444-23407-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:8654 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab3HBEOQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2013 00:14:16 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQV00796YFKR1A0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Aug 2013 13:14:15 +0900 (KST)
In-reply-to: <1375415444-23407-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, James Hogan <james.hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <cjb@laptop.org>

You can refer to Seungwon's patch.

https://patchwork.kernel.org/patch/1814991/

Best Regards,
Jaehoon Chung

On 08/02/2013 12:50 PM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The Handle the Hardware Locked Write Error(HLE) was getting triggered
> intermittently on the SOCFPGA platform. But since the driver did not
> have a mechanism to handle this interrupt, it was stuck in the ISR.
> 
> Clear the HLE interrupt when it gets triggered.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> Cc: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/host/dw_mmc.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ee5f167..ef30bec 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1664,6 +1664,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  			queue_work(host->card_workqueue, &host->card_work);
>  		}
>  
> +		if (pending & SDMMC_INT_HLE)
> +			mci_writel(host, RINTSTS, SDMMC_INT_HLE);
> +
>  		/* Handle SDIO Interrupts */
>  		for (i = 0; i < host->num_slots; i++) {
>  			struct dw_mci_slot *slot = host->slot[i];
> 

