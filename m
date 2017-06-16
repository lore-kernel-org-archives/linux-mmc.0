From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 2/2] mmc: sdhci-acpi: Add DMI based blacklist
Date: Fri, 16 Jun 2017 14:33:41 +0200
Message-ID: <625040a0-c64f-11dd-f8db-dbf32a7f8fc1@redhat.com>
References: <20170608185500.3317-1-hdegoede@redhat.com>
 <20170608185500.3317-2-hdegoede@redhat.com>
 <515f2626-6224-f913-30e3-71b796fea61b@intel.com>
 <aa7bdfea-ab41-7b74-1153-112962a65287@redhat.com>
 <1b9deb37-1de0-d019-c325-68916ead29d0@intel.com>
 <b88174e6-a099-5b56-8746-0b3f1b037cb6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36327 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751909AbdFPMdo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 16 Jun 2017 08:33:44 -0400
In-Reply-To: <b88174e6-a099-5b56-8746-0b3f1b037cb6@redhat.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hi,

On 14-06-17 15:20, Hans de Goede wrote:
> Hi,
> 
> On 14-06-17 09:43, Adrian Hunter wrote:
>> On 12/06/17 16:27, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 12-06-17 14:11, Adrian Hunter wrote:
>>>> On 08/06/17 21:55, Hans de Goede wrote:
>>>>> Add a DMI based blacklist for systems where probing some sdio interfaces
>>>>> is harmful (e.g. causes pci-e based wifi to not work).
>>>>>
>>>>> BugLink: https://bbs.archlinux.org/viewtopic.php?id=224086
>>>>> Fixes: db52d4f8a4bd ("mmc: sdhci-acpi: support 80860F14 UID 2 SDIO bus")
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> -Adjust for changes in mmc: sdhci-acpi: Add fix_up_power_blacklist module
>>>>> option
>>>>> -Only use a single fix_up_power_dmi_blacklist for the GPDwin further testing
>>>>>    has shown that the DMI strings are unique enough that we do not need the
>>>>>    bios-date in there
>>>>>
>>>>> Changes in v3:
>>>>> -Adjust for changes to "mmc: sdhci-acpi: Add blacklist module option"
>>>>>
>>>>> Changes in v4:
>>>>> -Rename blacklist to dmi_probe_blacklist as it now blacklists probing,
>>>>>    rather then calling acpi_device_fix_up_power.
>>>>> -Also check bios-date against known bios-dates for the GPD win, to avoid
>>>>>    possible false positives due to the use of quite generic DMI strings
>>>>> -Add Fixes and BugLink tags
>>>>> ---
>>>>>    drivers/mmc/host/sdhci-acpi.c | 64
>>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 64 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>>>>> index ecc3aefd4643..3e12a6a8ad99 100644
>>>>> --- a/drivers/mmc/host/sdhci-acpi.c
>>>>> +++ b/drivers/mmc/host/sdhci-acpi.c
>>>>> @@ -36,6 +36,7 @@
>>>>>    #include <linux/pm.h>
>>>>>    #include <linux/pm_runtime.h>
>>>>>    #include <linux/delay.h>
>>>>> +#include <linux/dmi.h>
>>>>>      #include <linux/mmc/host.h>
>>>>>    #include <linux/mmc/pm.h>
>>>>> @@ -83,6 +84,11 @@ struct sdhci_acpi_host {
>>>>>        bool                use_runtime_pm;
>>>>>    };
>>>>>    +struct dmi_probe_blacklist_data {
>>>>> +    const char *hid_uid;
>>>>> +    const char * const *bios_dates;
>>>>> +};
>>>>> +
>>>>>    static char *blacklist;
>>>>>      static bool sdhci_acpi_compare_hid_uid(const char *match, const char
>>>>> *hid,
>>>>> @@ -116,6 +122,34 @@ static bool sdhci_acpi_compare_hid_uid(const char
>>>>> *match, const char *hid,
>>>>>        return false;
>>>>>    }
>>>>>    +static const char *sdhci_acpi_get_dmi_blacklist(const struct
>>>>> dmi_system_id *bl)
>>>>> +{
>>>>> +    const struct dmi_system_id *dmi_id;
>>>>> +    const struct dmi_probe_blacklist_data *bl_data;
>>>>> +    const char *bios_date;
>>>>> +    int i;
>>>>> +
>>>>> +    dmi_id = dmi_first_match(bl);
>>>>> +    if (!dmi_id)
>>>>> +        return NULL;
>>>>> +
>>>>> +    bl_data = dmi_id->driver_data;
>>>>> +
>>>>> +    if (!bl_data->bios_dates)
>>>>> +        return bl_data->hid_uid;
>>>>> +
>>>>> +    bios_date = dmi_get_system_info(DMI_BIOS_DATE);
>>>>> +    if (!bios_date)
>>>>> +        return NULL;
>>>>> +
>>>>> +    for (i = 0; bl_data->bios_dates[i]; i++) {
>>>>> +        if (strcmp(bl_data->bios_dates[i], bios_date) == 0)
>>>>> +            return bl_data->hid_uid;
>>>>> +    }
>>>>> +
>>>>> +    return NULL;
>>>>> +}
>>>>> +
>>>>>    static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned
>>>>> int flag)
>>>>>    {
>>>>>        return c->slot && (c->slot->flags & flag);
>>>>> @@ -391,6 +425,33 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>>>>>    };
>>>>>    MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>>>>>    +const struct dmi_probe_blacklist_data gpd_win_bl_data = {
>>>>> +    .hid_uid = "80860F14:2",
>>>>> +    .bios_dates = (const char * const []){
>>>>> +        "10/25/2016", "11/18/2016", "02/21/2017", NULL },
>>>>> +};
>>>>> +
>>>>> +static const struct dmi_system_id dmi_probe_blacklist[] = {
>>>>> +    {
>>>>> +        /*
>>>>> +         * Match for the GPDwin which unfortunately uses somewhat
>>>>> +         * generic dmi strings, which is why we test for 4 strings
>>>>> +         * and a known BIOS date.
>>>>> +         * Comparing against 29 other byt/cht boards, board_name is
>>>>> +         * unique to the GPDwin, where as only 2 other boards have the
>>>>> +         * same board_serial and 3 others have the same board_vendor
>>>>> +         */
>>>>> +        .driver_data = (void *)&gpd_win_bl_data,
>>>>> +        .matches = {
>>>>> +            DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>>>>> +            DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>>>>> +            DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
>>>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>>>>> +        },
>>>>
>>>> To me this is matching by accident rather than by design, which is not
>>>> acceptable.
>>>
>>> I already explained why we need this dmi quirk in your reply of v3,
>>> it would have been nice if you replied there.
>>
>> I understand what you are saying, but that doesn't make the patch
>> acceptable, so I cannot Ack it.
>>
>>>
>>> As I already mentioned when I first submitted this patch-set this
>>> patch-set fixes a regression. When I first installed Linux on this
>>> system, the wifi just worked, until this commit got merged:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=db52d4f8a4bde36263a7cc9d46ff20b243562ac9
>>>
>>>
>>> So that gives us 3 options:
>>
>> In the absence of another solution, the options are:
>>     1. get the BIOS fixed
> 
> a. That is not going to happen (I've already contacted the vendor).
> b. Even if that were to happen, almost no-one will update the BIOS, so
>     this does not help
> 
>>     2. use the module option to blacklist the bad device
> 
> Needing to use a module-option, where before none was necessary
> is still a regression. I've personally had a commit of mine
> reverted by Torvalds himself because I changed something which
> would require the use a of a kernel cmdline option in certain
> corner-cases where no cmdline option was needed before.
> 
> Basically your solutions boil down to my:
> 
>>> 2) Do nothing, live with the regression.
> 
>>> 2. is what you seem to be advocating, but since the kernel has a clear
>>> no regressions policy that is not an option either
> 
> So your advocating we just live with the REGRESSION, because that
> is what this is a REGRESSION and nothing else. That is simply
> not acceptable (and clearly against kernel policy).
> 
> I've compared DMI data to 29 other boards using the same chipset
> to prove the DMI match is unique, then since you are still worried
> about the match being too generic I also added BIOS date checking,
> which certainly makes the match more then unique enough, something to
> which you've not even responded...
> 
> In the mean time users have been suffering from this regression
> for 3 months now:
> https://bbs.archlinux.org/viewtopic.php?id=224086
> 
> I've no words for this, other then that your blocking of fixing
> this REGRESSION, without you even addressing my factual arguments
> why this match is not too generic, vs you're feeling that it is
> too generic, simply is unacceptable.

To be clear, I understand that needing DMI quirks in the first place
is undesirable, and that this vendor using way too generic strings
is adding extra ugliness to the ugliness of needing DMI quirks in
the first place, so I understand your reluctance here.

But to me making this "just" work for users trumps my desire to
avoid ugliness like this. I really want to see Linux used by as much
users as possible and in order for that to happen we need to have
Ubunutu / Fedora just work with their hardware, if users first need
to google a kernel cmdline option, then they will just stop using
Linux.

Regards,

Hans


