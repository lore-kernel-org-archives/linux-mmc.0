From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: remove useless include
Date: Thu, 13 Aug 2015 17:23:03 +0200
Message-ID: <20150813152303.GA7268@odux.rfo.atmel.com>
References: <1439216808-11826-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:15554 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbbHMPXo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Aug 2015 11:23:44 -0400
Content-Disposition: inline
In-Reply-To: <1439216808-11826-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Aug 10, 2015 at 04:26:48PM +0200, Alexandre Belloni wrote:
> Definitions from linux/platform_data/atmel.h are not used, remove the
> include.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
>  drivers/mmc/host/atmel-mci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 9a39e0b7e583..bf62e429f7fc 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -29,7 +29,6 @@
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/types.h>
> -#include <linux/platform_data/atmel.h>
>  #include <linux/platform_data/mmc-atmel-mci.h>
>  
>  #include <linux/mmc/host.h>
> -- 
> 2.1.4
> 
