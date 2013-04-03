From: Maya Erez <merez@codeaurora.org>
Subject: Re: [PATCH 0/3] mmc: Use runtime pm for blkdevice
Date: Wed, 03 Apr 2013 13:51:18 +0300
Message-ID: <515C09A6.9010002@codeaurora.org>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDED3BFE1@SC-VEXCH1.marvell.com> <CADz5_g+TB9rg0_dwgzsOe7UL2F9gYuO17A=5iAca5N1jPkPj2g@mail.gmail.com> <d3e7755a3509464281def783c5685a7f.squirrel@www.codeaurora.org> <CAPDyKFpsTWCoTWSNOaJVfr-3hXzf4x_qNYujo1trhbim4Tnxdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:14451 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761664Ab3DCKvW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Apr 2013 06:51:22 -0400
In-Reply-To: <CAPDyKFpsTWCoTWSNOaJVfr-3hXzf4x_qNYujo1trhbim4Tnxdg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Liu <keyuan.liu@gmail.com>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Johan Rudholm <johan.rudholm@stericsson.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kevin Liu <kliu5@marvell.com>

=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A 4/2/2013 1:45 PM, =D7=A6=D7=99=D7=98=
=D7=95=D7=98 Ulf Hansson:
> On 28 March 2013 22:05,  <merez@codeaurora.org> wrote:
>> Hi Chris,
>>
>> Sorry for the late response.
>> I am currently on vacation and would get back to work next week.
>> We would like to have an internal discussion to make sure there are =
no
>> additional concerns with this patch.
>> Can you please wait with this patch approval until the end of next w=
eek?
> Hi Maya,
>
> Hope you have had a good vacation. I was thinking of the BKOPS patche=
s
> I assume you are working on. If you need some assistance to "rebase"
> you work on top of this patchset, just ping me.
>
> Kind regards
> Ulf Hansson
>
>> Thanks,
>> Maya
>>
>>>> -----Original Message-----
>>>> From: Chris Ball [mailto:cjb@laptop.org]
>>>> Sent: Wednesday, March 27, 2013 9:32 PM
>>>> To: Ulf Hansson
>>>> Cc: linux-mmc@vger.kernel.org; Johan Rudholm; Ulf Hansson; Maya Er=
ez;
>>>> Kevin Liu; Seungwon Jeon; jh80.chung@samsung.com
>>>> Subject: Re: [PATCH 0/3] mmc: Use runtime pm for blkdevice
>>>>
>>>> Hi Maya, Kevin, Seungwon, Jaehoon,
>>>>
>>>> On Fri, Mar 01 2013, Ulf Hansson wrote:
>>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>
>>>>> SDIO has been using runtime pm for a while to handle runtime powe=
r save
>>>>> operations. This patchset is enabling the option to make the sd/m=
mc
>>>>> blockdevices to use runtime pm as well.
>>>>>
>>>>> The runtime pm implementation for the block device will make use =
of
>>>>> autosuspend to defer power save operation to after request inacti=
vty
>>>>> for
>>>>> a certain time.
>>>>>
>>>>> To actually perform some power save operations the corresponding =
bus
>>>>> ops
>>>>> for mmc and sd shall be implemented. Typically it could make sens=
e to
>>>>> do
>>>>> BKOPS for eMMC in here.
>>>>>
>>>>> Ulf Hansson (3):
>>>>>    mmc: core: Remove power_restore bus_ops for mmc and sd
>>>>>    mmc: core: Add bus_ops for runtime pm callbacks
>>>>>    mmc: block: Enable runtime pm for mmc blkdevice
>>>>>
>>>>>   drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
>>>>>   drivers/mmc/core/bus.c   |   14 ++++++++++++--
>>>>>   drivers/mmc/core/core.h  |    2 ++
>>>>>   drivers/mmc/core/mmc.c   |   14 --------------
>>>>>   drivers/mmc/core/sd.c    |   14 --------------
>>>>>   drivers/mmc/core/sdio.c  |   20 ++++++++++++++++++++
>>>>>   6 files changed, 60 insertions(+), 32 deletions(-)
>>>> This looks good to me, but I'd like to make sure the design works =
for
>>>> you before we decide to merge it.  Any concerns?
>>>>
>>> Chris,
>>>
>>> This patchset is ok for me.
>>> We can discuss/review how sd/mmc runtime callback function implemen=
ted
>>> later.
>>>
>>> Thanks
>>> Kevin
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Maya Erez
>> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a =
member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi Ulf,

Thanks for your offer.

The current plan is to start the BKOPS in the runtime suspend API=20
(triggerred 3 secs after idle time) although it may be less efficient=20
than the current approach which starts the BKOPS after 200ms from idle =
time.
I will try to send the BKOPS patch next week.

Chris - we are OK with this patch, you can continue with its merge.

Thanks,
Maya

--=20
Maya Erez
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a mem=
ber of Code Aurora Forum, hosted by The Linux Foundation

