From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: print card frequency in debug level
Date: Thu, 01 May 2014 17:42:28 +0900
Message-ID: <536208F4.2060900@samsung.com>
References: <1398865484-527-1-git-send-email-bigeasy@linutronix.de>
 <1398865484-527-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50465 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbaEAIm3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 May 2014 04:42:29 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4W000GP06SUCA0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 01 May 2014 17:42:28 +0900 (KST)
In-reply-to: <1398865484-527-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Hi, Sebastian.

You have to work on latest mmc-next repository.
And that message is useful information for debugging.
I didn't want to change message level.

Best Regards,
Jaehoon Chung

On 04/30/2014 10:44 PM, Sebastian Andrzej Siewior wrote:
> Printing this at info level can be very noisy the CD is not working and
> we poll for the card.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 82f5ea2..b8afc70 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -800,7 +800,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  		div = (host->bus_hz != clock) ? DIV_ROUND_UP(div, 2) : 0;
>  
>  		if ((clock << div) != slot->__clk_old || force_clkinit)
> -			dev_info(&slot->mmc->class_dev,
> +			dev_dbg(&slot->mmc->class_dev,
>  				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
>  				 slot->id, host->bus_hz, clock,
>  				 div ? ((host->bus_hz / div) >> 1) :
> 

