From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: save and restore sdioirq when soft reset
 is performed
Date: Thu, 09 Feb 2012 10:05:51 +0100
Message-ID: <4F338C6F.9030802@atmel.com>
References: <1328721759-10124-1-git-send-email-ludovic.desroches@atmel.com> <1328784929-24174-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:50261 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2BIJGE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 04:06:04 -0500
In-Reply-To: <1328784929-24174-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02/09/2012 11:55 AM, ludovic.desroches@atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Sometimes a software reset is needed. Then some registers are saved and
> restored but the interrupt mask register is missing. It causes issues
> with sdio devices whose interrupts are masked after reset.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Chris, can you please queue this patch in a "fixes" branch?

Thanks, best regards,

> Cc: stable@vger.kernel.org
> ---
>  drivers/mmc/host/atmel-mci.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 09ac13b..dfa5dd9 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -965,11 +965,14 @@ static void atmci_start_request(struct atmel_mci *host,
>  	host->data_status = 0;
>  
>  	if (host->need_reset) {
> +		iflags = atmci_readl(host, ATMCI_IMR);
> +		iflags &= (ATMCI_SDIOIRQA | ATMCI_SDIOIRQB);
>  		atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
>  		atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
>  		atmci_writel(host, ATMCI_MR, host->mode_reg);
>  		if (host->caps.has_cfg_reg)
>  			atmci_writel(host, ATMCI_CFG, host->cfg_reg);
> +		atmci_writel(host, ATMCI_IER, iflags);
>  		host->need_reset = false;
>  	}
>  	atmci_writel(host, ATMCI_SDCR, slot->sdc_reg);


-- 
Nicolas Ferre
