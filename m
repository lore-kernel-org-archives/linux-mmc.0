From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 00/13] mmc: Some Braswell and misc patches
Date: Wed, 24 Sep 2014 10:45:54 +0300
Message-ID: <542276B2.6010201@intel.com>
References: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com> <CAPDyKFp9u1ausSkzo9wEM1YRH5aJb6BXmPmToncpgx5P95Rx-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29831 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbaIXHp5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Sep 2014 03:45:57 -0400
In-Reply-To: <CAPDyKFp9u1ausSkzo9wEM1YRH5aJb6BXmPmToncpgx5P95Rx-A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 23/09/2014 10:34 a.m., Ulf Hansson wrote:
> On 22 September 2014 12:17, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Hi
>>
>> Here are some patches to further support for Intel Braswell
>> SoC plus some miscellaneous changes.
>>
>> The patches needed for Braswell are:
>>
>>        mmc: sdhci: Add quirk for always getting TC with stop cmd
>>        mmc: sdhci-acpi: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel host controllers
>>        mmc: sdhci-acpi: Add a HID and UID for a SD Card host controller
>>        mmc: sdhci-pci: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel BYT host controllers
>>        mmc: sdhci-pci: Add Bay Trail and Braswell SD card detect
>>        mmc: sdhci: Let a driver override timeout clock frequency
>>        mmc: sdhci-pci: Fix Braswell eMMC timeout clock frequency
>>
>
> The above seems like a good argument to at least split this patchset
> into two pieces, could you please do that?

OK, split into 2 patch sets:

	http://marc.info/?l=linux-mmc&m=141150256610085&w=2
	http://marc.info/?l=linux-mmc&m=141154429821225&w=2

>
> Kind regards
> Uffe
>
>>
>> Adrian Hunter (13):
>>        mmc: Fix use of wrong device in mmc_gpiod_free_cd()
>>        mmc: Fix incorrect warning when setting 0 Hz via debugfs
>>        mmc: It is not an error for the card to be removed while suspended
>>        mmc: block: Fix error recovery stop cmd timeout calculation
>>        mmc: block: Fix SD card stop cmd response type
>>        mmc: sdhci: Add quirk for always getting TC with stop cmd
>>        mmc: sdhci-acpi: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel host controllers
>>        mmc: sdhci-acpi: Add a HID and UID for a SD Card host controller
>>        mmc: sdhci-pci: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel BYT host controllers
>>        mmc: sdhci-pci: Add Bay Trail and Braswell SD card detect
>>        mmc: sdhci: Let a driver override timeout clock frequency
>>        mmc: sdhci-pci: Fix Braswell eMMC timeout clock frequency
>>        mmc: sdhci: Transfer Complete has higher priority than Data Timeout Error
>>
>>   drivers/mmc/card/block.c      | 30 ++++++++++++++++++++++++------
>>   drivers/mmc/core/core.c       |  2 +-
>>   drivers/mmc/core/mmc.c        |  2 +-
>>   drivers/mmc/core/sd.c         |  2 +-
>>   drivers/mmc/core/slot-gpio.c  |  2 +-
>>   drivers/mmc/host/sdhci-acpi.c |  6 ++++--
>>   drivers/mmc/host/sdhci-pci.c  | 28 +++++++++++++++++++++++++---
>>   drivers/mmc/host/sdhci-pci.h  |  4 ++++
>>   drivers/mmc/host/sdhci.c      | 27 +++++++++++++++++++--------
>>   include/linux/mmc/sdhci.h     |  2 ++
>>   10 files changed, 82 insertions(+), 23 deletions(-)
>>
>>
>> Regards
>> Adrian
