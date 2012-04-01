From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdhci-pci: add quirk for broken MSI on O2Micro ctrls.
Date: Sun, 01 Apr 2012 11:11:17 -0400
Message-ID: <874nt3lc6i.fsf@laptop.org>
References: <1333284372-4256-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37128 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391Ab2DAPLP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 1 Apr 2012 11:11:15 -0400
In-Reply-To: <1333284372-4256-1-git-send-email-manuel.lauss@googlemail.com>
	(Manuel Lauss's message of "Sun, 1 Apr 2012 14:46:12 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Sun, Apr 01 2012, Manuel Lauss wrote:
> MSI on my O2Micro OZ600 SD card reader is broken.  This patch adds a quirk
> to disable MSI on these controllers.
>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> v2: also wrap pci_disable_msi() calls as requested by Chris Ball.
>
>  drivers/mmc/host/sdhci-pci.c |   10 +++++++---
>  include/linux/mmc/sdhci.h    |    2 ++
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index fbbebe2..5439b18 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -561,6 +561,7 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
>  
>  static const struct sdhci_pci_fixes sdhci_o2 = {
>  	.probe		= o2_probe,
> +	.quirks2	= SDHCI_QUIRK2_BROKEN_MSI,
>  };
>  
>  static const struct sdhci_pci_fixes sdhci_jmicron = {
> @@ -1418,7 +1419,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
>  
>  	slots = chip->num_slots;	/* Quirk may have changed this */
>  
> -	pci_enable_msi(pdev);
> +	if (!(chip->quirks2 & SDHCI_QUIRK2_BROKEN_MSI))
> +		pci_enable_msi(pdev);
>  
>  	for (i = 0; i < slots; i++) {
>  		slot = sdhci_pci_probe_slot(pdev, chip, first_bar, i);
> @@ -1438,7 +1440,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
>  	return 0;
>  
>  free:
> -	pci_disable_msi(pdev);
> +	if (!(chip->quirks2 & SDHCI_QUIRK2_BROKEN_MSI))
> +		pci_disable_msi(pdev);
>  
>  	pci_set_drvdata(pdev, NULL);
>  	kfree(chip);
> @@ -1462,7 +1465,8 @@ static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
>  		for (i = 0; i < chip->num_slots; i++)
>  			sdhci_pci_remove_slot(chip->slots[i]);
>  
> -		pci_disable_msi(pdev);
> +		if (!(chip->quirks2 & SDHCI_QUIRK2_BROKEN_MSI))
> +			pci_disable_msi(pdev);
>  
>  		pci_set_drvdata(pdev, NULL);
>  		kfree(chip);
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index e9051e1..9752fe4 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -91,6 +91,8 @@ struct sdhci_host {
>  	unsigned int quirks2;	/* More deviations from spec. */
>  
>  #define SDHCI_QUIRK2_HOST_OFF_CARD_ON			(1<<0)
> +/* broken MSI Interrupts */
> +#define SDHCI_QUIRK2_BROKEN_MSI				(1<<1)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
