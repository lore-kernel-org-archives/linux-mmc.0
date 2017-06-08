From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 resend 2/3] mmc: sdhci-acpi: Add blacklist module
 option
Date: Thu, 8 Jun 2017 11:45:51 +0200
Message-ID: <b8429741-25c7-b176-c28c-b0c076f39467@redhat.com>
References: <20170524104755.25274-1-hdegoede@redhat.com>
 <20170524104755.25274-3-hdegoede@redhat.com>
 <97991ab4-95a6-1903-98ce-0f4197ad5b70@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13911 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbdFHJpy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Jun 2017 05:45:54 -0400
In-Reply-To: <97991ab4-95a6-1903-98ce-0f4197ad5b70@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hi,

On 07-06-17 14:47, Adrian Hunter wrote:
> On 24/05/17 13:47, Hans de Goede wrote:
>> Commit e5bbf30733f9 ("mmc: sdhci-acpi: Ensure connected devices are
>> powered when probing") introduced unconditional calling of
>> acpi_device_fix_up_power() on the mmc controller and its children.
>>
>> This broke wifi on some systems because acpi_device_fix_up_power()
>> was called even for disabled children sometimes leaving gpio-s in
>> a state where wifi would not work, this was fixed in
>> commit e1d070c3793a ("mmc: sdhci-acpi: Only powered up enabled acpi
>> child devices").
>>
>> Unfortunately on some devices calling acpi_device_fix_up_power()
>> still causes issues. Specifically on the GPD-win mini clam-shell PC
>> which has a pci-e wifi module, it causes the wifi module to get
>> turned off. This is a BIOS bug and I've tried to get the manufacturer
>> to fix this but sofar they have not responded (and even if they do
>> then we cannot assume all users will update their BIOS).
>>
>> Since the GPD-win uses a pci-e wifi module the sdhci controller for
>> sdio cards really should not get initialized on it at all.
>>
>> This commit adds a new sdhci_acpi.blacklist module option which can
>> be set to an ACPI hid:uid pair, e.g. "80860F14:2" to disable probing
>> for the sdhci host matching the hid:uid pair, fixing the wifi not
>> working on this machine.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Make the module option take a hid:uid pair string, instead of it
>>   being a boolean option, so that it only applies to one host
>> Changes in v3:
>> -Make the module option skip probing the device entirely (return -ENODEV)
>> ---
>>   drivers/mmc/host/sdhci-acpi.c | 36 +++++++++++++++++++++++++++++++++---
>>   1 file changed, 33 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index 89d9a8c014f5..3a7d979a306d 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -83,6 +83,29 @@ struct sdhci_acpi_host {
>>   	bool				use_runtime_pm;
>>   };
>>   
>> +static char *blacklist;
>> +
>> +static bool sdhci_acpi_compare_hid_uid(const char *match, const char *hid,
>> +				       const char *uid)
>> +{
>> +	const char *sep;
>> +
>> +	if (!match)
>> +		return false;
>> +
>> +	sep = strchr(match, ':');
>> +	if (!match)
> 
> You mean (!sep)

Right, will fix for v4.

>> +		return false;
>> +
>> +	if (strncmp(match, hid, sep - match))
>> +		return false;
>> +
>> +	if (strcmp(sep + 1, uid))
>> +		return false;
>> +
>> +	return true;
> 
> This should all go together i.e.
 >
> 	return sep && !strncmp(match, hid, sep - match) &&
> 	       !strcmp(sep + 1, uid);

Ok.


>> +}
>> +
>>   static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
>>   {
>>   	return c->slot && (c->slot->flags & flag);
>> @@ -378,6 +401,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>>   	acpi_handle handle = ACPI_HANDLE(dev);
>> +	const char *bl = blacklist;
>>   	struct acpi_device *device, *child;
>>   	struct sdhci_acpi_host *c;
>>   	struct sdhci_host *host;
>> @@ -390,6 +414,12 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>   	if (acpi_bus_get_device(handle, &device))
>>   		return -ENODEV;
>>   
>> +	hid = acpi_device_hid(device);
>> +	uid = device->pnp.unique_id;
>> +
>> +	if (sdhci_acpi_compare_hid_uid(bl, hid, uid))
> 
> 'bl' is redundant in this patch.  This should just be
> 
> 	if (sdhci_acpi_blacklist(hid, uid))
> 		return -ENODEV;
> 
>> +		return -ENODEV;
>> +
>>   	/* Power on the SDHCI controller and its children */
>>   	acpi_device_fix_up_power(device);
>>   	list_for_each_entry(child, &device->children, node)
>> @@ -399,9 +429,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>   	if (sdhci_acpi_byt_defer(dev))
>>   		return -EPROBE_DEFER;
>>   
>> -	hid = acpi_device_hid(device);
>> -	uid = device->pnp.unique_id;
>> -
>>   	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   	if (!iomem)
>>   		return -ENOMEM;
>> @@ -580,6 +607,9 @@ static struct platform_driver sdhci_acpi_driver = {
>>   
>>   module_platform_driver(sdhci_acpi_driver);
>>   
>> +module_param(blacklist, charp, 0444);
>> +MODULE_PARM_DESC(blacklist, "ACPI <HID:UID> which should be ignored");
> 
> Why not allow more than one HID:UID separated by commas.

I didn't think we will ever have the need to blacklist more then
1 HID:UID pair and it makes the parsing slightly harder. But since you've
asked I'll add support for this for v4.

Regards,

Hans
