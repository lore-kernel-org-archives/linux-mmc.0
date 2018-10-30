From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
Date: Tue, 30 Oct 2018 09:53:28 +0200
Message-ID: <79f9fb1f-9318-6265-d642-11d57719f287@intel.com>
References: <CAA93t1oaZ5zkv+BsGnYZg6pqKv0DzXi3j8oZHUyTyffUWHtHug@mail.gmail.com>
 <20181029221701.51376-1-rajatja@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029221701.51376-1-rajatja@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rajat Jain <rajatja@google.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Rajat Jain <rajatxjain@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 30/10/18 12:17 AM, Rajat Jain wrote:
> Problem:
> 
> The card detect IRQ does not work with modern BIOS (that want
> to use _DSD to provide the card detect GPIO to the driver).
> 
> Details:
> 
> The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
> request the gpio descriptor for the "card detect" pin.
> This pin is specified in the ACPI for the SDHC device:
> 
>  * Either as a resource using _CRS. This is a method used by legacy BIOS.
>    (The driver needs to tell which resource index).
> 
>  * Or as a named property ("cd-gpios"/"cd-gpio") in _DSD (which internally
>    points to an entry in _CRS). This way, the driver can lookup using a
>    string. This is what modern BIOS prefer to use.
> 
> This API finally results in a call to the following code:
> 
> struct gpio_desc *acpi_find_gpio(..., const char *con_id,...)
> {
> ...
>    /* Lookup gpio (using "<con_id>-gpio") in the _DSD */
> ...
>    if (!acpi_can_fallback_to_crs(adev, con_id))
>           return ERR_PTR(-ENOENT);
> ...
>    /* Falling back to _CRS is allowed, Lookup gpio in the _CRS */
> ...
> }
> 
> Note that this means that if the ACPI has _DSD properties, the kernel
> will never use _CRS for the lookup (Because acpi_can_fallback_to_crs()
> will always be false for any device hat has _DSD entries).
> 
> The SDHCI driver is thus currently broken on a modern BIOS, even if
> BIOS provides both _CRS (for index based lookup) and _DSD entries (for
> string based lookup). Ironically, none of these will be used for the
> lookup currently because:
> 
> * Since the con_id is NULL, acpi_find_gpio() does not find a matching
>   entry in DSDT. (The _DSDT entry has the property name = "cd-gpios")
> 
> * Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
>   returns false (because device properties have been populated from
>   _DSD), thus the _CRS is never used for the lookup.
> 
> Fix:
> 
> Try "cd" for lookup in the _DSD before falling back to using NULL so
> as to try looking up in the _CRS.
> 
> I've tested this patch successfully with both Legacy BIOS (that
> provide only _CRS method) as well as modern BIOS (that provide both
> _CRS and _DSD). Also the use of "cd" appears to be fairly consistent
> across other users of this API (other MMC host controller drivers).
> 
> Link: https://lkml.org/lkml/2018/9/25/1113
> Signed-off-by: Rajat Jain <rajatja@google.com>

This is good enough for a fix.  An ACPI GPIO mappings table can be done later.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2: Fix the commit log to take care of Andy's comments.
> 
>  drivers/mmc/host/sdhci-pci-core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 7bfd366d970d..e53333c695b3 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1762,8 +1762,13 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  		device_init_wakeup(&pdev->dev, true);
>  
>  	if (slot->cd_idx >= 0) {
> -		ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
> +		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>  					   slot->cd_override_level, 0, NULL);
> +		if (ret && ret != -EPROBE_DEFER)
> +			ret = mmc_gpiod_request_cd(host->mmc, NULL,
> +						   slot->cd_idx,
> +						   slot->cd_override_level,
> +						   0, NULL);
>  		if (ret == -EPROBE_DEFER)
>  			goto remove;
>  
> 
