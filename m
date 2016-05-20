From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-acpi: Ensure connected devices are powered
 when probing
Date: Fri, 20 May 2016 16:04:43 +0200
Message-ID: <CAPDyKFozFyh-P0Vyvkstjm5z-6RtAKGzcADTZG2WnmZSGvTcwg@mail.gmail.com>
References: <1463664342-19209-1-git-send-email-ulf.hansson@linaro.org>
	<1463664342-19209-2-git-send-email-ulf.hansson@linaro.org>
	<573EB712.4030504@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <573EB712.4030504@intel.com>
Sender: stable-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Laszlo Fiat <laszlo.fiat@gmail.com>, Nicholas Krause <xerofoify@gmail.com>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20 May 2016 at 09:04, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 19/05/16 16:25, Ulf Hansson wrote:
>> From: Adrian Hunter <adrian.hunter@intel.com>
>>
>> Some devices connected to the SDHCI controller may have separate enabling
>> lines that are controlled through GPIO. These devices need to be powered
>> on and enabled before probing. This is to ensure all devices connected can
>> be seen by the controller.
>>
>
> I have noticed that stable can get dependent patches the wrong way around
> (breaking bisectability) when they are not explicitly defined as dependent.
> For that reason, I was going to put the EXPORT of acpi_device_fix_up_power()
> into this patch.
>
> I think we need at least to mention in this patch that it is dependent on
> the other patch.

I do that..

>
> Also I have more information here:
>
> Reported-by: Laszlo Fiat <laszlo.fiat@gmail.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=112571
> Link: http://lkml.kernel.org/r/CA+7w51inLtQSr656bJvOjGG9oQWKYPXH+xxDPJKbeJ=CcrkS9Q@mail.gmail.com
>

...and add this.

>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Tested-by: Laszlo Fiat <laszlo.fiat@gmail.com>
>> Cc: <stable@vger.kernel.org> # 4.5+
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied for fixes!

Thanks and kind regards
Uffe

>> ---
>>  drivers/mmc/host/sdhci-acpi.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index b2d70ba..2d1c4870 100644
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
>
