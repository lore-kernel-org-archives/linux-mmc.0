From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-acpi: Add DMI fix_up_power_blacklist
Date: Wed, 12 Apr 2017 15:45:27 +0200
Message-ID: <7fbd0d75-cd67-1686-2109-009b0a987aea@redhat.com>
References: <20170405130007.5826-1-hdegoede@redhat.com>
 <20170405130007.5826-3-hdegoede@redhat.com>
 <b2dd19bb-18f5-8d85-86cf-0baee20c1c27@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753890AbdDLNp3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Apr 2017 09:45:29 -0400
In-Reply-To: <b2dd19bb-18f5-8d85-86cf-0baee20c1c27@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

Hi,

On 12-04-17 15:16, Adrian Hunter wrote:
> On 05/04/17 16:00, Hans de Goede wrote:
>> Add a DMI based blacklist for systems where calling
>> acpi_device_fix_up_power() is harmful.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Adjust for changes in mmc: sdhci-acpi: Add fix_up_power_blacklist module option
>> -Only use a single fix_up_power_dmi_blacklist for the GPDwin further testing
>>  has shown that the DMI strings are unique enough that we do not need the
>>  bios-date in there
>> ---
>>  drivers/mmc/host/sdhci-acpi.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index 5a73174..ba9e688 100644
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
>> @@ -384,6 +385,27 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>>  };
>>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>>
>> +static const struct dmi_system_id fix_up_power_dmi_blacklist[] = {
>> +	{
>> +		/*
>> +		 * Match for the GPDwin which unfortunately uses somewhat
>> +		 * generic dmi strings, which is why we test for 4 strings.
>> +		 * Comparing against 15 other byt/cht boards, board_vendor
>> +		 * and board_name are unique to the GPDwin, where as only one
>> +		 * other board has the same board_serial and 2 others have
>> +		 * the same default product_name.
>> +		 */
>> +		.driver_data = "80860F14:2",
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>> +			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>
> That match is too broad - it looks like defaults from AMI.  Other lazy
> manufacturers might also not bother to change the values.

Erm, no it is not too broad, that is why the largish comment is
there, to explain that it is not too broad.

My collection of DMI strings for Bay Trail / Cherry Trail devices,
which are the only ones using "80860F14:2" which also needs to match,
has been growing I now have 24 files, and:

[hans@shalem dmi-ids]$ ack "board_vendor" * | grep "AMI Corporation"
dmi.gpdwin:7:board_vendor: AMI Corporation

[hans@shalem dmi-ids]$ ack "board_name" * | grep "Default string"
dmi.gpdwin:5:board_name: Default string

[hans@shalem dmi-ids]$ ack "board_serial" * | grep "Default string"
dmi.gpdwin:6:board_serial: Default string
dmi.iwork8air:6:board_serial: Default string

[hans@shalem dmi-ids]$ ack "product_name" * | grep "Default string"
dmi.Chuwi_HiBook:15:power: product_name: Default string
dmi.chuwi.hi12:13:product_name: Default string
dmi.gpdwin:15:product_name: Default string
dmi.meegopad-t08:15:power: product_name: Default string

So as you can see the first 2 matches are unique in this set of
dmi strings from 24 boards.

Of those the following claim to have an ami bios:

[hans@shalem dmi-ids]$ grep -i -l American *
dmi.Chuwi_HiBook
dmi.Chuwi_Vi8_plus
dmi.Dexp_Ursus_GX110
dmi.asus.t200ta
dmi.chuwi.hi12
dmi.chuwi_hi10pro_cwi529
dmi.gpdwin
dmi.iwork8air
dmi.lamina-i8270
dmi.meegopad-t08
dmi.t100ta

So the uniqueness is not due to lack of AMI bios samples
in my set.

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
>> @@ -407,6 +429,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>  	const char *fix_up_power_bl = fix_up_power_blacklist;
>>  	bool fix_up_power = true;
>>  	struct acpi_device *device, *child;
>> +	const struct dmi_system_id *dmi_id;
>>  	struct sdhci_acpi_host *c;
>>  	struct sdhci_host *host;
>>  	struct resource *iomem;
>> @@ -421,6 +444,12 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>  	hid = acpi_device_hid(device);
>>  	uid = device->pnp.unique_id;
>>
>> +	if (!fix_up_power_bl) {
>> +		dmi_id = dmi_first_match(fix_up_power_dmi_blacklist);
>> +		if (dmi_id)
>> +			fix_up_power_bl = dmi_id->driver_data;
>> +	}
>> +
>>  	if (sdhci_acpi_compare_hid_uid(fix_up_power_bl, hid, uid))
>>  		fix_up_power = false;
>>
>>
>
