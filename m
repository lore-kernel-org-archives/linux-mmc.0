From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: add 0x600 IP version
Date: Tue, 19 Aug 2014 14:02:18 -0500
Message-ID: <53F39F3A.1090704@atmel.com>
References: <1402559265-18340-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:27608 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbaHSTC1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Aug 2014 15:02:27 -0400
In-Reply-To: <1402559265-18340-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 12/06/2014 02:47, Ludovic Desroches :
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Chris, Ufl,

It seems that this tiny patch got forgotten: Should we re-send it?

Thanks, bye,

> ---
>  drivers/mmc/host/atmel-mci.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 1b4b064..9c4c191 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2306,6 +2306,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
>  
>  	/* keep only major version number */
>  	switch (version & 0xf00) {
> +	case 0x600:
>  	case 0x500:
>  		host->caps.has_odd_clk_div = 1;
>  	case 0x400:
> 


-- 
Nicolas Ferre
