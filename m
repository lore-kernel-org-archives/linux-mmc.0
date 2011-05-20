From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [v5 5/5] MMC: SDHCI AutoCMD23 support.
Date: Fri, 20 May 2011 05:46:15 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300011BEA693A@SAUSEXMBP01.amd.com>
References: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
 <1305841590-26963-6-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:34061
	"EHLO VA3EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934080Ab1ETKq3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 May 2011 06:46:29 -0400
In-Reply-To: <1305841590-26963-6-git-send-email-andreiw@motorola.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "malchev@google.com" <malchev@google.com>

Hi Andrei,

[...]
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 7e28eec..713caf0 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -25,6 +25,7 @@
>   */
> 
>  #define SDHCI_DMA_ADDRESS	0x00
> +#define SDHCI_ARGUMENT2		0x00

Since SDHCI_DMA_ADDRESS and SDHCI_ARGUMENT2 in actually the same register, probably ...

#define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS

is a good idea?

> 
>  #define SDHCI_BLOCK_SIZE	0x04
>  #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz &
> 0xFFF))
> @@ -37,6 +38,7 @@
>  #define  SDHCI_TRNS_DMA		0x01
>  #define  SDHCI_TRNS_BLK_CNT_EN	0x02
>  #define  SDHCI_TRNS_ACMD12	0x04
> +#define  SDHCI_TRNS_ACMD23	0x08

How about changing these names explicitly to _AUTO_CMD12 and _AUTO_CMD23? That way we are less likely to get confused with App commands with same names.

>  #define  SDHCI_TRNS_READ	0x10
>  #define  SDHCI_TRNS_MULTI	0x20
> 
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index d70de9d..d0db8ae 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -114,6 +114,7 @@ struct sdhci_host {
>  #define SDHCI_SDR50_NEEDS_TUNING (1<<4)	/* SDR50 needs tuning */
>  #define SDHCI_NEEDS_RETUNING	(1<<5)	/* Host needs retuning */
>  #define SDHCI_ACMD12		(1<<6)	/* Auto CMD12 support */
> +#define SDHCI_ACMD23		(1<<7)	/* Auto CMD23 support */

Same comment as above.

Thanks,
Arindam


