From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: Only powered up enabled acpi child
 devices
Date: Thu, 12 Jan 2017 12:50:39 +0200
Message-ID: <ef2505cf-198e-4950-ae61-3c72fcb1fc68@intel.com>
References: <20161220231919.10458-1-hdegoede@redhat.com>
 <CAPDyKFoR=W=wqt_mQua9XKB_zXzAPHSgh_c=shxAzjQpiEQg4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4433 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750904AbdALK4T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Jan 2017 05:56:19 -0500
In-Reply-To: <CAPDyKFoR=W=wqt_mQua9XKB_zXzAPHSgh_c=shxAzjQpiEQg4g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 12/01/17 12:03, Ulf Hansson wrote:
> On 21 December 2016 at 00:19, Hans de Goede <hdegoede@redhat.com> wrote:
>> Commit e5bbf30733f9 ("mmc: sdhci-acpi: Ensure connected devices are
>> powered when probing") introduced code to powerup any acpi child
>> nodes listed in the dstd. But some dstd-s list all possible devices
>> used on some board variants, while reporting if the device is actually
>> present and enabled in the status field of the device.
>>
>> So we end up calling the acpi _PS0 (power-on) method for devices which
>> are not actually present. This does not always end well, e.g. on my
>> cube iwork8 air tablet, this results in freezing the entire tablet as
>> soon as the r8723bs module is loaded.
>>
>> This commit fixes this by checking the child device's status.present
>> and status.enabled bits and only call acpi_device_fix_up_power()
>> if both are set.
>>
>> Fixes: e5bbf30733f9 ("mmc: sdhci-acpi: Ensure connected devices are powered when probing")
>> BugLink: https://github.com/hadess/rtl8723bs/issues/80
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Seems like I should add stable tag to this as well!?

Yes I think so.

> 
>> ---
>>  drivers/mmc/host/sdhci-acpi.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index 92096db..34ee237 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -396,7 +396,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>         /* Power on the SDHCI controller and its children */
>>         acpi_device_fix_up_power(device);
>>         list_for_each_entry(child, &device->children, node)
>> -               acpi_device_fix_up_power(child);
>> +               if (child->status.present && child->status.enabled)
>> +                       acpi_device_fix_up_power(child);
>>
>>         if (acpi_bus_get_status(device) || !device->status.present)
>>                 return -ENODEV;
>> --
>> 2.9.3
>>
> 
> Adrian, are you happy with this fix?

Yes.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

