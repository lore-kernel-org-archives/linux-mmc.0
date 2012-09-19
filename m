From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 2/2] mmc: atmel-mci: AP700x PDC is not connected to MCI
Date: Wed, 19 Sep 2012 01:21:31 -0400
Message-ID: <m3d31ik2p0.fsf@pullcord.laptop.org>
References: <503F9613.5060007@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57339 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862Ab2ISFVJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Sep 2012 01:21:09 -0400
In-Reply-To: <503F9613.5060007@yahoo.es> (Hein Tibosch's message of "Fri, 31
	Aug 2012 00:34:27 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hein Tibosch <hein_tibosch@yahoo.es>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, "ludovic.desroches" <ludovic.desroches@atmel.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Havard Skinnemoen <havard@skinnemoen.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, Aug 30 2012, Hein Tibosch wrote:
> Earlier, atmel-mci was adapted to make use of the peripheral DMA
> controller (PDC), in case normal DMA wouldn't work.
> ( http://comments.gmane.org/gmane.linux.kernel.mmc/9403 )
> This works OK on ARM platforms (AT91), but it broke the driver
> for AVR32, the AP700x.
> Although the MCI has PDC support, the connection is not done for
> AVR chips
>
> This patch makes the use of PDC depend on CONFIG_AVR32
>
> Signed-off-by: Hein Tibosch <hein_tibosch@yahoo.es>
>
> ---
>  drivers/mmc/host/atmel-mci-regs.h |    7 +++++++
>  drivers/mmc/host/atmel-mci.c      |    2 +-
>  2 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
> index ab56f7d..c97001e 100644
> --- a/drivers/mmc/host/atmel-mci-regs.h
> +++ b/drivers/mmc/host/atmel-mci-regs.h
> @@ -140,6 +140,13 @@
>  #define atmci_writel(port,reg,value)			\
>  	__raw_writel((value), (port)->regs + reg)
>  
> +/* On AVR chips the Peripheral DMA Controller is not connected to MCI. */
> +#ifdef CONFIG_AVR32
> +#	define ATMCI_PDC_CONNECTED	0
> +#else
> +#	define ATMCI_PDC_CONNECTED	1
> +#endif
> +
>  /*
>   * Fix sconfig's burst size according to atmel MCI. We need to convert them as:
>   * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index a6a5593..b8de891 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2208,7 +2208,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
>  			"version: 0x%x\n", version);
>  
>  	host->caps.has_dma_conf_reg = 0;
> -	host->caps.has_pdc = 1;
> +	host->caps.has_pdc = ATMCI_PDC_CONNECTED;
>  	host->caps.has_cfg_reg = 0;
>  	host->caps.has_cstor_reg = 0;
>  	host->caps.has_highspeed = 0;

Thanks, pushed to mmc-next for 3.7.

I changed the commit message text to reflect my understanding of what
the patch does better, from:
  This patch makes the use of PDC depend on CONFIG_AVR32.
to:
  This patch makes the use of PDC depend on !CONFIG_AVR32.

(Ludovic, perhaps you could give an ACK for this patch?)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
