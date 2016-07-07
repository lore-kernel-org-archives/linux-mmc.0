From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Add support for Intel KBP
Date: Thu, 7 Jul 2016 12:04:21 +0300
Message-ID: <577E1B15.8080503@intel.com>
References: <1466594353-13730-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFpSMJ-StCwNdk-w8g44tBfZKF8y6Au2mxEiAa7uSjSG_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:63544 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757111AbcGGJJl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Jul 2016 05:09:41 -0400
In-Reply-To: <CAPDyKFpSMJ-StCwNdk-w8g44tBfZKF8y6Au2mxEiAa7uSjSG_A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 22/06/16 18:24, Ulf Hansson wrote:
> On 22 June 2016 at 13:19, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Add PCI ID for Intel KBP SD host controller.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Thanks, applied for next!

It turns out this ID is wrong!  Can you please drop this patch from next?

> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/host/sdhci-pci-core.c | 8 ++++++++
>>  drivers/mmc/host/sdhci-pci.h      | 1 +
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index a4dbf7421edc..5b03a7ecc6c9 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -1215,6 +1215,14 @@ static const struct pci_device_id pci_ids[] = {
>>         },
>>
>>         {
>> +               .vendor         = PCI_VENDOR_ID_INTEL,
>> +               .device         = PCI_DEVICE_ID_INTEL_KBP_SD,
>> +               .subvendor      = PCI_ANY_ID,
>> +               .subdevice      = PCI_ANY_ID,
>> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_sd,
>> +       },
>> +
>> +       {
>>                 .vendor         = PCI_VENDOR_ID_O2,
>>                 .device         = PCI_DEVICE_ID_O2_8120,
>>                 .subvendor      = PCI_ANY_ID,
>> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
>> index 89e7151684a1..968b81ed8e4d 100644
>> --- a/drivers/mmc/host/sdhci-pci.h
>> +++ b/drivers/mmc/host/sdhci-pci.h
>> @@ -34,6 +34,7 @@
>>  #define PCI_DEVICE_ID_INTEL_APL_SD     0x5aca
>>  #define PCI_DEVICE_ID_INTEL_APL_EMMC   0x5acc
>>  #define PCI_DEVICE_ID_INTEL_APL_SDIO   0x5ad0
>> +#define PCI_DEVICE_ID_INTEL_KBP_SD     0xa2f5
>>
>>  /*
>>   * PCI registers
>> --
>> 1.9.1
>>
> 

