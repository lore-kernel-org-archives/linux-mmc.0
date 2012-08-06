From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH] eSDHC: Add ADMA mode support for eSDHC
Date: Mon, 6 Aug 2012 02:26:01 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C115197@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1331177102-24455-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:37365
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755520Ab2HFC0G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 5 Aug 2012 22:26:06 -0400
In-Reply-To: <1331177102-24455-1-git-send-email-r66093@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Pan Jiafei-B37022 <B37022@freescale.com>, Jin Zhengxiong-R64188 <R64188@freescale.com>

Hi, Chris and Anton
This patch has been pended five months, and no any feedback, do you have any comment about it?
Or it can be merged into next release?
We need it to enable the ADMA feature for FSL eSDHC controller.

Best Regards
Jerry Huang


> -----Original Message-----
> From: Huang Changming-R66093
> Sent: Thursday, March 08, 2012 11:25 AM
> To: linux-mmc@vger.kernel.org
> Cc: Huang Changming-R66093; Pan Jiafei-B37022; Jin Zhengxiong-R64188;
> Chris Ball; Anton Vorontsov
> Subject: [PATCH] eSDHC: Add ADMA mode support for eSDHC
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> The register of eSDHC Host Controller Capabilities is not compatible with
> standard SDHC register, and eSDHC cannot support End Attribute in NOP
> ADMA
> descriptor. With this patch eSDHC can works in ADMA mode
> and performance can be improved.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Pan Jiafei <Jiafei.Pan@freescale.com>
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c |   36
> +++++++++++++++++++++++++++++++++---
>  1 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-
> of-esdhc.c
> index f8eb1fb..ae5fcbf 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -21,6 +21,32 @@
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
> 
> +#define VENDOR_V_22	0x12
> +static u32 esdhc_readl(struct sdhci_host *host, int reg)
> +{
> +	u32 ret;
> +
> +	ret = in_be32(host->ioaddr + reg);
> +	/*
> +	 * The bit of ADMA flag in eSDHC is not compatible with standard
> +	 * SDHC register, so set fake flag SDHCI_CAN_DO_ADMA2 when ADMA is
> +	 * supported by eSDHC.
> +	 * And for many FSL eSDHC controller, the reset value of field
> +	 * SDHCI_CAN_DO_ADMA1 is one, but some of them can't support ADMA,
> +	 * only these vendor version is greater than 2.2/0x12 support ADMA.
> +	 * For FSL eSDHC, must aligned 4-byte, so use 0xFC to read the
> +	 * the verdor version number, oxFE is SDHCI_HOST_VERSION.
> +	 */
> +	if ((reg == SDHCI_CAPABILITIES) && (ret & SDHCI_CAN_DO_ADMA1)) {
> +		u32 tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> +		tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> +		if (tmp > VENDOR_V_22)
> +			ret |= SDHCI_CAN_DO_ADMA2;
> +	}
> +
> +	return ret;
> +}
> +
>  static u16 esdhc_readw(struct sdhci_host *host, int reg)
>  {
>  	u16 ret;
> @@ -144,7 +170,7 @@ static void esdhc_of_resume(struct sdhci_host *host)
>  #endif
> 
>  static struct sdhci_ops sdhci_esdhc_ops = {
> -	.read_l = sdhci_be32bs_readl,
> +	.read_l = esdhc_readl,
>  	.read_w = esdhc_readw,
>  	.read_b = esdhc_readb,
>  	.write_l = sdhci_be32bs_writel,
> @@ -161,9 +187,13 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>  };
> 
>  static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
> -	/* card detection could be handled via GPIO */
> +	/*
> +	 * card detection could be handled via GPIO
> +	 * eSDHC cannot support End Attribute in NOP ADMA descriptor
> +	 */
>  	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> -		| SDHCI_QUIRK_NO_CARD_NO_RESET,
> +		| SDHCI_QUIRK_NO_CARD_NO_RESET
> +		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.ops = &sdhci_esdhc_ops,
>  };
> 
> --
> 1.7.5.4


