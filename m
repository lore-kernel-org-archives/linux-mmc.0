From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-acpi: Check device status before calling
 fix_up_power()
Date: Fri, 3 Mar 2017 14:59:50 +0100
Message-ID: <a46e24de-7f55-51c8-8144-865a94637fa0@redhat.com>
References: <20170225172357.26294-1-hdegoede@redhat.com>
 <20170225172357.26294-3-hdegoede@redhat.com>
 <20170303100905.090e0364@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbdCCOIE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Mar 2017 09:08:04 -0500
In-Reply-To: <20170303100905.090e0364@endymion>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jean Delvare <jdelvare@suse.com>, Takashi Iwai <tiwai@suse.de>, russianneuromancer@ya.ru, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Hi,

On 03-03-17 10:09, Jean Delvare wrote:
> Hi Hans, Adrian,
>
> On Sat, 25 Feb 2017 18:23:56 +0100, Hans de Goede wrote:
>> Calling acpi_device_fix_up_power() on a device which is not present
>> is not a good idea.
>
> How bad is it?

Not that bad really, thinking more about this, since drivers/mmc/host/sdhci-acpi.c
is a platform driver, its probe function will never get called if
!device->status.present, since the acpi-subsys then will not
instantiate a platform device for the acpi-dev in question at all.

So a better fix would be to just drop the superfluous
check. I'll send a new version doing this.

Regards,

Hans


>
> This was introduced by commit e5bbf30733f9, which was backported to
> several stable branches. If it causes real trouble then this fix-up
> patch should be annotated with
>
> Fixes: e5bbf30733f9 ("mmc: sdhci-acpi: Ensure connected devices are powered when")
>
> and Cc's to stable@, so it can be propagated to all affected trees.
>
>> While at it also call acpi_bus_get_status() on the children before
>> the status check to make sure that child->status contains valid data.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/mmc/host/sdhci-acpi.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index 96465ff..873beae 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -394,15 +394,15 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>  	if (acpi_bus_get_device(handle, &device))
>>  		return -ENODEV;
>>
>> +	if (acpi_bus_get_status(device) || !device->status.present)
>> +		return -ENODEV;
>> +
>>  	/* Power on the SDHCI controller and its children */
>>  	acpi_device_fix_up_power(device);
>>  	list_for_each_entry(child, &device->children, node)
>>  		if (child->status.present && child->status.enabled)
>>  			acpi_device_fix_up_power(child);
>>
>> -	if (acpi_bus_get_status(device) || !device->status.present)
>> -		return -ENODEV;
>> -
>>  	if (sdhci_acpi_byt_defer(dev))
>>  		return -EPROBE_DEFER;
>>
>
>
