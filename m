From: =?UTF-8?B?7J6l66+87Jqw?= <huskey27@gmail.com>
Subject: Re: use default speed of the eMMC
Date: Thu, 26 May 2016 18:04:12 +0900
Message-ID: <CA+pahge54s_xGG6YgL12F1gBq-KgVDip4T0=US1PNawMxnY_=w@mail.gmail.com>
References: <CGME20160524090753epcas1p125c06a036988b476840c79048cb45428@epcas1p1.samsung.com>
	<CA+pahgdUP3Zam-cSeW8fJR9AmiUo2_Ok_uDHqWTgwvzCGC58+g@mail.gmail.com>
	<574421CE.4080503@samsung.com>
	<CA+pahgf-gfB9YBNgvSCP8wexhXxnuxgpUx3fDhStK3pPcoYxKw@mail.gmail.com>
	<57468E5D.8040606@samsung.com>
	<CA+pahgeqi4js3uspbHA3uYUqjx12xyeSZDVHvyz_NqCVGgNEEA@mail.gmail.com>
	<5746B441.8070609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34621 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbcEZJEN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 05:04:13 -0400
Received: by mail-vk0-f68.google.com with SMTP id k1so1914271vka.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2016 02:04:13 -0700 (PDT)
In-Reply-To: <5746B441.8070609@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org

There is no "default speed mode" in the JEDEC specification.

It is that eMMC speed using the clock frequency not in high speed mode.

In the mmc core driver of the kernel-3.9, bus width is changed from 1
to 4 or 8 without EXT_CSD_CARD_TYPE_HS and HS_TIMING setting.

But, bus width is not changed in the kernel 3.10.

And the cause of this problem is that mmc_select_bus_width() is never
called in this situation, I think.

So, you suggest when I want to use 20MHz clock frequency without high
speed setting, I should modify mmc driver.

There is no problem with that.

Thank you.

Best regards,
Minwoo Jang.



2016-05-26 17:30 GMT+09:00 Jaehoon Chung <jh80.chung@samsung.com>:
> On 05/26/2016 03:34 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
>> Yes, "default speed mode" what I mentioned is using below 26MHz cloc=
k
>> (not in high speed mode).
>>
>> While eMMC card is on the initializing step, it uses below 400KHz no=
t 26MHz.
>>
>> I just want to use below 26MHz, because some customers want to use l=
ow
>> hertz clock.
>
> Just for some customers? Then You can add the workaround code in your=
 local.
>
>>
>> So, eMMC versions and environments have nothing to do with "default =
speed mode".
>
> How do you set your "default speed mode"? (Support HS/DDR/HS200 etc..=
)
>
> It seems that can't set the lower hertz than 26MHz with only your pat=
ch.
> what hertz exactly? Your purpose is just hook for some customers.
>
> And i can't find "default speed mode" in eMMC SPEC. Could you explain=
 where mentioned "default speed mode"?
>
> Best Regards,
> Jaehoon Chung
>
>>
>> If there is a misunderstanding, please let me know.
>>
>> Thank you.
>>
>> Best Regards,
>> Minwoo Jang
>>
>>
>> 2016-05-26 14:49 GMT+09:00 Jaehoon Chung <jh80.chung@samsung.com>:
>>> On 05/26/2016 02:16 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
>>>> Hello, Jaehoon Chung.
>>>>
>>>> I mentioned "default speed mode" not hs200, hs400, ddr and hs mode=
=2E
>>>
>>> Yes, default speed mode is not HS400, HS400, DDR..
>>> You mean "default speed mode" is 26MHz?
>>>
>>> As i know, default speed is 26MHz. and it used for initializing car=
d.
>>>
>>>>
>>>> I think If "default speed mode" is set, there is no bus width chan=
ge.
>>>
>>> There is DEVICE_TYPE[196] at ext_csd register.
>>> Device type should be selected one of them. (You can see the curren=
tly valid value.)
>>>
>>> I don't know exactly what your purpose.
>>> If i missed something, let me know in more detail about default spe=
ed, eMMC version, your environment.
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>>
>>>> If you have any advice to use "default speed mode" of the eMMC. pl=
ease
>>>> let me know.
>>>>
>>>> Thank you.
>>>>
>>>> Best Regards,
>>>> Minwoo Jang.
>>>>
>>>> 2016-05-24 18:41 GMT+09:00 Jaehoon Chung <jh80.chung@samsung.com>:
>>>>> Hi,
>>>>>
>>>>> On 05/24/2016 06:07 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
>>>>>> Dear linux-mmc.
>>>>>>
>>>>>> Hello, I'm Minwoo Jang.
>>>>>>
>>>>>> I have a question about using default speed of the eMMC.
>>>>>>
>>>>>> When default speed is used, mmc_select_bus_width() is never call=
ed.
>>>>>>
>>>>>> So, eMMC can not be set 4 bit or 8 bit bus width, I think.
>>>>>>
>>>>>> Please, give me your opinions on the following diff codes.
>>>>>
>>>>> In mmc_select_timing(), timing should be set to MMC_TIMING_HS or =
others.
>>>>> Then mmc_select_bus_width() should be entered.
>>>>>
>>>>> Best Regards,
>>>>> Jaehoon Chung
>>>>>
>>>>>>
>>>>>> Thank you.
>>>>>>
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>>> index 94b4462..3b1cc4d 100644
>>>>>> --- a/drivers/mmc/core/mmc.c
>>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>>> @@ -952,6 +952,8 @@ static int mmc_select_bus_width(struct mmc_c=
ard *card)
>>>>>>
>>>>>>                 if (!err) {
>>>>>>                         err =3D bus_width;
>>>>>> +                       pr_warn("%s: switch to bus width %d\n",
>>>>>> +                               mmc_hostname(host), (1 << bus_wi=
dth));
>>>>>>                         break;
>>>>>>                 } else {
>>>>>>                         pr_warn("%s: switch to bus width %d fail=
ed\n",
>>>>>> @@ -1500,6 +1502,14 @@ static int mmc_init_card(struct mmc_host =
*host, u32 ocr,
>>>>>>                         if (err)
>>>>>>                                 goto err;
>>>>>>                 }
>>>>>> +       } else {
>>>>>> +               /* Select the bus width for normal speed mode */
>>>>>> +               err =3D mmc_select_bus_width(card);
>>>>>> +               if (IS_ERR_VALUE(err)) {
>>>>>> +                       pr_warn("%s: Selecting bus width failed\=
n",
>>>>>> +                               mmc_hostname(card->host));
>>>>>> +                       goto err;
>>>>>> +               }
>>>>>>         }
>>>>>>
>>>>>> Best regards,
>>>>>>
>>>>>> MW Jang.
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-=
mmc" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>>
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>
