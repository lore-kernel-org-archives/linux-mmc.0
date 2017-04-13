From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Use macros in pci_ids definition
Date: Thu, 13 Apr 2017 11:52:39 +0300
Message-ID: <3b1dd7a6-65a8-e7ea-97b8-24e742b6f62d@intel.com>
References: <1491417893-16095-1-git-send-email-matthiasmartinsson@gmail.com>
 <1491417893-16095-2-git-send-email-matthiasmartinsson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34316 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbdDMI6U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 13 Apr 2017 04:58:20 -0400
In-Reply-To: <1491417893-16095-2-git-send-email-matthiasmartinsson@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matthias Kraemer <matthiasmartinsson@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 05/04/17 21:44, Matthias Kraemer wrote:
> This patch applies the PCI_DEVICE_ macros to specify the pci_ids instead
> of open-coding them within the sdhci-pci driver.
> 
> v2:
> Suggested-by Adrian Hunter <adrian.hunter@intel.com>
> Instead of using the generic PCI_ marcos, introduce device specific macros
> to be able to shorten the table entries even further.
> 
> Signed-off-by: Matthias Kraemer <matthiasmartinsson@gmail.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 673 +++++++-------------------------------
>  drivers/mmc/host/sdhci-pci.h      |  14 +
>  2 files changed, 139 insertions(+), 548 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 86560d5..b5292b0 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -992,554 +992,131 @@ static const struct sdhci_pci_fixes sdhci_amd = {
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

> +	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5C822,
> +			  sdhci_ricoh)},
> +	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_RICOH, 0x843, sdhci_ricoh_mmc)},

There are still duplicate PCI_VENDOR_ID_... and PCI_DEVICE_ID_... and
sdhci_... and {}.  I would just expect to see:

	SDHCI_PCI_DEV(RICOH, RICOH_R5C822, ricoh),
	SDHCI_PCI_DEV(RICOH, 0x843, ricoh_mmc),

Where there are numbers with no define, just define them:

	#define PCI_DEVICE_ID_0x843	0x843

