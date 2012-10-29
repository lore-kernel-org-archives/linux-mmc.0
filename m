From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-pci: fix 'Invalid iomem size' error message condition
Date: Mon, 29 Oct 2012 17:13:46 -0400
Message-ID: <87pq41q8vp.fsf@octavius.laptop.org>
References: <507FA7A7.4070100@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36753 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760480Ab2J2VN5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Oct 2012 17:13:57 -0400
In-Reply-To: <507FA7A7.4070100@intel.com> (Adrian Hunter's message of "Thu, 18
	Oct 2012 09:54:31 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On Thu, Oct 18 2012, Adrian Hunter wrote:
> The SDHCI standard defines a 256 byte register set but a device
> that specifies a larger iomem region is not an error.  Alter the
> message condition accordingly.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 4bb74b0..04936f3 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -1196,7 +1196,7 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
>  		return ERR_PTR(-ENODEV);
>  	}
>  
> -	if (pci_resource_len(pdev, bar) != 0x100) {
> +	if (pci_resource_len(pdev, bar) < 0x100) {
>  		dev_err(&pdev->dev, "Invalid iomem size. You may "
>  			"experience problems.\n");
>  	}

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
