From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 1/4] mmc: atmel-mci: incude asm/cacheclush.h
Date: Fri, 6 Jun 2014 08:27:58 +0200
Message-ID: <20140606062757.GD2782@ldesroches-Latitude-E6320>
References: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
 <1402002881-1986640-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:15201 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbaFFG2E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jun 2014 02:28:04 -0400
Content-Disposition: inline
In-Reply-To: <1402002881-1986640-2-git-send-email-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>

On Thu, Jun 05, 2014 at 11:14:38PM +0200, Arnd Bergmann wrote:
> This avoids a build error due to the use of flush_dcache_page.
> 
> drivers/mmc/host/atmel-mci.c: In function 'atmci_read_data_pio':
> drivers/mmc/host/atmel-mci.c:1870:5: error: implicit declaration of function 'flush_dcache_page' [-Werror=implicit-function-declaration]
>      flush_dcache_page(sg_page(sg));
>      ^
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/mmc/host/atmel-mci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index aece7ca..bb585d9 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -37,6 +37,7 @@
>  #include <linux/atmel-mci.h>
>  #include <linux/atmel_pdc.h>
>  
> +#include <asm/cacheflush.h>
>  #include <asm/io.h>
>  #include <asm/unaligned.h>
>  
> -- 
> 1.8.3.2
> 
