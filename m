From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: Add support for Intel KBP
Date: Tue, 12 Jul 2016 12:08:00 +0200
Message-ID: <CAPDyKFpfbS1uuX=C+KQkThejBQRxyay=Tf22JPe+xLhiw3Oyig@mail.gmail.com>
References: <1466594353-13730-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFpSMJ-StCwNdk-w8g44tBfZKF8y6Au2mxEiAa7uSjSG_A@mail.gmail.com> <577E1B15.8080503@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38465 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbcGLKIC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2016 06:08:02 -0400
Received: by mail-wm0-f48.google.com with SMTP id o80so18663999wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2016 03:08:01 -0700 (PDT)
In-Reply-To: <577E1B15.8080503@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 7 July 2016 at 11:04, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 22/06/16 18:24, Ulf Hansson wrote:
>> On 22 June 2016 at 13:19, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> Add PCI ID for Intel KBP SD host controller.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> Thanks, applied for next!
>
> It turns out this ID is wrong!  Can you please drop this patch from next?

I have dropped it from my next branch, sorry for the delay!

Kind regards
Uffe

>
>>
>> Kind regards
>> Uffe
>>
>>> ---
>>>  drivers/mmc/host/sdhci-pci-core.c | 8 ++++++++
>>>  drivers/mmc/host/sdhci-pci.h      | 1 +
>>>  2 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>>> index a4dbf7421edc..5b03a7ecc6c9 100644
>>> --- a/drivers/mmc/host/sdhci-pci-core.c
>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>>> @@ -1215,6 +1215,14 @@ static const struct pci_device_id pci_ids[] = {
>>>         },
>>>
>>>         {
>>> +               .vendor         = PCI_VENDOR_ID_INTEL,
>>> +               .device         = PCI_DEVICE_ID_INTEL_KBP_SD,
>>> +               .subvendor      = PCI_ANY_ID,
>>> +               .subdevice      = PCI_ANY_ID,
>>> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_sd,
>>> +       },
>>> +
>>> +       {
>>>                 .vendor         = PCI_VENDOR_ID_O2,
>>>                 .device         = PCI_DEVICE_ID_O2_8120,
>>>                 .subvendor      = PCI_ANY_ID,
>>> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
>>> index 89e7151684a1..968b81ed8e4d 100644
>>> --- a/drivers/mmc/host/sdhci-pci.h
>>> +++ b/drivers/mmc/host/sdhci-pci.h
>>> @@ -34,6 +34,7 @@
>>>  #define PCI_DEVICE_ID_INTEL_APL_SD     0x5aca
>>>  #define PCI_DEVICE_ID_INTEL_APL_EMMC   0x5acc
>>>  #define PCI_DEVICE_ID_INTEL_APL_SDIO   0x5ad0
>>> +#define PCI_DEVICE_ID_INTEL_KBP_SD     0xa2f5
>>>
>>>  /*
>>>   * PCI registers
>>> --
>>> 1.9.1
>>>
>>
>
