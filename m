From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH V4] Powerpc eSDHC Recover from the ADMA error
Date: Fri, 7 Sep 2012 06:12:10 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C172036@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1346398573-11721-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:21740
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753647Ab2IGGMR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Sep 2012 02:12:17 -0400
Received: from mail36-am1 (localhost [127.0.0.1])	by mail36-am1-R.bigfish.com
 (Postfix) with ESMTP id 45CF93400C2	for <linux-mmc@vger.kernel.org>; Fri,  7
 Sep 2012 06:12:15 +0000 (UTC)
Received: from AM1EHSMHS014.bigfish.com (unknown [10.3.201.228])	by
 mail36-am1.bigfish.com (Postfix) with ESMTP id AD01F300045	for
 <linux-mmc@vger.kernel.org>; Fri,  7 Sep 2012 06:12:12 +0000 (UTC)
In-Reply-To: <1346398573-11721-1-git-send-email-Haijun.Zhang@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Haijun-B42677 <B42677@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,
Anyone has some comment?

Best Regards
Jerry Huang


> -----Original Message-----
> From: Zhang Haijun-B42677
> Sent: Friday, August 31, 2012 3:36 PM
> To: linux-mmc@vger.kernel.org
> Cc: Zhang Haijun-B42677; Huang Changming-R66093
> Subject: [PATCH V4] Powerpc eSDHC Recover from the ADMA error
> 
> From: Haijun Zhang <Haijun.Zhang@freescale.com>
> 
> False ADMA Error might be reported when ADMA is used for multiple block
> read command with Stop at Block Gap. If PROCTL[SABGREQ] is set
> when the particular block's data is received by the System side logic
> before entire block(with CRC) data is received by the SD side logic,
> and also if ADMA descriptor line is fetched at the same time,
> then DMA engine might report false ADMA error. eSDHC might not be able
> to Continue(PROCTL[CREQ]=1)after Stop at Block Gap.
> This issue will impact the eSDHC IP VVN2.3.
> 
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
> changes for v4:
> 	- Add comments for the Enable of IRQSTATEN[BGESEN].
> 
> changes for v3:
> 	- Add codes to check eSDHC VVN2.3
> 
> changes for v2:
> 	- Change the subject with Powerpc prefix
> 	- Change the code for coding style issue
> 
>  drivers/mmc/host/sdhci-of-esdhc.c |   50
> ++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c          |    2 +
>  drivers/mmc/host/sdhci.h          |    5 +++-
>  3 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-
> of-esdhc.c
> index 91b328b..3ebee9b 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -21,6 +21,7 @@
>  #include "sdhci-esdhc.h"
> 
>  #define VENDOR_V_22    0x12
> +#define VENDOR_V_23    0x13
>  static u32 esdhc_readl(struct sdhci_host *host, int reg)
>  {
>  	u32 ret;
> @@ -84,6 +85,18 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
>  	return ret;
>  }
> 
> +static void esdhc_writel(struct sdhci_host *host, u32 val, int reg)
> +{
> +	/*
> +	 * Enable IRQSTATEN[BGESEN] is just to set IRQSTAT[BGE]
> +	 * when SYSCTL[RSTD]) is set for some special operations.
> +	 * No any impact other operation.
> +	 */
> +	if (reg == SDHCI_INT_ENABLE)
> +		val |= SDHCI_INT_BLK_GAP;
> +	sdhci_be32bs_writel(host, val, reg);
> +}
> +
>  static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
>  {
>  	if (reg == SDHCI_BLOCK_SIZE) {
> @@ -139,6 +152,40 @@ static unsigned int esdhc_of_get_min_clock(struct
> sdhci_host *host)
>  	return of_host->clock / 256 / 16;
>  }
> 
> +/*
> + * For Abort or Suspend after Stop at Block Gap, ignore the ADMA
> + * error(IRQSTAT[ADMAE]) if both Transfer Complete(IRQSTAT[TC])
> + * and Block Gap Event(IRQSTAT[BGE]) are also set.
> + * For Continue, apply soft reset for data(SYSCTL[RSTD]);
> + * and re-issue the entire read
> + * transaction from beginning.
> + */
> +static void esdhci_of_adma_workaround(struct sdhci_host *host, u32
> intmask)
> +{
> +	u32 tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> +
> +	tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> +	if (tmp == VENDOR_V_23) {
> +		if ((intmask & SDHCI_INT_DATA_END) &&
> +			(intmask & SDHCI_INT_BLK_GAP)) {
> +			dma_addr_t dmastart;
> +			dma_addr_t dmanow;
> +
> +			host->data->error = 0;
> +			dmastart = sg_dma_address(host->data->sg);
> +			dmanow = dmastart + host->data->bytes_xfered;
> +			/*
> +			 * Force update to the next DMA block boundary.
> +			 */
> +			dmanow = (dmanow &
> +				~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
> +				SDHCI_DEFAULT_BOUNDARY_SIZE;
> +			host->data->bytes_xfered = dmanow - dmastart;
> +			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> +		}
> +	}
> +}
> +
>  #ifdef CONFIG_PM
>  static u32 esdhc_proctl;
>  static void esdhc_of_suspend(struct sdhci_host *host)
> @@ -166,7 +213,7 @@ struct sdhci_of_data sdhci_esdhc = {
>  		.read_l = esdhc_readl,
>  		.read_w = esdhc_readw,
>  		.read_b = esdhc_readb,
> -		.write_l = sdhci_be32bs_writel,
> +		.write_l = esdhc_writel,
>  		.write_w = esdhc_writew,
>  		.write_b = esdhc_writeb,
>  		.set_clock = esdhc_set_clock,
> @@ -177,5 +224,6 @@ struct sdhci_of_data sdhci_esdhc = {
>  		.platform_suspend = esdhc_of_suspend,
>  		.platform_resume = esdhc_of_resume,
>  #endif
> +		.adma_workaround = esdhci_of_adma_workaround,
>  	},
>  };
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 684f1a4..3d9365a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2143,6 +2143,8 @@ static void sdhci_data_irq(struct sdhci_host *host,
> u32 intmask)
>  		printk(KERN_ERR "%s: ADMA error\n", mmc_hostname(host->mmc));
>  		sdhci_show_adma_error(host);
>  		host->data->error = -EIO;
> +		if (host->ops->adma_workaround)
> +			host->ops->adma_workaround(host, intmask);
>  	}
> 
>  	if (host->data->error)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 209f707..138d8fc 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -120,6 +120,7 @@
>  #define SDHCI_SIGNAL_ENABLE	0x38
>  #define  SDHCI_INT_RESPONSE	0x00000001
>  #define  SDHCI_INT_DATA_END	0x00000002
> +#define  SDHCI_INT_BLK_GAP	0x00000004
>  #define  SDHCI_INT_DMA_END	0x00000008
>  #define  SDHCI_INT_SPACE_AVAIL	0x00000010
>  #define  SDHCI_INT_DATA_AVAIL	0x00000020
> @@ -146,7 +147,8 @@
>  #define  SDHCI_INT_DATA_MASK	(SDHCI_INT_DATA_END | SDHCI_INT_DMA_END | \
>  		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
>  		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
> -		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR)
> +		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR | \
> +		SDHCI_INT_BLK_GAP)
>  #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
> 
>  #define SDHCI_ACMD12_ERR	0x3C
> @@ -275,6 +277,7 @@ struct sdhci_ops {
>  	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int
> uhs);
>  	void	(*platform_suspend)(struct sdhci_host *host);
>  	void	(*platform_resume)(struct sdhci_host *host);
> +	void	(*adma_workaround)(struct sdhci_host *host, u32 intmask);
> 
>  };
> 
> --
> 1.7.0.4


