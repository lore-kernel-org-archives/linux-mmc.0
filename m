From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 2/2] mmc: sdhci-acpi: Add DMI based blacklist
Date: Wed, 21 Jun 2017 10:56:45 +0200
Message-ID: <e85e4d96-698c-0c34-2fce-bdbd24528fed@redhat.com>
References: <20170608185500.3317-1-hdegoede@redhat.com>
 <20170608185500.3317-2-hdegoede@redhat.com>
 <515f2626-6224-f913-30e3-71b796fea61b@intel.com>
 <aa7bdfea-ab41-7b74-1153-112962a65287@redhat.com>
 <1b9deb37-1de0-d019-c325-68916ead29d0@intel.com>
 <b88174e6-a099-5b56-8746-0b3f1b037cb6@redhat.com>
 <625040a0-c64f-11dd-f8db-dbf32a7f8fc1@redhat.com>
 <42f5c7f6-dd83-5d39-7487-14e4e718684d@intel.com>
 <9fb7e843-4c8d-63bd-300a-24846a7724ba@redhat.com>
 <c9b4cc92-a30b-670b-339d-d6c30b0b104f@intel.com>
 <9e1aa5f3-b880-990c-2844-826afc91a45f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752839AbdFUI4s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Jun 2017 04:56:48 -0400
In-Reply-To: <9e1aa5f3-b880-990c-2844-826afc91a45f@redhat.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hi,

On 19-06-17 16:07, Hans de Goede wrote:
> Hi,
> 
> On 19-06-17 13:59, Adrian Hunter wrote:

<snip>

>>>> Perhaps there is something else we can match on, like the presence of the
>>>> PCIe wifi device since we only use SDIO for wifi.  Can you send a copy of
>>>> the ACPI DSDT table, or an acpidump file.  Also lspci output.

<snip>

>> Does this work?
> 
> I'm happy to report that yes it does. If you prefer this solution
> then that is fine by me:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>

So what is the plan moving forward with this ?

Yesterday I was running some tests on a GPD-win a friend recently bought and
I hit this issue again, my usb-disk with a test-install was running my solution
with the BIOS date check and that failed because his model had a new BIOS
build and thus a different date. So I believe that this patch is better
then mine as it won't break with BIOS updates and avoids us needing to
patch the quirk table all the time.

As such I would like to see us move forward with this patch and get it
merged for 4.13 (with a Cc stable) so that we can finally get this
regression fixed.

Adrian, can you do an official submission of this patch (with my ack
and tested-by) so that Ulf can merge this ?

Regards,

Hans



>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index cf66a3db71b8..ac678e9fb19a 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -45,6 +45,7 @@
>>   #include <asm/cpu_device_id.h>
>>   #include <asm/intel-family.h>
>>   #include <asm/iosf_mbi.h>
>> +#include <linux/pci.h>
>>   #endif
>>   #include "sdhci.h"
>> @@ -134,6 +135,16 @@ static bool sdhci_acpi_byt(void)
>>       return x86_match_cpu(byt);
>>   }
>> +static bool sdhci_acpi_cht(void)
>> +{
>> +    static const struct x86_cpu_id cht[] = {
>> +        { X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_AIRMONT },
>> +        {}
>> +    };
>> +
>> +    return x86_match_cpu(cht);
>> +}
>> +
>>   #define BYT_IOSF_SCCEP            0x63
>>   #define BYT_IOSF_OCP_NETCTRL0        0x1078
>>   #define BYT_IOSF_OCP_TIMEOUT_BASE    GENMASK(10, 8)
>> @@ -178,6 +189,45 @@ static bool sdhci_acpi_byt_defer(struct device *dev)
>>       return false;
>>   }
>> +static bool sdhci_acpi_cht_pci_wifi(unsigned int vendor, unsigned int device,
>> +                    unsigned int slot, unsigned int parent_slot)
>> +{
>> +    struct pci_dev *dev, *parent, *from = NULL;
>> +
>> +    while (1) {
>> +        dev = pci_get_device(vendor, device, from);
>> +        pci_dev_put(from);
>> +        if (!dev)
>> +            break;
>> +        parent = pci_upstream_bridge(dev);
>> +        if (ACPI_COMPANION(&dev->dev) && PCI_SLOT(dev->devfn) == slot &&
>> +            parent && PCI_SLOT(parent->devfn) == parent_slot &&
>> +            !pci_upstream_bridge(parent)) {
>> +            pci_dev_put(dev);
>> +            return true;
>> +        }
>> +        from = dev;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +/*
>> + * GPDwin uses PCI wifi which conflicts with SDIO's use of
>> + * acpi_device_fix_up_power() on child device nodes. Identifying GPDwin is
>> + * problematic, but since SDIO is only used for wifi, the presence of the PCI
>> + * wifi card in the expected slot with an ACPI companion node, is used to
>> + * indicate that acpi_device_fix_up_power() should be avoided.
>> + */
>> +static inline bool sdhci_acpi_no_fixup_child_power(const char *hid,
>> +                           const char *uid)
>> +{
>> +    return sdhci_acpi_cht() &&
>> +           !strcmp(hid, "80860F14") &&
>> +           !strcmp(uid, "2") &&
>> +           sdhci_acpi_cht_pci_wifi(0x14e4, 0x43ec, 0, 28);
>> +}
>> +
>>   #else
>>   static inline void sdhci_acpi_byt_setting(struct device *dev)
>> @@ -189,6 +239,12 @@ static inline bool sdhci_acpi_byt_defer(struct device *dev)
>>       return false;
>>   }
>> +static inline bool sdhci_acpi_no_fixup_child_power(const char *hid,
>> +                           const char *uid)
>> +{
>> +    return false;
>> +}
>> +
>>   #endif
>>   static int bxt_get_cd(struct mmc_host *mmc)
>> @@ -389,18 +445,20 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>       if (acpi_bus_get_device(handle, &device))
>>           return -ENODEV;
>> +    hid = acpi_device_hid(device);
>> +    uid = device->pnp.unique_id;
>> +
>>       /* Power on the SDHCI controller and its children */
>>       acpi_device_fix_up_power(device);
>> -    list_for_each_entry(child, &device->children, node)
>> -        if (child->status.present && child->status.enabled)
>> -            acpi_device_fix_up_power(child);
>> +    if (!sdhci_acpi_no_fixup_child_power(hid, uid)) {
>> +        list_for_each_entry(child, &device->children, node)
>> +            if (child->status.present && child->status.enabled)
>> +                acpi_device_fix_up_power(child);
>> +    }
>>       if (sdhci_acpi_byt_defer(dev))
>>           return -EPROBE_DEFER;
>> -    hid = acpi_device_hid(device);
>> -    uid = device->pnp.unique_id;
>> -
>>       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>       if (!iomem)
>>           return -ENOMEM;
>>
