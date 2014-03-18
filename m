From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/5] update selection of bus speed mode for eMMC
Date: Tue, 18 Mar 2014 09:01:59 +0100
Message-ID: <CAPDyKFqvjSCS4RauREWuG9FphPYxK47Nbh6ewqfi_9qtm2DZ+g@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
	<003a01cf3f7f$2e170210$8a450630$%jun@samsung.com>
	<CAPDyKFphJhmwSJn76J4CTu3WmU-9JPMa_R=v62j-zhx+R8iz-Q@mail.gmail.com>
	<007b01cf424b$82fc58b0$88f50a10$%jun@samsung.com>
	<5327C99B.4020005@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:56468 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbaCRICA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Mar 2014 04:02:00 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so7247097qcx.38
        for <linux-mmc@vger.kernel.org>; Tue, 18 Mar 2014 01:02:00 -0700 (PDT)
In-Reply-To: <5327C99B.4020005@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jackey Shen <jackey.shen@amd.com>, Alim Akhtar <alim.akhtar@samsung.com>

On 18 March 2014 05:20, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 03/18/2014 10:43 AM, Seungwon Jeon wrote:
>> On Mon, March 17, 2014, Ulf Hansson wrote:
>>> On 14 March 2014 13:16, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>>>> This series contains the change for selection of bus speed mode.
>>>> Previous implementation is complicated and some sequence is duplicated.
>>>> And specially, HS400 mode eMMC5.0 is introduced this time.
>>>> This patch-set has been tested in Exynos SoC.
>>>>
>>>> Changes in v3:
>>>>         Removed the function to check DDR type(mmc_snoop_ddr).
>>>>         Rebased with the latest branch.
>>>
>>> I tried to apply patch 1 for Chris' mmc-next branch, but it failed.
>>> Please have a look.
>>
>> It depends on the following patch.
>> Please could you check?
>> [PATCH RESEND v3 1/7] mmc: clarify DDR timing mode between SD-UHS and eMMC

I see, that wasn't obvious since that patch comes from a different patchset.

I would future-wise prefer if you could keep dependencies encapsulated
within a single patchset (unless you explicitly states else,
somewhere). That means one patchset won't prevent another one from
being applied, which is good. :-)

Anyway, I will try it out this time.

Kind regards
Ulf Hansson

>
> I have checked these after applied above patch-set. It's applied fine.
>
> Best Regards,
> Jaehoon Chung
>>
>> Thanks,
>> Seungwon Jeon
>>
>>>
>>> Kind regards
>>> Ulf Hansson
>>>
>>>>
>>>> Seungwon Jeon (5):
>>>>   mmc: drop the speed mode of card's state
>>>>   mmc: identify available device type to select
>>>>   mmc: step power class after final selection of bus mode
>>>>   mmc: rework selection of bus speed mode
>>>>   mmc: add support for HS400 mode of eMMC5.0
>>>>
>>>>  drivers/mmc/core/bus.c     |    9 +-
>>>>  drivers/mmc/core/core.c    |    3 +-
>>>>  drivers/mmc/core/debugfs.c |    5 +-
>>>>  drivers/mmc/core/mmc.c     |  681 +++++++++++++++++++++++++++-----------------
>>>>  drivers/mmc/core/sd.c      |   16 +-
>>>>  drivers/mmc/core/sd.h      |    1 -
>>>>  drivers/mmc/core/sdio.c    |    8 +-
>>>>  include/linux/mmc/card.h   |   31 +--
>>>>  include/linux/mmc/host.h   |   42 +++-
>>>>  include/linux/mmc/mmc.h    |   23 ++-
>>>>  10 files changed, 497 insertions(+), 322 deletions(-)
>>>>
>>>> Thanks,
>>>> Sw-j
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
