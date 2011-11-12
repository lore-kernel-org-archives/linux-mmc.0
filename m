From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pci: shut up BAR size warning
Date: Fri, 11 Nov 2011 22:20:36 -0500
Message-ID: <87bosihvqz.fsf@laptop.org>
References: <1320870118-3427-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38840 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab1KLDUg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Nov 2011 22:20:36 -0500
In-Reply-To: <1320870118-3427-1-git-send-email-manuel.lauss@googlemail.com>
	(Manuel Lauss's message of "Wed, 9 Nov 2011 21:21:58 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-mmc@vger.kernel.org

Hi Manuel,

On Wed, Nov 09 2011, Manuel Lauss wrote:
> kernel complains about invalid SDHCI iomem size on boot.  The BAR on my
> O2-Micro controller is 512 bytes large, twice the size SDHCI-PCI needs.
> This patch changes the warning to only appear when the BAR is smaller
> than expected.
>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
>  drivers/mmc/host/sdhci-pci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index d833d9c..0ee5c07 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -1199,7 +1199,7 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
>  		return ERR_PTR(-ENODEV);
>  	}
>  
> -	if (pci_resource_len(pdev, bar) != 0x100) {
> +	if (pci_resource_len(pdev, bar) < 0x100) {
>  		dev_err(&pdev->dev, "Invalid iomem size. You may "
>  			"experience problems.\n");
>  	}

We discussed this a few months ago -- the thread is at:

   http://thread.gmane.org/gmane.linux.kernel.mmc/8314

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
