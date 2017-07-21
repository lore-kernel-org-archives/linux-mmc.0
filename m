From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: remove unused struct sdhci_host variable
Date: Fri, 21 Jul 2017 11:48:31 +0300
Message-ID: <6b372ca8-5777-d2f0-f4e1-bb4e55d9bcb2@intel.com>
References: <1500599990-170932-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6373 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752186AbdGUIzG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Jul 2017 04:55:06 -0400
In-Reply-To: <1500599990-170932-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

On 21/07/17 04:19, Shawn Lin wrote:
> It was never used and introduce a warning
> 
> drivers/mmc/host/sdhci-acpi.c: In function 'sdhci_acpi_sdio_probe_slot':
> drivers/mmc/host/sdhci-acpi.c:297:21: warning: variable 'host' set but
> not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci-acpi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index ac678e9..2b1df88 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -294,13 +294,10 @@ static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev,
>  				      const char *hid, const char *uid)
>  {
>  	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
> -	struct sdhci_host *host;
>  
>  	if (!c || !c->host)
>  		return 0;
>  
> -	host = c->host;
> -
>  	/* Platform specific code during sdio probe slot goes here */
>  
>  	return 0;
> 

