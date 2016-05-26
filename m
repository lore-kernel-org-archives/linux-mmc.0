From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: use default speed of the eMMC
Date: Thu, 26 May 2016 18:45:15 +0900
Message-ID: <5746C5AB.2010605@samsung.com>
References: <CGME20160524090753epcas1p125c06a036988b476840c79048cb45428@epcas1p1.samsung.com>
 <CA+pahgdUP3Zam-cSeW8fJR9AmiUo2_Ok_uDHqWTgwvzCGC58+g@mail.gmail.com>
 <574421CE.4080503@samsung.com>
 <CA+pahgf-gfB9YBNgvSCP8wexhXxnuxgpUx3fDhStK3pPcoYxKw@mail.gmail.com>
 <57468E5D.8040606@samsung.com>
 <CA+pahgeqi4js3uspbHA3uYUqjx12xyeSZDVHvyz_NqCVGgNEEA@mail.gmail.com>
 <5746B441.8070609@samsung.com>
 <CA+pahge54s_xGG6YgL12F1gBq-KgVDip4T0=US1PNawMxnY_=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40541 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbcEZJpT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 05:45:19 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O7S001DH33FWS00@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 26 May 2016 18:45:15 +0900 (KST)
In-reply-to: <CA+pahge54s_xGG6YgL12F1gBq-KgVDip4T0=US1PNawMxnY_=w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?7J6l66+87Jqw?= <huskey27@gmail.com>
Cc: linux-mmc@vger.kernel.org

On 05/26/2016 06:04 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
> There is no "default speed mode" in the JEDEC specification.
>=20
> It is that eMMC speed using the clock frequency not in high speed mod=
e.
>=20
> In the mmc core driver of the kernel-3.9, bus width is changed from 1
> to 4 or 8 without EXT_CSD_CARD_TYPE_HS and HS_TIMING setting.
>=20
> But, bus width is not changed in the kernel 3.10.

3.10? Now..going to 4.7...
I will not say anymore..Even though other guys can accept yours, but i'=
m not.

Best Regards,
Jaehoon Chung

>=20
> And the cause of this problem is that mmc_select_bus_width() is never
> called in this situation, I think.
>=20
> So, you suggest when I want to use 20MHz clock frequency without high
> speed setting, I should modify mmc driver.
>=20
> There is no problem with that.
>=20
> Thank you.
>=20
> Best regards,
> Minwoo Jang.
>=20
>=20
>=20
> 2016-05-26 17:30 GMT+09:00 Jaehoon Chung <jh80.chung@samsung.com>:
>> On 05/26/2016 03:34 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
>>> Yes, "default speed mode" what I mentioned is using below 26MHz clo=
ck
>>> (not in high speed mode).
>>>
>>> While eMMC card is on the initializing step, it uses below 400KHz n=
ot 26MHz.
>>>
>>> I just want to use below 26MHz, because some customers want to use =
low
>>> hertz clock.
>>
>> Just for some customers? Then You can add the workaround code in you=
r local.
>>
>>>
>>> So, eMMC versions and environments have nothing to do with "default=
 speed mode".
>>
>> How do you set your "default speed mode"? (Support HS/DDR/HS200 etc.=
=2E)
>>
>> It seems that can't set the lower hertz than 26MHz with only your pa=
tch.
>> what hertz exactly? Your purpose is just hook for some customers.
>>
>> And i can't find "default speed mode" in eMMC SPEC. Could you explai=
n where mentioned "default speed mode"?
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> If there is a misunderstanding, please let me know.
>>>
>>> Thank you.
>>>
>>> Best Regards,
>>> Minwoo Jang
>>>
>>>
>>> 2016-05-26 14:49 GMT+09:00 Jaehoon Chung <jh80.chung@samsung.com>:
>>>> On 05/26/2016 02:16 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
>>>>> Hello, Jaehoon Chung.
>>>>>
>>>>> I mentioned "default speed mode" not hs200, hs400, ddr and hs mod=
e.
>>>>
>>>> Yes, default speed mode is not HS400, HS400, DDR..
>>>> You mean "default speed mode" is 26MHz?
>>>>
>>>> As i know, default speed is 26MHz. and it used for initializing ca=
rd.
>>>>
>>>>>
>>>>> I think If "default speed mode" is set, there is no bus width cha=
nge.
>>>>
>>>> There is DEVICE_TYPE[196] at ext_csd register.
>>>> Device type should be selected one of them. (You can see the curre=
ntly valid value.)
>>>>
>>>> I don't know exactly what your purpose.
>>>> If i missed something, let me know in more detail about default sp=
eed, eMMC version, your environment.
>>>>
>>>> Best Regards,
>>>> Jaehoon Chung
>>>>
>>>>>
>>>>> If you have any advice to use "default speed mode" of the eMMC. p=
lease
>>>>> let me know.
>>>>>
>>>>> Thank you.
>>>>>
>>>>> Best Regards,
>>>>> Minwoo Jang.
>>>>>
>>>>> 2016-05-24 18:41 GMT+09:00 Jaehoon Chung <jh80.chung@samsung.com>=
:
>>>>>> Hi,
>>>>>>
>>>>>> On 05/24/2016 06:07 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
>>>>>>> Dear linux-mmc.
>>>>>>>
>>>>>>> Hello, I'm Minwoo Jang.
>>>>>>>
>>>>>>> I have a question about using default speed of the eMMC.
>>>>>>>
>>>>>>> When default speed is used, mmc_select_bus_width() is never cal=
led.
>>>>>>>
>>>>>>> So, eMMC can not be set 4 bit or 8 bit bus width, I think.
>>>>>>>
>>>>>>> Please, give me your opinions on the following diff codes.
>>>>>>
>>>>>> In mmc_select_timing(), timing should be set to MMC_TIMING_HS or=
 others.
>>>>>> Then mmc_select_bus_width() should be entered.
>>>>>>
>>>>>> Best Regards,
>>>>>> Jaehoon Chung
>>>>>>
>>>>>>>
>>>>>>> Thank you.
>>>>>>>
>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>>>> index 94b4462..3b1cc4d 100644
>>>>>>> --- a/drivers/mmc/core/mmc.c
>>>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>>>> @@ -952,6 +952,8 @@ static int mmc_select_bus_width(struct mmc_=
card *card)
>>>>>>>
>>>>>>>                 if (!err) {
>>>>>>>                         err =3D bus_width;
>>>>>>> +                       pr_warn("%s: switch to bus width %d\n",
>>>>>>> +                               mmc_hostname(host), (1 << bus_w=
idth));
>>>>>>>                         break;
>>>>>>>                 } else {
>>>>>>>                         pr_warn("%s: switch to bus width %d fai=
led\n",
>>>>>>> @@ -1500,6 +1502,14 @@ static int mmc_init_card(struct mmc_host=
 *host, u32 ocr,
>>>>>>>                         if (err)
>>>>>>>                                 goto err;
>>>>>>>                 }
>>>>>>> +       } else {
>>>>>>> +               /* Select the bus width for normal speed mode *=
/
>>>>>>> +               err =3D mmc_select_bus_width(card);
>>>>>>> +               if (IS_ERR_VALUE(err)) {
>>>>>>> +                       pr_warn("%s: Selecting bus width failed=
\n",
>>>>>>> +                               mmc_hostname(card->host));
>>>>>>> +                       goto err;
>>>>>>> +               }
>>>>>>>         }
>>>>>>>
>>>>>>> Best regards,
>>>>>>>
>>>>>>> MW Jang.
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux=
-mmc" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>
>=20
>=20
>=20

