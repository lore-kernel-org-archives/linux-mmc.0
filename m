From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1] sdhci: acpi: Use new method to get ACPI companion
Date: Tue, 25 Jul 2017 09:56:58 +0300
Message-ID: <722d50ff-937d-3184-7b1a-c51ee8dde25f@intel.com>
References: <20170724145958.34478-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48392 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbdGYHDf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Jul 2017 03:03:35 -0400
In-Reply-To: <20170724145958.34478-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 24/07/17 17:59, Andy Shevchenko wrote:
> ACPI_COMPANION() macro reduces a code to get a companion device out of
> struct device.
> 
> Use it instead of an old method.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index ac678e9fb19a..4bbce8919c30 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -432,7 +432,6 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
>  static int sdhci_acpi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	acpi_handle handle = ACPI_HANDLE(dev);
>  	struct acpi_device *device, *child;
>  	struct sdhci_acpi_host *c;
>  	struct sdhci_host *host;
> @@ -442,7 +441,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	const char *uid;
>  	int err;
>  
> -	if (acpi_bus_get_device(handle, &device))
> +	device = ACPI_COMPANION(dev);
> +	if (!device)
>  		return -ENODEV;
>  
>  	hid = acpi_device_hid(device);
> 

