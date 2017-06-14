From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 2/2] mmc: sdhci-acpi: Add DMI based blacklist
Date: Wed, 14 Jun 2017 10:43:56 +0300
Message-ID: <1b9deb37-1de0-d019-c325-68916ead29d0@intel.com>
References: <20170608185500.3317-1-hdegoede@redhat.com>
 <20170608185500.3317-2-hdegoede@redhat.com>
 <515f2626-6224-f913-30e3-71b796fea61b@intel.com>
 <aa7bdfea-ab41-7b74-1153-112962a65287@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12197 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754263AbdFNHuG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Jun 2017 03:50:06 -0400
In-Reply-To: <aa7bdfea-ab41-7b74-1153-112962a65287@redhat.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

On 12/06/17 16:27, Hans de Goede wrote:
> Hi,
> 
> On 12-06-17 14:11, Adrian Hunter wrote:
>> On 08/06/17 21:55, Hans de Goede wrote:
>>> Add a DMI based blacklist for systems where probing some sdio interfaces
>>> is harmful (e.g. causes pci-e based wifi to not work).
>>>
>>> BugLink: https://bbs.archlinux.org/viewtopic.php?id=224086
>>> Fixes: db52d4f8a4bd ("mmc: sdhci-acpi: support 80860F14 UID 2 SDIO bus")
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v2:
>>> -Adjust for changes in mmc: sdhci-acpi: Add fix_up_power_blacklist module
>>> option
>>> -Only use a single fix_up_power_dmi_blacklist for the GPDwin further testing
>>>   has shown that the DMI strings are unique enough that we do not need the
>>>   bios-date in there
>>>
>>> Changes in v3:
>>> -Adjust for changes to "mmc: sdhci-acpi: Add blacklist module option"
>>>
>>> Changes in v4:
>>> -Rename blacklist to dmi_probe_blacklist as it now blacklists probing,
>>>   rather then calling acpi_device_fix_up_power.
>>> -Also check bios-date against known bios-dates for the GPD win, to avoid
>>>   possible false positives due to the use of quite generic DMI strings
>>> -Add Fixes and BugLink tags
>>> ---
>>>   drivers/mmc/host/sdhci-acpi.c | 64
>>> +++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 64 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>>> index ecc3aefd4643..3e12a6a8ad99 100644
>>> --- a/drivers/mmc/host/sdhci-acpi.c
>>> +++ b/drivers/mmc/host/sdhci-acpi.c
>>> @@ -36,6 +36,7 @@
>>>   #include <linux/pm.h>
>>>   #include <linux/pm_runtime.h>
>>>   #include <linux/delay.h>
>>> +#include <linux/dmi.h>
>>>     #include <linux/mmc/host.h>
>>>   #include <linux/mmc/pm.h>
>>> @@ -83,6 +84,11 @@ struct sdhci_acpi_host {
>>>       bool                use_runtime_pm;
>>>   };
>>>   +struct dmi_probe_blacklist_data {
>>> +    const char *hid_uid;
>>> +    const char * const *bios_dates;
>>> +};
>>> +
>>>   static char *blacklist;
>>>     static bool sdhci_acpi_compare_hid_uid(const char *match, const char
>>> *hid,
>>> @@ -116,6 +122,34 @@ static bool sdhci_acpi_compare_hid_uid(const char
>>> *match, const char *hid,
>>>       return false;
>>>   }
>>>   +static const char *sdhci_acpi_get_dmi_blacklist(const struct
>>> dmi_system_id *bl)
>>> +{
>>> +    const struct dmi_system_id *dmi_id;
>>> +    const struct dmi_probe_blacklist_data *bl_data;
>>> +    const char *bios_date;
>>> +    int i;
>>> +
>>> +    dmi_id = dmi_first_match(bl);
>>> +    if (!dmi_id)
>>> +        return NULL;
>>> +
>>> +    bl_data = dmi_id->driver_data;
>>> +
>>> +    if (!bl_data->bios_dates)
>>> +        return bl_data->hid_uid;
>>> +
>>> +    bios_date = dmi_get_system_info(DMI_BIOS_DATE);
>>> +    if (!bios_date)
>>> +        return NULL;
>>> +
>>> +    for (i = 0; bl_data->bios_dates[i]; i++) {
>>> +        if (strcmp(bl_data->bios_dates[i], bios_date) == 0)
>>> +            return bl_data->hid_uid;
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>>   static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned
>>> int flag)
>>>   {
>>>       return c->slot && (c->slot->flags & flag);
>>> @@ -391,6 +425,33 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>>>   };
>>>   MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>>>   +const struct dmi_probe_blacklist_data gpd_win_bl_data = {
>>> +    .hid_uid = "80860F14:2",
>>> +    .bios_dates = (const char * const []){
>>> +        "10/25/2016", "11/18/2016", "02/21/2017", NULL },
>>> +};
>>> +
>>> +static const struct dmi_system_id dmi_probe_blacklist[] = {
>>> +    {
>>> +        /*
>>> +         * Match for the GPDwin which unfortunately uses somewhat
>>> +         * generic dmi strings, which is why we test for 4 strings
>>> +         * and a known BIOS date.
>>> +         * Comparing against 29 other byt/cht boards, board_name is
>>> +         * unique to the GPDwin, where as only 2 other boards have the
>>> +         * same board_serial and 3 others have the same board_vendor
>>> +         */
>>> +        .driver_data = (void *)&gpd_win_bl_data,
>>> +        .matches = {
>>> +            DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>>> +            DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>>> +            DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>>> +        },
>>
>> To me this is matching by accident rather than by design, which is not
>> acceptable.
> 
> I already explained why we need this dmi quirk in your reply of v3,
> it would have been nice if you replied there.

I understand what you are saying, but that doesn't make the patch
acceptable, so I cannot Ack it.

> 
> As I already mentioned when I first submitted this patch-set this
> patch-set fixes a regression. When I first installed Linux on this
> system, the wifi just worked, until this commit got merged:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=db52d4f8a4bde36263a7cc9d46ff20b243562ac9
> 
> 
> So that gives us 3 options:

In the absence of another solution, the options are:
	1. get the BIOS fixed
	2. use the module option to blacklist the bad device

> 
> 1) Revert the commit causing the regressions
> 2) Do nothing, live with the regression.
> 3) Add a DMI based quirk
> 
> 1. is not an option since that commit is necessary to make wifi work
> on other devices
> 
> 2. is what you seem to be advocating, but since the kernel has a clear
> no regressions policy that is not an option either
> 
> 3. is thus the only option left.
> 
> So unless you see a 4th option we really need to go with this patch,
> note that in this version I've made the chance of false positives
> for the DMI match even smaller then it was before because it now
> needs to match a know bios-date too.
> 
> Also note that this is being hit be actual users, not just by me, see:
> 
> https://bbs.archlinux.org/viewtopic.php?id=224086


