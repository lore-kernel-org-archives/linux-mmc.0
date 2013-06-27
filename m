From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-pci: add another device id
Date: Thu, 27 Jun 2013 12:06:20 -0400
Message-ID: <874ncjmtc3.fsf@octavius.laptop.org>
References: <1371722279-16975-1-git-send-email-adrian.hunter@intel.com>
	<1371722279-16975-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37978 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030Ab3F0QGX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 12:06:23 -0400
In-Reply-To: <1371722279-16975-2-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Thu, 20 Jun 2013 12:57:59 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org

Hi Adrian,

On Thu, Jun 20 2013, Adrian Hunter wrote:
> Add another PCI device id for an eMMC host controller.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index e082fac..d7d6bc8 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -36,6 +36,7 @@
>  #define PCI_DEVICE_ID_INTEL_BYT_EMMC	0x0f14
>  #define PCI_DEVICE_ID_INTEL_BYT_SDIO	0x0f15
>  #define PCI_DEVICE_ID_INTEL_BYT_SD	0x0f16
> +#define PCI_DEVICE_ID_INTEL_BYT_EMMC2	0x0f50
>  
>  /*
>   * PCI registers
> @@ -931,6 +932,14 @@ static const struct pci_device_id pci_ids[] = {
>  	},
>  
>  	{
> +		.vendor		= PCI_VENDOR_ID_INTEL,
> +		.device		= PCI_DEVICE_ID_INTEL_BYT_EMMC2,
> +		.subvendor	= PCI_ANY_ID,
> +		.subdevice	= PCI_ANY_ID,
> +		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
> +	},
> +
> +	{
>  		.vendor		= PCI_VENDOR_ID_O2,
>  		.device		= PCI_DEVICE_ID_O2_8120,
>  		.subvendor	= PCI_ANY_ID,

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
