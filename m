From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-acpi: Add DMI fix_up_power_blacklist
Date: Wed, 5 Apr 2017 12:47:36 +0200
Message-ID: <2d3cf162-97e5-b238-dde8-b1a42e5edf60@redhat.com>
References: <20170404085013.19837-1-hdegoede@redhat.com>
 <20170404085013.19837-4-hdegoede@redhat.com>
 <50c5d542-7f0c-da64-1e20-41cb4d86fe53@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932949AbdDEKrj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Apr 2017 06:47:39 -0400
In-Reply-To: <50c5d542-7f0c-da64-1e20-41cb4d86fe53@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

Hi,

On 05-04-17 09:29, Adrian Hunter wrote:
> On 04/04/17 11:50, Hans de Goede wrote:
>> Add a DMI based blacklist for systems where calling
>> acpi_device_fix_up_power() is harmful.
>>
>> Note as the comment added above the GPDwin entry explains unfortunately
>> the GPDwin dmi strings are somewhat generic, so I've added the bios-date
>> string for a more unique match, which means we need 3 entries for the
>> GPDwin for the 3 known BIOS versions out there.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/mmc/host/sdhci-acpi.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 45 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index 8fe46ba..826e34f 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -36,6 +36,7 @@
>>  #include <linux/pm.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/delay.h>
>> +#include <linux/dmi.h>
>>
>>  #include <linux/mmc/host.h>
>>  #include <linux/mmc/pm.h>
>> @@ -83,7 +84,7 @@ struct sdhci_acpi_host {
>>  	bool				use_runtime_pm;
>>  };
>>
>> -static int fix_up_power = 1;
>> +static int fix_up_power = -1;
>>
>>  static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
>>  {
>> @@ -363,6 +364,42 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>>  };
>>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>>
>> +static const struct dmi_system_id fix_up_power_blacklist[] = {
>> +	{
>> +		/*
>> +		 * Match for the GPDwin which unfortunately uses somewhat
>> +		 * generic dmi strings, which is why the bios-date match is
>> +		 * included and we need multiple entries :| These strings have
>> +		 * been checked against 6 other byt/cht boards and board_vendor
>> +		 * and board_name are unique to the GPDwin (in the test set)
>> +		 * where as only one other board has the same board_version.
>> +		 */
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>> +			DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
>> +			DMI_MATCH(DMI_BIOS_DATE, "10/25/2016"),
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>> +			DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
>> +			DMI_MATCH(DMI_BIOS_DATE, "11/18/2016"),
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>> +			DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
>> +			DMI_MATCH(DMI_BIOS_DATE, "02/21/2017"),
>
> And if there are more versions?

True, I already sort of expected this, so I've asked the internets
to send me dmi strings for other Cherry Trail / Bay Trail devices,
I now have a sample set of 15 devices.

Among these the GPDwin is the only one to set DMI_BOARD_VENDOR to
"AMI Corporation", as well as the only one to set DMI_BOARD_NAME
to "Default string", one of only 2 to set DMI_BOARD_SERIAL to
"Default string" and as one of only 3 to set DMI_PRODUCT_NAME
to "Default string", so I think that if me on those 4 (the latter
2 to be on the save side) that we can then remove the BIOS date
check and use only one entry, I will do so in the next version.

I do believe that we really need a DMI quirk and not just a module
option as this is something which should just work (and wifi not working
actually is a recent regression, see below).

> I would prefer to add a module parameter to blacklist the offending HID:UID

I think that applying the module_param to only a single HID:UID is a good
idea, this will also make the DMI match more narrow, esp. since the
GPDwin uses the somewhat rare 80860F14:2 HID:UID which only got added to
the kernel recently (and promptly regressed wifi support on the GPDwin).

I will do so in the next version.

When you say "black_list" do you mean not apply the acpi_power_fix_up calls
to the selected HID:UID, or do you mean completely ignoring the device
(return -ENODEV from probe()) ?

I think only skipping the acpi_power_fix_up calls is better, because that
I've the feeling that might help on some boards which do have sdio-wifi too,
where as returning -ENODEV although it will work for the GPDwin case, is
less likely to help in other cases (although I must admit I guess it may also
help in some cases where only skipping the power-fixup might not).

Regards,

Hans



>
>> +		},
>> +	},
>> +	{ }
>> +};
>> +
>>  static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
>>  							 const char *uid)
>>  {
>> @@ -395,6 +432,13 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>  	if (acpi_bus_get_device(handle, &device))
>>  		return -ENODEV;
>>
>> +	if (fix_up_power == -1) {
>> +		if (dmi_check_system(fix_up_power_blacklist))
>> +			fix_up_power = 0;
>> +		else
>> +			fix_up_power = 1;
>> +	}
>> +
>>  	/* Power on the SDHCI controller and its children */
>>  	if (fix_up_power) {
>>  		acpi_device_fix_up_power(device);
>>
>
