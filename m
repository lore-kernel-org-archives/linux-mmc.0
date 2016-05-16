From: Laszlo Fiat <laszlo.fiat@gmail.com>
Subject: Re: [PATCH] mmc: block: Use the mmc host device index as the mmcblk
 device index
Date: Mon, 16 May 2016 18:56:58 +0200
Message-ID: <CA+7w51gbn+nbsk2j-V2sVzupVbkN=7gt9uXeK8ZQdjdOjSSZsA@mail.gmail.com>
References: <1460015861-14004-1-git-send-email-ulf.hansson@linaro.org>
	<CA+7w51h=A4vVjkJTEvNoRG=GRt-GPSwqN4N4P3k-OqnubPo+kg@mail.gmail.com>
	<CAPDyKFp8pfZ1iY7HsAZL1f2qgTuLcimDL_f1k59RMcUq5f-iRQ@mail.gmail.com>
	<570B9C8D.2000600@intel.com>
	<CA+7w51iP3Th-m8kqdx_iObEs+kYJruNd62f5n2OfD0XaeGw=9w@mail.gmail.com>
	<570E2B2D.1080507@intel.com>
	<CA+7w51gUcPz+z8eD8A3dtB7r_Pvr8yO1AjymXC14eq9RgN6skQ@mail.gmail.com>
	<CAPDyKFq=B0PAxCLJgATSzO9zDHR_L7qOVn7PZ0seekbAb0YRPw@mail.gmail.com>
	<57398F0A.7070600@intel.com>
	<5739B261.2010009@intel.com>
	<5739F7C1.707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36291 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbcEPQ5A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2016 12:57:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id w143so19381793wmw.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 May 2016 09:56:59 -0700 (PDT)
In-Reply-To: <5739F7C1.707@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: nick <xerofoify@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

Compiling a new kernel with that patch applied. I will report back
when it is finished.

Bye,

Laszlo Fiat

On Mon, May 16, 2016 at 6:39 PM, nick <xerofoify@gmail.com> wrote:
>
>
> On 2016-05-16 07:43 AM, Adrian Hunter wrote:
>> On 16/05/16 12:12, Adrian Hunter wrote:
>>> On 16/05/16 11:47, Ulf Hansson wrote:
>>>> + Nicholas Krause
>>>>
>>>> On 13 April 2016 at 20:19, Laszlo Fiat <laszlo.fiat@gmail.com> wrote:
>>>>> Adrian, Ulf,
>>>>>
>>>>> Here are the two v4.6-rc3 kernel dmesg with mmc-debug option, both
>>>>> without additional patches, one working case [1], one failing case
>>>>> [2], the working case has patch [3] reverted.
>>>>>
>>>>> I also uploaded the acpidump [4] for Teclast X80h Baytrail-T tablet.
>>>>>
>>>>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=112571#c11
>>>>> [2]: https://bugzilla.kernel.org/show_bug.cgi?id=112571#c10
>>>>> [3]: patch 520bd7a8b4152aacfbd34eb7f7a447354b631039 ("mmc: core:
>>>>> Optimize boot time by detecting cards simultaneously")
>>>>> [4]: https://bugzilla.kernel.org/show_bug.cgi?id=112571#c12
>>>>>
>>>>
>>>> Adrian, did you manage to get some time to look into the debug data
>>>> from this issue?
>>>
>>> Not yet.
>>>
>>>> I understand if you have been busy and no worries, although I don't
>>>> know who else to ping about this.
>>>
>>> I will have a look today.
>>>
>>>>
>>>> I don't want to us revert 520bd7a8b4152aacfbd34eb7f7a447354b631039,
>>>> because I believe it will just hide the problem in sdhci(-acpi).
>>>> Instead, I intend to wait for a proper fix, does that sounds
>>>> reasonable to you as well?
>>>
>>> Sure
>>
>> Here is a patch that might help:
>>
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Date: Mon, 16 May 2016 14:29:51 +0300
>> Subject: [PATCH] mmc: sdhci-acpi: Ensure connected devices are powered on
>>  before probing
>>
>> Some devices connected to the SDHCI controller may have
>> separate enabling lines that are controlled through GPIO.
>> These devices need to be powered on and enabled before
>> probing. This is to ensure all devices connected can be
>> seen by the controller.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/sdhci-acpi.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index b2d70ba6caa7..2d1c4870c285 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -378,7 +378,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>  {
>>       struct device *dev = &pdev->dev;
>>       acpi_handle handle = ACPI_HANDLE(dev);
>> -     struct acpi_device *device;
>> +     struct acpi_device *device, *child;
>>       struct sdhci_acpi_host *c;
>>       struct sdhci_host *host;
>>       struct resource *iomem;
>> @@ -390,6 +390,11 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>       if (acpi_bus_get_device(handle, &device))
>>               return -ENODEV;
>>
>> +     /* Power on the SDHCI controller and its children */
>> +     acpi_device_fix_up_power(device);
>> +     list_for_each_entry(child, &device->children, node)
>> +             acpi_device_fix_up_power(child);
>> +
>>       if (acpi_bus_get_status(device) || !device->status.present)
>>               return -ENODEV;
>>
>>
> That should fix the issue at least to my knowledge. Seems it's related to a regression with
> not probing/fixing the power on certain child devices. However since I don't have any hardware
> that can verify this regression I am unable to help much further.
> Cheers,
> Nick
