From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 3/3] mmc: sdhci-pci: Do not set DMA mask in
 enable_dma()
Date: Tue, 8 Mar 2016 15:18:54 +0200
Message-ID: <56DED13E.9060106@intel.com>
References: <1457316477-8153-1-git-send-email-acourbot@nvidia.com>
 <1457316477-8153-4-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24908 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbcCHNXb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Mar 2016 08:23:31 -0500
In-Reply-To: <1457316477-8153-4-git-send-email-acourbot@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On 07/03/16 04:07, Alexandre Courbot wrote:
> DMA mask will already be set by sdhci_set_dma_mask(), which
> is equivalent to the removed code since pci_set_dma_mask()
> expands to its DMA-API counterpart.
> 
> There should also be no reason to set the DMA mask after probe.

Let's run that by the PCI mailing list just to be sure.  The patches for
reference:

	http://marc.info/?l=linux-mmc&m=145731654328126&w=2
	http://marc.info/?l=linux-mmc&m=145731654328128&w=2

change the sdhci-pci driver to set the DMA mask once during probe instead of
every time during resume.  Is there any reason a PCI device driver might
need to set the DMA mask every time during resume?


> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index df3b8eced8c4..62aa5d0efcee 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1302,7 +1302,6 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
>  {
>  	struct sdhci_pci_slot *slot;
>  	struct pci_dev *pdev;
> -	int ret = -1;
>  
>  	slot = sdhci_priv(host);
>  	pdev = slot->chip->pdev;
> @@ -1314,20 +1313,6 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
>  			"doesn't fully claim to support it.\n");
>  	}
>  
> -	if (host->flags & SDHCI_USE_64_BIT_DMA) {
> -		if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA) {
> -			host->flags &= ~SDHCI_USE_64_BIT_DMA;
> -		} else {
> -			ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> -			if (ret)
> -				dev_warn(&pdev->dev, "Failed to set 64-bit DMA mask\n");
> -		}
> -	}
> -	if (ret)
> -		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> -	if (ret)
> -		return ret;
> -
>  	pci_set_master(pdev);
>  
>  	return 0;
> 

