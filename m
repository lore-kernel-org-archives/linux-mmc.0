From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 resend 3/3] mmc: sdhci-acpi: Add DMI based blacklist
Date: Thu, 8 Jun 2017 12:20:40 +0200
Message-ID: <4d4ba40a-043c-3543-33d5-40887b4c3363@redhat.com>
References: <20170524104755.25274-1-hdegoede@redhat.com>
 <20170524104755.25274-4-hdegoede@redhat.com>
 <79b5300b-11a2-33f1-439d-e09a2047d6f3@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbdFHKUn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Jun 2017 06:20:43 -0400
In-Reply-To: <79b5300b-11a2-33f1-439d-e09a2047d6f3@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hi,

On 07-06-17 15:09, Adrian Hunter wrote:
> On 24/05/17 13:47, Hans de Goede wrote:
>> Add a DMI based blacklist for systems where probing some sdio interfaces
>> is harmful (e.g. causes pci-e based wifi to not work).
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Adjust for changes in mmc: sdhci-acpi: Add fix_up_power_blacklist module option
>> -Only use a single fix_up_power_dmi_blacklist for the GPDwin further testing
>>   has shown that the DMI strings are unique enough that we do not need the
>>   bios-date in there
>> Changes in v3:
>> -Adjust for changes to "mmc: sdhci-acpi: Add blacklist module option"
>> ---
>>   drivers/mmc/host/sdhci-acpi.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index 3a7d979a306d..45455abc7ca6 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/pm.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/delay.h>
>> +#include <linux/dmi.h>
>>   
>>   #include <linux/mmc/host.h>
>>   #include <linux/mmc/pm.h>
>> @@ -381,6 +382,28 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>>   };
>>   MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>>   
>> +static const struct dmi_system_id fix_up_power_dmi_blacklist[] = {
>> +	{
>> +		/*
>> +		 * Match for the GPDwin which unfortunately uses somewhat
>> +		 * generic dmi strings, which is why we test for 4 strings.
>> +		 * Comparing against 23 other byt/cht boards, board_vendor
>> +		 * and board_name are unique to the GPDwin, where as only one
>> +		 * other board has the same board_serial and 3 others have
>> +		 * the same default product_name. Also the GPDwin is the
>> +		 * only device to have both board_ and product_name not set.
>> +		 */
>> +		.driver_data = "80860F14:2",
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>> +			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
> 
> I can't accept that this is an accurate way to identify the board.

Well as I already mentioned when I first submitted this patch-set this
patch-set fixes a regression. When I first installed Linux on this
system, the wifi just worked, until this commit got merged:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=db52d4f8a4bde36263a7cc9d46ff20b243562ac9

Given the kernel's no regressions policy I see only 2 ways to fix this
something like this patch, or revert the commit causing the regression.

In the CHT dstd's I have 6 out of 8 use the 80860F14 HID rather then
the INT33BB HID one, so reverting the commit causing this regression
is not really an option.

Note that the quirk not only matches on DMI strings, but also on the
80860F14:2 pair, further narrowing the chance for duplicate matches.

I've access to 29 dmi dumps of Bay / Cherry Trail tablets now and
only 3 match DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation") (*),
and only 1 out of 29 (the GPD win) matches DMI_MATCH(DMI_BOARD_NAME,
"Default string") so after 2 of the 5 checks (including the UID
check) we already have only the GPD win matching.

Regards,

Hans



*) This is different from the comment block, I've been deliberately
looking for dmi dumps with a board_vendor of "AMI Corporation"
