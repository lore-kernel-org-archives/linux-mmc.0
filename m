From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v5] mmc: sdhci-acpi: Add module option to blacklist a
 device
Date: Tue, 13 Jun 2017 15:56:32 +0300
Message-ID: <54606904-08f9-5df7-41c7-5ca1853385b6@intel.com>
References: <20170613073733.8929-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:2436 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752565AbdFMNCf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 13 Jun 2017 09:02:35 -0400
In-Reply-To: <20170613073733.8929-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

On 13/06/17 10:37, Hans de Goede wrote:
> Commit e5bbf30733f9 ("mmc: sdhci-acpi: Ensure connected devices are
> powered when probing") introduced unconditional calling of
> acpi_device_fix_up_power() on the mmc controller and its children.
> 
> This broke wifi on some systems because acpi_device_fix_up_power()
> was called even for disabled children sometimes leaving gpio-s in
> a state where wifi would not work, this was fixed in
> commit e1d070c3793a ("mmc: sdhci-acpi: Only powered up enabled acpi
> child devices").
> 
> Unfortunately on some devices calling acpi_device_fix_up_power()
> still causes issues. Specifically on the GPD-win mini clam-shell PC
> which has a pci-e wifi module, it causes the wifi module to get
> turned off. This is a BIOS bug and I've tried to get the manufacturer
> to fix this but sofar they have not responded (and even if they do
> then we cannot assume all users will update their BIOS).
> 
> Since the GPD-win uses a pci-e wifi module the sdhci controller for
> sdio cards really should not get initialized on it at all.
> 
> This commit adds a new sdhci_acpi.blacklist module option which can
> be set to an ACPI hid:uid pair, e.g. "80860F14:2" to disable probing
> for the sdhci host matching the hid:uid pair, fixing the wifi not
> working on this machine.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Apart from minor comments below:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> -Make the module option take a hid:uid pair string, instead of it
>  being a boolean option, so that it only applies to one host
> 
> Changes in v3:
> -Make the module option skip probing the device entirely (return -ENODEV)
> 
> Changes in v4:
> -Fix bad seperator (now hid_end) check
> -Allow passing multiple HID:UID pairs seperated by commas
> 
> Changes in v5:
> -Fix of by one error in parsing the string
> -Better commit subject
> ---
>  drivers/mmc/host/sdhci-acpi.c | 46 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 89d9a8c014f5..9a1e0453cce4 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -83,6 +83,39 @@ struct sdhci_acpi_host {
>  	bool				use_runtime_pm;
>  };
>  
> +static char *blacklist;
> +
> +static bool sdhci_acpi_compare_hid_uid(const char *match, const char *hid,
> +				       const char *uid)
> +{
> +	const char *hid_end, *uid_end, *end;
> +
> +	if (!match || !hid || !uid)
> +		return false;
> +
> +	end = match + strlen(match);
> +
> +	do {
> +		hid_end = strchr(match, ':');
> +		if (!hid_end)
> +			return false;
> +
> +		uid_end = strchr(hid_end, ',');
> +		if (!uid_end)
> +			uid_end = end;
> +
> +		if (strlen(hid) == (hid_end - match) &&

Redundant ()

> +		    strncmp(match, hid, hid_end - match) == 0 &&
> +		    strlen(uid) == (uid_end - hid_end - 1) &&

Redundant ()

> +		    strncmp(hid_end + 1, uid, uid_end - hid_end - 1) == 0)
> +			return true;
> +
> +		match = uid_end + 1;
> +	} while (uid_end != end);
> +
> +	return false;
> +}
> +
>  static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
>  {
>  	return c->slot && (c->slot->flags & flag);
> @@ -378,6 +411,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	acpi_handle handle = ACPI_HANDLE(dev);
> +	const char *bl = blacklist;

Redundant bl

>  	struct acpi_device *device, *child;
>  	struct sdhci_acpi_host *c;
>  	struct sdhci_host *host;
> @@ -390,6 +424,12 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	if (acpi_bus_get_device(handle, &device))
>  		return -ENODEV;
>  
> +	hid = acpi_device_hid(device);
> +	uid = device->pnp.unique_id;
> +
> +	if (sdhci_acpi_compare_hid_uid(bl, hid, uid))
> +		return -ENODEV;
> +
>  	/* Power on the SDHCI controller and its children */
>  	acpi_device_fix_up_power(device);
>  	list_for_each_entry(child, &device->children, node)
> @@ -399,9 +439,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	if (sdhci_acpi_byt_defer(dev))
>  		return -EPROBE_DEFER;
>  
> -	hid = acpi_device_hid(device);
> -	uid = device->pnp.unique_id;
> -
>  	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!iomem)
>  		return -ENOMEM;
> @@ -580,6 +617,9 @@ static struct platform_driver sdhci_acpi_driver = {
>  
>  module_platform_driver(sdhci_acpi_driver);
>  
> +module_param(blacklist, charp, 0444);
> +MODULE_PARM_DESC(blacklist, "ACPI <HID:UID>[,HID:UID] which should be ignored");
> +
>  MODULE_DESCRIPTION("Secure Digital Host Controller Interface ACPI driver");
>  MODULE_AUTHOR("Adrian Hunter");
>  MODULE_LICENSE("GPL v2");
> 

