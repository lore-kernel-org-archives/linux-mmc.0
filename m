From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: sdhci-pci: Add MSI support
Date: Thu, 15 Mar 2012 23:41:37 -0400
Message-ID: <87ty1pb4b2.fsf@laptop.org>
References: <1331659002-13743-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1331659002-13743-1-git-send-email-alexander.stein@systec-electronic.com>
	(Alexander Stein's message of "Tue, 13 Mar 2012 18:16:40 +0100")
Sender: linux-pci-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Alexander,

On Tue, Mar 13 2012, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  drivers/mmc/host/sdhci-pci.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 7165e6a..9382f27 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -1379,6 +1379,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
>  
>  	slots = chip->num_slots;	/* Quirk may have changed this */
>  
> +	pci_enable_msi(pdev);
> +
>  	for (i = 0; i < slots; i++) {
>  		slot = sdhci_pci_probe_slot(pdev, chip, first_bar, i);
>  		if (IS_ERR(slot)) {
> @@ -1397,6 +1399,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
>  	return 0;
>  
>  free:
> +	pci_disable_msi(pdev);
> +
>  	pci_set_drvdata(pdev, NULL);
>  	kfree(chip);
>  
> @@ -1419,6 +1423,8 @@ static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
>  		for (i = 0; i < chip->num_slots; i++)
>  			sdhci_pci_remove_slot(chip->slots[i]);
>  
> +		pci_disable_msi(pdev);
> +
>  		pci_set_drvdata(pdev, NULL);
>  		kfree(chip);
>  	}

Thanks, I've merged all three patches to mmc-next for 3.4, using v2 of
patches 2 and 3, and adding Adrian's ACK to patch 2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
