From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci: set Medfield SDIO as non-removable
Date: Sat, 04 Feb 2012 21:02:09 -0500
Message-ID: <m27h0282ce.fsf@bob.laptop.org>
References: <1327926439-23603-1-git-send-email-adrian.hunter@intel.com>
	<1327926439-23603-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46316 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958Ab2BECCQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 21:02:16 -0500
In-Reply-To: <1327926439-23603-2-git-send-email-adrian.hunter@intel.com>
	(Adrian Hunter's message of "Mon, 30 Jan 2012 14:27:18 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Mon, Jan 30 2012, Adrian Hunter wrote:
> Set Medfield SDIO as non-removable to avoid un-necessary
> card detect activity.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-pci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 7165e6a..6ebdc40 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -250,7 +250,7 @@ static int mfd_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  
>  static int mfd_sdio_probe_slot(struct sdhci_pci_slot *slot)
>  {
> -	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD;
> +	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE;
>  	return 0;
>  }

I've pushed this to mmc-next for 3.3.  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
