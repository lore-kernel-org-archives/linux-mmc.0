From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: check EXT_CSD_PARTITION_SETTING_COMPLETED before
 creating partitions
Date: Fri, 15 Aug 2014 10:17:10 +0200
Message-ID: <CAPDyKFp2ekmucHVzMWxeKfyTmuFKTXAYwUEpL5QxvEh8AjFopg@mail.gmail.com>
References: <53C7E45E.2060102@neotion.com>
	<CAPDyKFoRpQBHGGCMPvEKdeVGjTO-rnyYVostLZGCV3dudD1rmA@mail.gmail.com>
	<53EB2DC3.2080002@neotion.com>
	<CAPDyKFpjYqVUZ8GHB76gD8pOx_eMg9ecvbWrMEfbhEd5ffk7mw@mail.gmail.com>
	<53ECB95F.2030207@neotion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53ECB95F.2030207@neotion.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?R3LDqWdvcnkgU291dGFkw6k=?= <gsoutade@neotion.com>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 14 August 2014 15:27, Gr=C3=A9gory Soutad=C3=A9 <gsoutade@neotion.co=
m> wrote:
> Le 14/08/2014 13:46, Ulf Hansson a =C3=A9crit :
>> On 13 August 2014 11:20, Gr=C3=A9gory Soutad=C3=A9 <gsoutade@neotion=
=2Ecom> wrote:
>>> Le 13/08/2014 10:36, Ulf Hansson a =C3=A9crit :
>>>> On 17 July 2014 16:57, Gr=C3=A9gory Soutad=C3=A9 <gsoutade@neotion=
=2Ecom> wrote:
>>>>> Create MMC general purpose partitions only if
>>>>> EXT_CSD_PARTITION_SETTING_COMPLETED bit is set.
>>>>> Some tools may set general purpose partition size(s) but fail or =
stop
>>>>> without finalize.
>>>>> Another case is to set invalid partition size(s).
>>>>>
>>>>> Signed-off-by: Gr=C3=A9gory Soutad=C3=A9 <gsoutade@neotion.com>
>>>>> ---
>>>>>  drivers/mmc/core/mmc.c  |   15 +++++++++++----
>>>>>  include/linux/mmc/mmc.h |    2 ++
>>>>>  2 files changed, 13 insertions(+), 4 deletions(-)
>>>>>
>>>>> From commit b6603fe574af289dbe9eb9fb4c540bca04f5a053 in master li=
nux tree.
>>>>>
>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>> index 793c6f7..b9fe211 100644
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -471,10 +471,17 @@ static int mmc_read_ext_csd(struct mmc_card=
 *card, u8 *ext_csd)
>>>>>                                 ext_csd[EXT_CSD_GP_SIZE_MULT + id=
x * 3];
>>>>>                                 part_size *=3D (size_t)(hc_erase_=
grp_sz *
>>>>>                                         hc_wp_grp_sz);
>>>>> -                               mmc_part_add(card, part_size << 1=
9,
>>>>> -                                       EXT_CSD_PART_CONFIG_ACC_G=
P0 + idx,
>>>>> -                                       "gp%d", idx, false,
>>>>> -                                       MMC_BLK_DATA_AREA_GP);
>>>>> +                               if (ext_csd[EXT_CSD_PARTITION_SET=
TING_COMPLETED] &
>>>>> +                               EXT_CSD_PART_SETTING_COMPLETED) {
>>>>
>>>> Some minor comments here.
>>>>
>>>> I think you could move this if statement up and into the previous =
"if"
>>>> where we check for "ext_csd[EXT_CSD_PARTITION_SUPPORT] &
>>>> EXT_CSD_PART_SUPPORT_PART_EN".
>>>>
>>>> Additionally, please run checkpatch.
>>>>
>>>> Kind regards
>>>> Uffe
>>>
>>> Hello,
>>>
>>> I didn't put the if statement above to warn user in case of bad par=
titioning.
>>> I don't want the kernel to silently ignore this error.
>>
>> Fair enough.
>>
>> Still I am wondering whether hc_erase_grp_sz, hc_wp_grp_sz and
>> enhanced_area_en should be updated if
>> EXT_CSD_PARTITION_SETTING_COMPLETED isn't set.  That's the case in
>> your patch.
>
> I was focused on partitions and I didn't pay attention on enhanced ar=
ea.
>
> JEDEC says that partitioning implies :
> * Configure general purpose partitions attributes and sizes
> * Configure enhanced user area offset, attributes and size
>
> and finally set EXT_CSD_PARTITION_SETTING_COMPLETED.
>
> Thus these two parts must checks for setting completed before
> computing values.
>
> Plus, "enhanced_area_en" attribute is set whether or not there is an
> enhanced area defined. I looked at the code, and the only usage of it
> is to set EXT_CSD_ERASE_GROUP_DEF and compute erase size again.
> I suggest using "partition_setting_completed" identifier which is com=
mon
> to the two functions and requires EXT_CSD_ERASE_GROUP_DEF to be set.
>
> If you're ok with that, I'll submit another patch.

Seems reasonable. Please send a v2.

Kind regards
Uffe

>
>
> Best regards
> Gr=C3=A9gory Soutad=C3=A9
>
>>
>>>
>>> checkpatch has been run before sending this patch, I know there are=
 two lines
>>> with two extra characters, but names used here are quite long. I ho=
pe it will
>>> not block upstream inclusion.
>>
>> The mmc_read_ext_csd() is not one of the nicest piece of code, but f=
or
>> sure we should not move on making it worse. If you need to move code
>> into separate function to prevent checkpatch warnings, please do so.
>>
>> Kind regards
>> Uffe
>>
>
