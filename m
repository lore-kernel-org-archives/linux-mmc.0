From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 00/11] mmc: Add support for drive strength for eMMCs
Date: Mon, 11 May 2015 12:23:43 +0200
Message-ID: <CAPDyKFoZ6+MzHL=iu2OXG1Hj+ctVVSbFW5r_2ZYwHO50tgreew@mail.gmail.com>
References: <1423224781-27076-1-git-send-email-adrian.hunter@intel.com>
	<55507660.4010307@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33775 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbbEKKXp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 06:23:45 -0400
Received: by qkx62 with SMTP id 62so83348986qkx.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 03:23:43 -0700 (PDT)
In-Reply-To: <55507660.4010307@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>

On 11 May 2015 at 11:29, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 06/02/15 14:12, Adrian Hunter wrote:
>> Hi
>>
>> Here is V2 of some patches to enable a host controller to select
>> driver strength for eMMCs using HS200 or HS400. These are based
>> on top of the re-tuning series.
>>
>> There can be some confusion over the term "driver strength".
>> SD calls it "drive strength" for the card but "driver type"
>> for the host. Whereas JEDEC calls it both "driver strength"
>> and "driver type". The values are the same for both SD
>> and eMMC:
>>
>>   Value   Driver Type   Relative strength
>>     0       B             x1  default and mandatory support
>>     1       A             x1.5
>>     2       C             x0.75
>>     3       D             x0.5
>>
>> Except eMMC also defines value 4:
>>
>>   Value   Driver Type   Relative strength
>>     4                     x1.2
>>
>>
>> Changes in V2:
>>
>>     mmc: core: Add function to read driver-strength device property
>>         Dropped because there are still questions over how to use
>>         device properties.
>>
>>     mmc: sdhci-pci: Add support for drive strength selection for SPT
>>         Amended to reflect the change above.
>>
>>
>> Adrian Hunter (11):
>>       mmc: core: Reset driver type to default
>>       mmc: core: Allow card drive strength to be different to host
>>       mmc: core: Simplify card drive strength mask
>>       mmc: core: Add 'card' to drive strength selection callback
>>       mmc: core: Factor out common code in drive strength selection
>>       mmc: core: Record card drive strength
>>       mmc: mmc: Read card's valid driver strength mask
>>       mmc: mmc: Add driver strength selection
>>       mmc: sdhci: Add a callback to select drive strength
>>       mmc: sdhci-pci: Add support for drive strength selection for SPT
>>       mmc: sdhci-pci: Enable HS400 for some Intel host controllers
>>
>>  drivers/mmc/core/core.c            | 39 ++++++++++++++++++
>>  drivers/mmc/core/core.h            |  2 +
>>  drivers/mmc/core/mmc.c             | 46 +++++++++++++++++----
>>  drivers/mmc/core/sd.c              | 69 ++++++++-----------------------
>>  drivers/mmc/core/sdio.c            | 77 +++++++++++-----------------------
>>  drivers/mmc/host/sdhci-pci-data.c  |  3 ++
>>  drivers/mmc/host/sdhci-pci.c       | 84 ++++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/sdhci-pci.h       |  4 ++
>>  drivers/mmc/host/sdhci.c           | 13 ++++++
>>  drivers/mmc/host/sdhci.h           |  4 ++
>>  include/linux/mmc/card.h           |  2 +
>>  include/linux/mmc/host.h           |  4 +-
>>  include/linux/mmc/mmc.h            |  4 ++
>>  include/linux/mmc/sdhci-pci-data.h |  2 +
>>  14 files changed, 240 insertions(+), 113 deletions(-)
>
> Hi Ulf
>
> These patches still apply. Would have time to look at them?

Thanks for the reminder!

I am walking through my backlog, but I don't want to give you any
promises about when, since I never seems to be able to keep them. :-)

Kind regards
Uffe
