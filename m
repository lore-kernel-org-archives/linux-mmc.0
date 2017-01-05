From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] sdhci-acpi: support deferred probe
Date: Thu, 5 Jan 2017 12:06:36 +0200
Message-ID: <93f55d1d-083d-1ee7-9286-eb1c5aa2811b@intel.com>
References: <1482719296-4783-1-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13715 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761245AbdAEKLw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Jan 2017 05:11:52 -0500
In-Reply-To: <1482719296-4783-1-git-send-email-rui.zhang@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-mmc@vger.kernel.org
Cc: cja@gmx.net, darcari@redhat.com

On 26/12/16 04:28, Zhang Rui wrote:

Subject should be mmc: sdhci-acpi: ...

> With commit
> 67bf5156edc4 (gpio / ACPI: fix returned error from acpi_dev_gpio_irq_get()),

> mmc_gpiod_request_cd() returns -EPROBE_DEFER if GPIO is not ready
> when sdhci-acpi driver is probed, and sdhci-acpi driver should be probed
> again later in this case.
> 
> This fixes an order issue when both GPIO and sdhci-acpi drivers are built as
> modules.

Commit message should be formatted as follows:

With commit 67bf5156edc4 ("gpio / ACPI: fix returned error from
acpi_dev_gpio_irq_get()"), mmc_gpiod_request_cd() returns -EPROBE_DEFER if
GPIO is not ready when sdhci-acpi driver is probed, and sdhci-acpi driver
should be probed again later in this case.

This fixes an order issue when both GPIO and sdhci-acpi drivers are built
as modules.

> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=177101
> Tested-by: Jonas Aaberg <cja@gmx.net>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 160f695..5440323 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -466,7 +466,10 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {
>  		bool v = sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL);
>  
> -		if (mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0, NULL)) {
> +		err = mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0, NULL);
> +		if (err) {
> +			if (err == -EPROBE_DEFER)
> +				goto err_free;
>  			dev_warn(dev, "failed to setup card detect gpio\n");
>  			c->use_runtime_pm = false;
>  		}
> 

