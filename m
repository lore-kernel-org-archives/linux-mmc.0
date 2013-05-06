From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 15/22] mmc: sdhci-acpi: remove unnecessary platform_set_drvdata()
Date: Mon, 06 May 2013 12:23:05 +0300
Message-ID: <51877679.1020002@intel.com>
References: <005a01ce4a23$44350800$cc9f1800$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57844 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502Ab3EFJSJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 May 2013 05:18:09 -0400
In-Reply-To: <005a01ce4a23$44350800$cc9f1800$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 06/05/13 09:30, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 7bcf74b..8e6c4da 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -211,7 +211,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_free:
> -	platform_set_drvdata(pdev, NULL);
>  	sdhci_free_host(c->host);
>  	return err;
>  }
> @@ -230,7 +229,6 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
>  
>  	dead = (sdhci_readl(c->host, SDHCI_INT_STATUS) == ~0);
>  	sdhci_remove_host(c->host, dead);
> -	platform_set_drvdata(pdev, NULL);
>  	sdhci_free_host(c->host);
>  
>  	return 0;
> 

