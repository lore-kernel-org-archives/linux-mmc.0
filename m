From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 00/11] mmc: Add support for drive strength for eMMCs
Date: Mon, 25 May 2015 10:44:34 +0200
Message-ID: <CAPDyKFoNHvrnPadxkJoYTG6ELOL69ggBKszM5=-jseiOMjnPdA@mail.gmail.com>
References: <1423224781-27076-1-git-send-email-adrian.hunter@intel.com>
	<55507660.4010307@intel.com>
	<CAPDyKFoZ6+MzHL=iu2OXG1Hj+ctVVSbFW5r_2ZYwHO50tgreew@mail.gmail.com>
	<5562C8E6.4050508@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33705 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbbEYIof (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2015 04:44:35 -0400
Received: by qkgv12 with SMTP id v12so59767249qkg.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2015 01:44:34 -0700 (PDT)
In-Reply-To: <5562C8E6.4050508@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>

On 25 May 2015 at 09:01, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 11/05/15 13:23, Ulf Hansson wrote:
>> On 11 May 2015 at 11:29, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 06/02/15 14:12, Adrian Hunter wrote:
>>>> Hi
>>>>
>>>> Here is V2 of some patches to enable a host controller to select
>>>> driver strength for eMMCs using HS200 or HS400. These are based
>>>> on top of the re-tuning series.
>>>>
>>>> There can be some confusion over the term "driver strength".
>>>> SD calls it "drive strength" for the card but "driver type"
>>>> for the host. Whereas JEDEC calls it both "driver strength"
>>>> and "driver type". The values are the same for both SD
>>>> and eMMC:
>>>>
>>>>   Value   Driver Type   Relative strength
>>>>     0       B             x1  default and mandatory support
>>>>     1       A             x1.5
>>>>     2       C             x0.75
>>>>     3       D             x0.5
>>>>
>>>> Except eMMC also defines value 4:
>>>>
>>>>   Value   Driver Type   Relative strength
>>>>     4                     x1.2
>>>>
>>>>
>>>> Changes in V2:
>>>>
>>>>     mmc: core: Add function to read driver-strength device property
>>>>         Dropped because there are still questions over how to use
>>>>         device properties.
>>>>
>>>>     mmc: sdhci-pci: Add support for drive strength selection for SPT
>>>>         Amended to reflect the change above.
>>>>
>>>>
>>>> Adrian Hunter (11):
>>>>       mmc: core: Reset driver type to default
>>>>       mmc: core: Allow card drive strength to be different to host
>>>>       mmc: core: Simplify card drive strength mask
>>>>       mmc: core: Add 'card' to drive strength selection callback
>>>>       mmc: core: Factor out common code in drive strength selection
>>>>       mmc: core: Record card drive strength
>>>>       mmc: mmc: Read card's valid driver strength mask
>>>>       mmc: mmc: Add driver strength selection
>>>>       mmc: sdhci: Add a callback to select drive strength
>>>>       mmc: sdhci-pci: Add support for drive strength selection for SPT
>>>>       mmc: sdhci-pci: Enable HS400 for some Intel host controllers
>>>>
>>>>  drivers/mmc/core/core.c            | 39 ++++++++++++++++++
>>>>  drivers/mmc/core/core.h            |  2 +
>>>>  drivers/mmc/core/mmc.c             | 46 +++++++++++++++++----
>>>>  drivers/mmc/core/sd.c              | 69 ++++++++-----------------------
>>>>  drivers/mmc/core/sdio.c            | 77 +++++++++++-----------------------
>>>>  drivers/mmc/host/sdhci-pci-data.c  |  3 ++
>>>>  drivers/mmc/host/sdhci-pci.c       | 84 ++++++++++++++++++++++++++++++++++++++
>>>>  drivers/mmc/host/sdhci-pci.h       |  4 ++
>>>>  drivers/mmc/host/sdhci.c           | 13 ++++++
>>>>  drivers/mmc/host/sdhci.h           |  4 ++
>>>>  include/linux/mmc/card.h           |  2 +
>>>>  include/linux/mmc/host.h           |  4 +-
>>>>  include/linux/mmc/mmc.h            |  4 ++
>>>>  include/linux/mmc/sdhci-pci-data.h |  2 +
>>>>  14 files changed, 240 insertions(+), 113 deletions(-)
>>>
>>> Hi Ulf
>>>
>>> These patches still apply. Would have time to look at them?
>>
>> Thanks for the reminder!
>>
>> I am walking through my backlog, but I don't want to give you any
>> promises about when, since I never seems to be able to keep them. :-)
>
> Hi
>
> Here's another reminder :-)

Thanks! :-)

>
> I would really like these patches and there is really not much to review.
>
> Patch 1 is quite trivial - only 1 line changed.
>
> Patch 2 is a change the select_drive_strength() host op to allow card driver
> strength to be different from host driver strength. It has no effect on
> current drivers.
>
> Patch 3 is just tidying up.
>
> Patch 4 is another change to the select_drive_strength() host op (to add
> 'card' as a parameter) and also has no effect on current drivers.
>
> Patch 5 is another tidy up.
>
> Patch 6 is a very small patch to add drive_strength to struct mmc_card.
>
> Patch 7 is a very small change to read eMMC supported driver strengths from
> EXT-CSD.
>
> Patch 8 adds driver strength selection for eMMC
>
> Patch 9, 10 implement the select_drive_strength() for Intel SPT with the
> sdhci-pci driver.
>
> Patch 11 finally just enables HS400 for Intel
>
> This shouldn't really take that long to review ;-)

No it didn't and it looks nice! Applied for next!

Thanks!

Kind regards
Uffe
