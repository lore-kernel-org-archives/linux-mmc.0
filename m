From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: Use runtime pm for blkdevice
Date: Tue, 2 Apr 2013 12:45:21 +0200
Message-ID: <CAPDyKFpsTWCoTWSNOaJVfr-3hXzf4x_qNYujo1trhbim4Tnxdg@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDED3BFE1@SC-VEXCH1.marvell.com>
	<CADz5_g+TB9rg0_dwgzsOe7UL2F9gYuO17A=5iAca5N1jPkPj2g@mail.gmail.com>
	<d3e7755a3509464281def783c5685a7f.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:56012 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455Ab3DBKpW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Apr 2013 06:45:22 -0400
Received: by mail-ve0-f182.google.com with SMTP id m1so277917ves.27
        for <linux-mmc@vger.kernel.org>; Tue, 02 Apr 2013 03:45:22 -0700 (PDT)
In-Reply-To: <d3e7755a3509464281def783c5685a7f.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: Kevin Liu <keyuan.liu@gmail.com>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Johan Rudholm <johan.rudholm@stericsson.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kevin Liu <kliu5@marvell.com>

On 28 March 2013 22:05,  <merez@codeaurora.org> wrote:
> Hi Chris,
>
> Sorry for the late response.
> I am currently on vacation and would get back to work next week.
> We would like to have an internal discussion to make sure there are no
> additional concerns with this patch.
> Can you please wait with this patch approval until the end of next week?

Hi Maya,

Hope you have had a good vacation. I was thinking of the BKOPS patches
I assume you are working on. If you need some assistance to "rebase"
you work on top of this patchset, just ping me.

Kind regards
Ulf Hansson

>
> Thanks,
> Maya
>
>>> -----Original Message-----
>>> From: Chris Ball [mailto:cjb@laptop.org]
>>> Sent: Wednesday, March 27, 2013 9:32 PM
>>> To: Ulf Hansson
>>> Cc: linux-mmc@vger.kernel.org; Johan Rudholm; Ulf Hansson; Maya Erez;
>>> Kevin Liu; Seungwon Jeon; jh80.chung@samsung.com
>>> Subject: Re: [PATCH 0/3] mmc: Use runtime pm for blkdevice
>>>
>>> Hi Maya, Kevin, Seungwon, Jaehoon,
>>>
>>> On Fri, Mar 01 2013, Ulf Hansson wrote:
>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>
>>>> SDIO has been using runtime pm for a while to handle runtime power save
>>>> operations. This patchset is enabling the option to make the sd/mmc
>>>> blockdevices to use runtime pm as well.
>>>>
>>>> The runtime pm implementation for the block device will make use of
>>>> autosuspend to defer power save operation to after request inactivty
>>>> for
>>>> a certain time.
>>>>
>>>> To actually perform some power save operations the corresponding bus
>>>> ops
>>>> for mmc and sd shall be implemented. Typically it could make sense to
>>>> do
>>>> BKOPS for eMMC in here.
>>>>
>>>> Ulf Hansson (3):
>>>>   mmc: core: Remove power_restore bus_ops for mmc and sd
>>>>   mmc: core: Add bus_ops for runtime pm callbacks
>>>>   mmc: block: Enable runtime pm for mmc blkdevice
>>>>
>>>>  drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
>>>>  drivers/mmc/core/bus.c   |   14 ++++++++++++--
>>>>  drivers/mmc/core/core.h  |    2 ++
>>>>  drivers/mmc/core/mmc.c   |   14 --------------
>>>>  drivers/mmc/core/sd.c    |   14 --------------
>>>>  drivers/mmc/core/sdio.c  |   20 ++++++++++++++++++++
>>>>  6 files changed, 60 insertions(+), 32 deletions(-)
>>>
>>> This looks good to me, but I'd like to make sure the design works for
>>> you before we decide to merge it.  Any concerns?
>>>
>>
>> Chris,
>>
>> This patchset is ok for me.
>> We can discuss/review how sd/mmc runtime callback function implemented
>> later.
>>
>> Thanks
>> Kevin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Maya Erez
> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
