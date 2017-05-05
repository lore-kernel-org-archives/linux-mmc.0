From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Use macros in pci_ids definition
Date: Fri, 5 May 2017 09:09:03 +0300
Message-ID: <a9bec849-7abe-b934-f6c3-cae8e55d3a6e@intel.com>
References: <1493924158-2577-1-git-send-email-matthiasmartinsson@gmail.com>
 <1493924158-2577-2-git-send-email-matthiasmartinsson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:62123 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbdEEGOu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 5 May 2017 02:14:50 -0400
In-Reply-To: <1493924158-2577-2-git-send-email-matthiasmartinsson@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matthias Kraemer <matthiasmartinsson@gmail.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org

On 04/05/17 21:55, Matthias Kraemer wrote:
> This patch applies the PCI_DEVICE_ macros to specify the pci_ids instead
> of open-coding them within the sdhci-pci driver.
> 
> v2,v3:
> Suggested-by Adrian Hunter <adrian.hunter@intel.com>
> Instead of using the generic PCI_ marcos, introduce device specific macros
> to be able to shorten the table entries even further.
> 
> v4:
> Fix compile-time issue

Thanks, it looks better, although I still have some concerns - see below.

> 
> Signed-off-by: Matthias Kraemer <matthiasmartinsson@gmail.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 619 +++++---------------------------------
>  drivers/mmc/host/sdhci-pci.h      |  41 ++-
>  2 files changed, 111 insertions(+), 549 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 86560d5..d2b6115 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -992,554 +992,77 @@ static const struct sdhci_pci_fixes sdhci_amd = {
>  };
>  
>  static const struct pci_device_id pci_ids[] = {
> -	{
> -		.vendor		= PCI_VENDOR_ID_RICOH,
> -		.device		= PCI_DEVICE_ID_RICOH_R5C822,
> -		.subvendor	= PCI_ANY_ID,
> -		.subdevice	= PCI_ANY_ID,
> -		.driver_data	= (kernel_ulong_t)&sdhci_ricoh,
> -	},
> -
> -	{
> -		.vendor         = PCI_VENDOR_ID_RICOH,
> -		.device         = 0x843,
> -		.subvendor      = PCI_ANY_ID,
> -		.subdevice      = PCI_ANY_ID,
> -		.driver_data    = (kernel_ulong_t)&sdhci_ricoh_mmc,
> -	},
> -

<SNIP>

> -	{
> -		.vendor		= PCI_VENDOR_ID_AMD,
> -		.device		= PCI_ANY_ID,
> -		.class		= PCI_CLASS_SYSTEM_SDHCI << 8,
> -		.class_mask	= 0xFFFF00,
> -		.subvendor	= PCI_ANY_ID,
> -		.subdevice	= PCI_ANY_ID,
> -		.driver_data	= (kernel_ulong_t)&sdhci_amd,
> -	},
> -	{	/* Generic SD host controller */
> -		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
> -	},
> -
> +	{SDHCI_PCI_DEVICE(RICOH, RICOH_R5C822, ricoh)},
> +	{SDHCI_PCI_DEVICE(RICOH, RICOH_0x843, ricoh_mmc)},

<SNIP>

> +	{SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd)},
> +	/* Generic SD host controller */
> +	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
>  	{ /* end: all zeroes */ },
>  };
>  
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 36f7434..b3485cc 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -2,7 +2,7 @@
>  #define __SDHCI_PCI_H
>  
>  /*
> - * PCI device IDs
> + * PCI device IDs, sub IDs
>   */
>  
>  #define PCI_DEVICE_ID_INTEL_PCH_SDIO0	0x8809
> @@ -38,6 +38,45 @@
>  #define PCI_DEVICE_ID_INTEL_GLK_EMMC	0x31cc
>  #define PCI_DEVICE_ID_INTEL_GLK_SDIO	0x31d0
>  
> +#define PCI_DEVICE_ID_RICOH_0x843	0x843
> +#define PCI_DEVICE_ID_RICOH_0xe822	0xe822
> +#define PCI_DEVICE_ID_RICOH_0xe823	0xe823
> +#define PCI_DEVICE_ID_SYSKONNECT_0x8000	0x8000
> +#define PCI_DEVICE_ID_VIA_0x95d0	0x95d0
> +#define PCI_DEVICE_ID_REALTEK_0x5250	0x5250
> +
> +#define PCI_DEVICE_ID_INTEL_SUB_0x7884	0x7884
> +
> +/*
> + * PCI device class and mask
> + */
> +
> +#define SYSTEM_SDHCI			(PCI_CLASS_SYSTEM_SDHCI << 8)
> +#define PCI_CLASS_MASK			0xFFFF00
> +
> +/*
> + * Macros for PCI device-description
> + */
> +
> +#define _PCI_VEND(vend) PCI_VENDOR_ID_##vend
> +#define _PCI_DEV(dev) PCI_DEVICE_ID_##dev

Without exception, the device is prefixed by the vendor, so this should be:

#define _PCI_DEV(vend, dev) PCI_DEVICE_ID_##vend##_##dev

> +
> +#define SDHCI_PCI_DEVICE(vend, dev, cfg) \
> +	.vendor = _PCI_VEND(vend), .device = _PCI_DEV(dev), \
> +	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
> +	.driver_data = (kernel_ulong_t)&(sdhci_##cfg)

Still don't understand why you don't put the {} brackets into the macro?

> +
> +#define SDHCI_PCI_DEVICE_SUB(vend, dev, subvend, subdev, cfg) \
> +	.vendor = _PCI_VEND(vend), .device = _PCI_DEV(dev), \
> +	.subvendor = _PCI_VEND(subvend), .subdevice = _PCI_DEV(subdev), \
> +	.driver_data = (kernel_ulong_t)&(sdhci_##cfg)
> +

Still don't understand why you don't put the {} brackets into the macro?

> +#define SDHCI_PCI_DEVICE_CLASS(vend, cl, cl_msk, cfg) \
> +	.vendor = _PCI_VEND(vend), .device = PCI_ANY_ID, \
> +	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
> +	.class = (cl), .class_mask = (cl_msk), \
> +	.driver_data = (kernel_ulong_t)&(sdhci_##cfg)

Still don't understand why you don't put the {} brackets into the macro?

> +
>  /*
>   * PCI registers
>   */
> 

