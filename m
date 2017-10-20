From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/4] mmc: sdhci-acpi: Fix voltage switch for some Intel
 host controllers
Date: Fri, 20 Oct 2017 14:11:36 +0300
Message-ID: <59b7c161-d83a-0db5-f781-ee337841fdd1@intel.com>
References: <1508409706-27026-1-git-send-email-adrian.hunter@intel.com>
 <1508409706-27026-5-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFr75-Z6pcRJQT3tiPfXniwX69O9j8ZSUyisAZbrvAbBJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21559 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752774AbdJTLS2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Oct 2017 07:18:28 -0400
In-Reply-To: <CAPDyKFr75-Z6pcRJQT3tiPfXniwX69O9j8ZSUyisAZbrvAbBJw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 20/10/17 12:16, Ulf Hansson wrote:
> On 19 October 2017 at 12:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Some Intel host controllers use an ACPI device-specific method to ensure
>> correct voltage switching. Fix voltage switch for those, by adding a call
>> to the DSM.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/sdhci-acpi.c | 108 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 108 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index 5bb5880403b2..b988997a1e80 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -96,6 +96,105 @@ static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
>>         return c->slot && (c->slot->flags & flag);
>>  }
>>
>> +enum {
>> +       INTEL_DSM_FNS           =  0,
>> +       INTEL_DSM_V18_SWITCH    =  3,
>> +       INTEL_DSM_V33_SWITCH    =  4,
>> +};
>> +
>> +struct intel_host {
>> +       u32     dsm_fns;
>> +};
>> +
>> +static const guid_t intel_dsm_guid =
>> +       GUID_INIT(0xF6C13EA5, 0x65CD, 0x461F,
>> +                 0xAB, 0x7A, 0x29, 0xF7, 0xE8, 0xD5, 0xBD, 0x61);
>> +
>> +static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
>> +                      unsigned int fn, u32 *result)
>> +{
>> +       union acpi_object *obj;
>> +       int err = 0;
>> +
>> +       obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &intel_dsm_guid, 0, fn, NULL);
>> +       if (!obj)
>> +               return -EOPNOTSUPP;
>> +
>> +       if (obj->type == ACPI_TYPE_INTEGER) {
>> +               *result = obj->integer.value;
>> +       } else if (obj->type == ACPI_TYPE_BUFFER && obj->buffer.length > 0) {
>> +               size_t len = min_t(size_t, obj->buffer.length, 4);
>> +
>> +               *result = 0;
>> +               memcpy(result, obj->buffer.pointer, len);
>> +       } else {
>> +               dev_err(dev, "%s DSM fn %u obj->type %d obj->buffer.length %d\n",
>> +                       __func__, fn, obj->type, obj->buffer.length);
>> +               err = -EINVAL;
>> +       }
>> +
> 
> This hole ACPI thing looks weird.

DSMs are normal.

>                                   Could perhaps the ACPI core, model
> this a vqmmc regulator instead?

The regulator framework does not support that.

> 
> That would keep the ACPI specific part closer to ACPI and we can treat
> this similar to other mmc host drivers.

Device-specific methods (DSM) are device specific so they belong in the
driver not ACPI core.  So the code would all end up here anyway but be more
complicated and more obfuscated.
