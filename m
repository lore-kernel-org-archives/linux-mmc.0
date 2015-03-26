From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [RFC 6/6] mmc: atmel-mci: use atmel_io.h to provide on-chip IO
Date: Thu, 26 Mar 2015 12:58:22 +0100
Message-ID: <20150326115821.GE16148@samfundet.no>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-7-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:36963 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbbCZL6h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Mar 2015 07:58:37 -0400
Content-Disposition: inline
In-Reply-To: <1427370354-21247-7-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, hskinnemoen@gmail.com, linux@maxim.org.za, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Around Thu 26 Mar 2015 11:45:54 +0000 or thereabout, Ben Dooks wrote:
> Use <linux/atmel_io.h> to provide IO accessors which work on both
> AVR32 and ARM for on-chip peripherals.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> CC: Ludovic Desroches <ludovic.desroches@atmel.com>
> CC: Chris Ball <chris@printf.net>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/atmel-mci-regs.h | 11 ++---------
>  drivers/mmc/host/atmel-mci.c      |  1 +
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
> index 711bb53..2293f2c 100644
> --- a/drivers/mmc/host/atmel-mci-regs.h
> +++ b/drivers/mmc/host/atmel-mci-regs.h
> @@ -135,17 +135,10 @@
>  #define ATMCI_REGS_SIZE		0x100
>  
>  /* Register access macros */
> -#ifdef CONFIG_AVR32
>  #define atmci_readl(port,reg)			\
> -	__raw_readl((port)->regs + reg)
> +	atmel_oc_readl((port)->regs + reg)
>  #define atmci_writel(port,reg,value)			\
> -	__raw_writel((value), (port)->regs + reg)
> -#else
> -#define atmci_readl(port,reg)			\
> -	readl_relaxed((port)->regs + reg)
> -#define atmci_writel(port,reg,value)			\
> -	writel_relaxed((value), (port)->regs + reg)
> -#endif
> +	atmel_oc_writel((value), (port)->regs + reg)

Defines are utilized in the header file, but ...

>  
>  /* On AVR chips the Peripheral DMA Controller is not connected to MCI. */
>  #ifdef CONFIG_AVR32
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 03d7c75..49de0d7 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -37,6 +37,7 @@
>  
>  #include <linux/atmel-mci.h>
>  #include <linux/atmel_pdc.h>
> +#include <linux/atmel_io.h>

... you include the required header file in the source file instead.

Also, a follow-up patch could remove the atmci_{read,write}{l,w} defines
completely.

>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/consumer.h>
-- 
mvh
Hans-Christian Egtvedt
