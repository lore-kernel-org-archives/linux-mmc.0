From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 5/5 v3] ESDHC: Fix DMA errors in kernel booting on P1010
Date: Thu, 12 Jan 2012 07:28:44 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB002031F34@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1324972387-11408-1-git-send-email-r66093@freescale.com>
 <1324972387-11408-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:36212 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab2ALH2t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2012 02:28:49 -0500
In-Reply-To: <1324972387-11408-2-git-send-email-r66093@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Huang Changming-R66093 <r66093@freescale.com>, Jain Priyanka-B32167 <B32167@freescale.com>, Chris Ball <cjb@laptop.org>

Hi, Jerry
I think this patch is the same as I post here:
http://patchwork.ozlabs.org/patch/103184/

We need to consider the comment from Anton
http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-August/092402.html

Thanks.
Roy

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of r66093@freescale.com
> Sent: Tuesday, December 27, 2011 15:53 PM
> To: linux-mmc@vger.kernel.org
> Cc: Huang Changming-R66093; Jain Priyanka-B32167; Chris Ball
> Subject: [PATCH 5/5 v3] ESDHC: Fix DMA errors in kernel booting on P1010
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> When linux is booted with DMA mode enabled in esdhc module on P1010,
> there were following errors:
> 
> mmc0: ADMA error
> mmc0: error -5 whilst initialising SD card
> 
> It is because FSL ESDHC controller has different bit setting for PROCTL
> register, when kernel sets Power Control Register by method for standard
> SD Host Specification, it would overwritten FSL ESDHC PROCTL[DMAS];
> when it set Host Control Registers[DMAS], it sets PROCTL[EMODE] and
> PROCTL[D3CD]. These operations will set bad bits for PROCTL Register
> on FSL ESDHC Controller and cause errors, so this patch will make esdhc
> driver access FSL PROCTL Register according to block guide instead of
> standard SD Host Specification.
> 
> For some FSL chips, such as MPC8536/P2020, PROCTL[VOLT_SEL] and PROCTL[DMAS]
> bits are reserved and even if they are set to wrong bits there is no error.
> But considering that all FSL ESDHC Controller register map is not fully
> compliant to standard SD Host Specification, we put the patch to all of
> FSL ESDHC Controllers.
> 
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
> 	- change the property to compatible for quirks
> changes for v3:
> 	- fix one compile error
> 
>  drivers/mmc/host/sdhci-pltfm.c |    3 ++
>  drivers/mmc/host/sdhci.c       |   61 ++++++++++++++++++++++++++++++++----
> ---
>  include/linux/mmc/sdhci.h      |    2 +
>  3 files changed, 55 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-
> pltfm.c
> index 06f4ab9..f712218 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -86,6 +86,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
>  		if (of_device_is_compatible(np, "fsl,p1010-esdhc"))
>  			host->quirks2 |= SDHCI_QUIRK2_RELAX_FREQ;
> 
> +		if (of_device_is_compatible(np, "fsl,esdhc"))
> +			host->quirks2 |= SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD;
> +
>  #ifdef CONFIG_PM
>  		if (of_device_is_compatible(np, "fsl,p1022-esdhc")
>  			sdhc_pmsaveproctlreg = 1;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4b231fa..df2acc0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -832,14 +832,29 @@ static void sdhci_prepare_data(struct sdhci_host
> *host, struct mmc_command *cmd)
>  	 * is ADMA.
>  	 */
>  	if (host->version >= SDHCI_SPEC_200) {
> -		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> -		ctrl &= ~SDHCI_CTRL_DMA_MASK;
> -		if ((host->flags & SDHCI_REQ_USE_DMA) &&
> -			(host->flags & SDHCI_USE_ADMA))
> -			ctrl |= SDHCI_CTRL_ADMA32;
> -		else
> -			ctrl |= SDHCI_CTRL_SDMA;
> -		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +		if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD) {
> +#define ESDHCI_PROCTL_DMAS_MASK		0x00000300
> +#define ESDHCI_PROCTL_ADMA32		0x00000200
> +#define ESDHCI_PROCTL_SDMA		0x00000000
> +			u32 ctrl;
> +			ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);
> +			ctrl &= ~ESDHCI_PROCTL_DMAS_MASK;
> +			if ((host->flags & SDHCI_REQ_USE_DMA) &&
> +				(host->flags & SDHCI_USE_ADMA))
> +				ctrl |= ESDHCI_PROCTL_ADMA32;
> +			else
> +				ctrl |= ESDHCI_PROCTL_SDMA;
> +			sdhci_writel(host, ctrl, SDHCI_HOST_CONTROL);
> +		} else {
> +			ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +			ctrl &= ~SDHCI_CTRL_DMA_MASK;
> +			if ((host->flags & SDHCI_REQ_USE_DMA) &&
> +				(host->flags & SDHCI_USE_ADMA))
> +				ctrl |= SDHCI_CTRL_ADMA32;
> +			else
> +				ctrl |= SDHCI_CTRL_SDMA;
> +			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +		}
>  	}
> 
>  	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
> @@ -1175,17 +1190,29 @@ static void sdhci_set_power(struct sdhci_host *host,
> unsigned short power)
>  	u8 pwr = 0;
> 
>  	if (power != (unsigned short)-1) {
> +#define	ESDHCI_FSL_POWER_MASK	0x40
> +#define	ESDHCI_FSL_POWER_180	0x00
> +#define	ESDHCI_FSL_POWER_300	0x40
>  		switch (1 << power) {
>  		case MMC_VDD_165_195:
> -			pwr = SDHCI_POWER_180;
> +			if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD)
> +				pwr = ESDHCI_FSL_POWER_180;
> +			else
> +				pwr = SDHCI_POWER_180;
>  			break;
>  		case MMC_VDD_29_30:
>  		case MMC_VDD_30_31:
> -			pwr = SDHCI_POWER_300;
> +			if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD)
> +				pwr = ESDHCI_FSL_POWER_300;
> +			else
> +				pwr = SDHCI_POWER_300;
>  			break;
>  		case MMC_VDD_32_33:
>  		case MMC_VDD_33_34:
> -			pwr = SDHCI_POWER_330;
> +			if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD)
> +				pwr = ESDHCI_FSL_POWER_300;
> +			else
> +				pwr = SDHCI_POWER_330;
>  			break;
>  		default:
>  			BUG();
> @@ -1195,6 +1222,18 @@ static void sdhci_set_power(struct sdhci_host *host,
> unsigned short power)
>  	if (host->pwr == pwr)
>  		return;
> 
> +	/* Now FSL ESDHC Controller has no Bus Power bit,
> +	 * and PROCTL[21] bit is for voltage selection */
> +	if (host->quirks2 & SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD) {
> +		u8 volt = 0;
> +		volt = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +		volt &= ~ESDHCI_FSL_POWER_MASK;
> +		volt |= pwr;
> +		sdhci_writeb(host, volt, SDHCI_POWER_CONTROL);
> +
> +		return;
> +	}
> +
>  	host->pwr = pwr;
> 
>  	if (pwr == 0) {
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index f7c1e13..d025134 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -93,6 +93,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_OWN_CARD_DETECTION			(1<<0)
>  /* Controller operates the cards at reduced frequency */
>  #define SDHCI_QUIRK2_RELAX_FREQ				(1<<1)
> +/* Controller has weird bit setting for Protocol Control Register */
> +#define SDHCI_QUIRK2_QORIQ_PROCTL_WEIRD			(1<<2)
> 
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> --
> 1.7.5.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


