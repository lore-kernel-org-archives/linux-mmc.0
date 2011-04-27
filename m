From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [[v4] 5/5] MMC: SDHCI AutoCMD23 support.
Date: Wed, 27 Apr 2011 00:49:15 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB81997F@SAUSEXMBP01.amd.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-2-git-send-email-andreiw@motorola.com>
 <1303870235-29041-3-git-send-email-andreiw@motorola.com>
 <1303870235-29041-4-git-send-email-andreiw@motorola.com>
 <1303870235-29041-5-git-send-email-andreiw@motorola.com>
 <1303870235-29041-6-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.185]:26988
	"EHLO CH1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751578Ab1D0Fum convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Apr 2011 01:50:42 -0400
In-Reply-To: <1303870235-29041-6-git-send-email-andreiw@motorola.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>

Hi Andrei,

Is there any more change to your V4 than the ones we discussed yesterday? I did the mod we discussed, but seems like the driver only sends CMD23 now, not Auto CMD23.

Thanks,
Arindam

> -----Original Message-----
> From: Andrei Warkentin [mailto:andreiw@motorola.com]
> Sent: Wednesday, April 27, 2011 7:41 AM
> To: linux-mmc@vger.kernel.org
> Cc: Andrei Warkentin; Nath, Arindam; cjb@laptop.org; arnd@arndb.de;
> subhashj@codeaurora.org
> Subject: [[v4] 5/5] MMC: SDHCI AutoCMD23 support.
> 
> Enables Auto-CMD23 support where available (SDHCI 3.0 controllers)
> 
> Cc: arindam.nath@amd.com
> Cc: cjb@laptop.org
> Cc: arnd@arndb.de
> Cc: subhashj@codeaurora.org
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ---
>  drivers/mmc/host/sdhci.c  |   17 ++++++++++++++++-
>  drivers/mmc/host/sdhci.h  |    2 ++
>  include/linux/mmc/sdhci.h |    1 +
>  3 files changed, 19 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 41c987d..bf9aedb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -844,7 +844,13 @@ static void sdhci_set_transfer_mode(struct
> sdhci_host *host,
>  		if (!host->mrq->sbc &&
>  		    host->flags & SDHCI_ACMD12)
>  			mode |= SDHCI_TRNS_ACMD12;
> +		else if (host->mrq->sbc &&
> +			 host->flags & SDHCI_ACMD23) {
> +			mode |= SDHCI_TRNS_ACMD23;
> +			sdhci_writel(host, host->mrq->sbc->arg,
> SDHCI_ARGUMENT2);
> +		}
>  	}
> +
>  	if (data->flags & MMC_DATA_READ)
>  		mode |= SDHCI_TRNS_READ;
>  	if (host->flags & SDHCI_REQ_USE_DMA)
> @@ -1189,7 +1195,7 @@ static void sdhci_request(struct mmc_host *mmc,
> struct mmc_request *mrq)
>  		tasklet_schedule(&host->finish_tasklet);
>  	} else {
> 
> -		if (mrq->sbc)
> +		if (mrq->sbc && !(host->flags & SDHCI_ACMD23))
>  			sdhci_send_command(host, mrq->sbc);
>  		else
>  			sdhci_send_command(host, mrq->cmd);
> @@ -1947,6 +1953,15 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>  		host->flags |= SDHCI_ACMD12;
> 
> +	/* Auto-CMD23 stuff only works in ADMA or PIO. */
> +	if ((host->version == SDHCI_SPEC_300) &&
> +	    ((host->flags & SDHCI_USE_ADMA) ||
> +	     !(host->flags & SDHCI_REQ_USE_DMA))) {
> +		host->flags |= SDHCI_ACMD23;
> +		printk(KERN_INFO "%s: Auto-CMD23 available\n",
> mmc_hostname(mmc));
> +	} else
> +		printk(KERN_INFO "%s: Auto-CMD23 unavailable\n",
> mmc_hostname(mmc));
> +
>  	/*
>  	 * A controller may support 8-bit width, but the board itself
>  	 * might not have the pins brought out.  Boards that support
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 85750a9..2b3fb76 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -25,6 +25,7 @@
>   */
> 
>  #define SDHCI_DMA_ADDRESS	0x00
> +#define SDHCI_ARGUMENT2		0x00
> 
>  #define SDHCI_BLOCK_SIZE	0x04
>  #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz &
> 0xFFF))
> @@ -37,6 +38,7 @@
>  #define  SDHCI_TRNS_DMA		0x01
>  #define  SDHCI_TRNS_BLK_CNT_EN	0x02
>  #define  SDHCI_TRNS_ACMD12	0x04
> +#define  SDHCI_TRNS_ACMD23	0x08
>  #define  SDHCI_TRNS_READ	0x10
>  #define  SDHCI_TRNS_MULTI	0x20
> 
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index c54ac14..d91585a 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -110,6 +110,7 @@ struct sdhci_host {
>  #define SDHCI_REQ_USE_DMA	(1<<2)	/* Use DMA for this req. */
>  #define SDHCI_DEVICE_DEAD	(1<<3)	/* Device unresponsive */
>  #define SDHCI_ACMD12		(1<<4)	/* Auto CMD12 support */
> +#define SDHCI_ACMD23		(1<<5)	/* Auto CMD23 support */
> 
>  	unsigned int version;	/* SDHCI spec. version */
> 
> --
> 1.7.0.4
> 


