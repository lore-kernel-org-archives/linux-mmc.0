From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of PCI mode for the dw_mmc driver
Date: Fri, 30 Sep 2011 10:51:48 +0900
Message-ID: <4E8520B4.7070504@samsung.com>
References: <1317318052-2750-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32709 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab1I3Bvv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 21:51:51 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LSB00ESBBU0ER80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 30 Sep 2011 10:51:50 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LSB009ERBUD8450@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 30 Sep 2011 10:51:49 +0900 (KST)
In-reply-to: <1317318052-2750-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Matt Fleming <matt@console-pimps.org>, Zhangfei Gao <zhangfei.gao@marvell.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org

Hi Shashidhar.

On 09/30/2011 02:40 AM, Shashidhar Hiremath wrote:

> Support of PCI mode for the dw_mmc driver This Patch adds the support for the scenario where the Synopsys Designware IP is present on the PCI bus.The patch adds the minimal modifications necessary for the driver to work on PCI platform. The Driver has also been tested for on the PCI platform with single Card Slot.
> 
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
> v2:
> *As per Suggestions by Will Newton and James Hogan
> -Reduced the number of ifdefs
> 
>  drivers/mmc/host/Kconfig   |   11 ++
>  drivers/mmc/host/dw_mmc.c  |  352 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.h  |   13 ++
>  include/linux/mmc/dw_mmc.h |    4 +
>  4 files changed, 380 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8c87096..84d8908 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -526,6 +526,17 @@ config MMC_DW
>  	  block, this provides host support for SD and MMC interfaces, in both
>  	  PIO and external DMA modes.
>  
> +config MMC_DW_PCI
> +	bool "MMC_DW Support On PCI bus"
> +	depends on MMC_DW && PCI
> +	help
> +	  This selects the PCI for the Synopsys Designware Mobile Storage IP.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
> +
>  config MMC_DW_IDMAC
>  	bool "Internal DMAC interface"
>  	depends on MMC_DW
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0f714..0bd9e16 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -21,6 +21,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
>  #include <linux/module.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
>  #include <linux/seq_file.h>
> @@ -101,6 +102,7 @@ struct dw_mci_slot {
>  	int			last_detect_state;
>  };
>  
> +
>  static struct workqueue_struct *dw_mci_card_workqueue;
>  
>  #if defined(CONFIG_DEBUG_FS)
> @@ -682,6 +684,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
>  	u32 regs;
> +	u32 card_detect;
>  
>  	/* set default 1 bit mode */
>  	slot->ctype = SDMMC_CTYPE_1BIT;
> @@ -716,6 +719,13 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	switch (ios->power_mode) {
>  	case MMC_POWER_UP:
>  		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
> +		/* Enable Power to the card that has been detected */
> +		card_detect = mci_readl(slot->host, CDETECT);
> +		/* Enabling power for card 0 when PCI is the interface */
> +		mci_writel(slot->host, PWREN, ((~card_detect) & 0x1));

> +		break;
> +	case MMC_POWER_OFF:
> +		mci_writel(slot->host, PWREN, 0);
>  		break;


Using shift with slot->id.(1bit per card).

Regards,
Jaehoon Chung
