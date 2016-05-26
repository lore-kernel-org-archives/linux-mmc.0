From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: use default speed of the eMMC
Date: Thu, 26 May 2016 17:30:57 +0900
Message-ID: <5746B441.8070609@samsung.com>
References: <CGME20160524090753epcas1p125c06a036988b476840c79048cb45428@epcas1p1.samsung.com>
 <CA+pahgdUP3Zam-cSeW8fJR9AmiUo2_Ok_uDHqWTgwvzCGC58+g@mail.gmail.com>
 <574421CE.4080503@samsung.com>
 <CA+pahgf-gfB9YBNgvSCP8wexhXxnuxgpUx3fDhStK3pPcoYxKw@mail.gmail.com>
 <57468E5D.8040606@samsung.com>
 <CA+pahgeqi4js3uspbHA3uYUqjx12xyeSZDVHvyz_NqCVGgNEEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59009 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcEZIbC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 04:31:02 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O7R013WCZNM1980@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 26 May 2016 17:30:58 +0900 (KST)
In-reply-to: <CA+pahgeqi4js3uspbHA3uYUqjx12xyeSZDVHvyz_NqCVGgNEEA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?7J6l66+87Jqw?= <huskey27@gmail.com>
Cc: linux-mmc@vger.kernel.org

On 05/26/2016 03:34 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
> Yes, "default speed mode" what I mentioned is using below 26MHz clock
> (not in high speed mode).
>=20
> While eMMC card is on the initializing step, it uses below 400KHz not=
 26MHz.
>=20
> I just want to use below 26MHz, because some customers want to use lo=
w
> hertz clock.

Just for some customers? Then You can add the workaround code in your l=
ocal.

>=20
> So, eMMC versions and environments have nothing to do with "default s=
peed mode".

How do you set your "default speed mode"? (Support HS/DDR/HS200 etc..)

It seems that can't set the lower hertz than 26MHz with only your patch=
=2E
what hertz exactly? Your purpose is just hook for some customers.

And i can't find "default speed mode" in eMMC SPEC. Could you explain w=
here mentioned "default speed mode"?

Best Regards,
Jaehoon Chung

>=20
> If there is a misunderstanding, please let me know.
>=20
> Thank you.
>=20
> Best Regards,
> Minwoo Jang
>=20
>=20
> 2016-05-26 14:49 GMT+09:00 Jaehoon Chung <jh80.chung@samsung.com>:
>> On 05/26/2016 02:16 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
>>> Hello, Jaehoon Chung.
>>>
>>> I mentioned "default speed mode" not hs200, hs400, ddr and hs mode.
>>
>> Yes, default speed mode is not HS400, HS400, DDR..
>> You mean "default speed mode" is 26MHz?
>>
>> As i know, default speed is 26MHz. and it used for initializing card=
=2E
>>
>>>
>>> I think If "default speed mode" is set, there is no bus width chang=
e.
>>
>> There is DEVICE_TYPE[196] at ext_csd register.
>> Device type should be selected one of them. (You can see the current=
ly valid value.)
>>
>> I don't know exactly what your purpose.
>> If i missed something, let me know in more detail about default spee=
d, eMMC version, your environment.
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> If you have any advice to use "default speed mode" of the eMMC. ple=
ase
>>> let me know.
>>>
>>> Thank you.
>>>
>>> Best Regards,
>>> Minwoo Jang.
>>>
>>> 2016-05-24 18:41 GMT+09:00 Jaehoon Chung <jh80.chung@samsung.com>:
>>>> Hi,
>>>>
>>>> On 05/24/2016 06:07 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
>>>>> Dear linux-mmc.
>>>>>
>>>>> Hello, I'm Minwoo Jang.
>>>>>
>>>>> I have a question about using default speed of the eMMC.
>>>>>
>>>>> When default speed is used, mmc_select_bus_width() is never calle=
d.
>>>>>
>>>>> So, eMMC can not be set 4 bit or 8 bit bus width, I think.
>>>>>
>>>>> Please, give me your opinions on the following diff codes.
>>>>
>>>> In mmc_select_timing(), timing should be set to MMC_TIMING_HS or o=
thers.
>>>> Then mmc_select_bus_width() should be entered.
>>>>
>>>> Best Regards,
>>>> Jaehoon Chung
>>>>
>>>>>
>>>>> Thank you.
>>>>>
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>>>>
>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>> index 94b4462..3b1cc4d 100644
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -952,6 +952,8 @@ static int mmc_select_bus_width(struct mmc_ca=
rd *card)
>>>>>
>>>>>                 if (!err) {
>>>>>                         err =3D bus_width;
>>>>> +                       pr_warn("%s: switch to bus width %d\n",
>>>>> +                               mmc_hostname(host), (1 << bus_wid=
th));
>>>>>                         break;
>>>>>                 } else {
>>>>>                         pr_warn("%s: switch to bus width %d faile=
d\n",
>>>>> @@ -1500,6 +1502,14 @@ static int mmc_init_card(struct mmc_host *=
host, u32 ocr,
>>>>>                         if (err)
>>>>>                                 goto err;
>>>>>                 }
>>>>> +       } else {
>>>>> +               /* Select the bus width for normal speed mode */
>>>>> +               err =3D mmc_select_bus_width(card);
>>>>> +               if (IS_ERR_VALUE(err)) {
>>>>> +                       pr_warn("%s: Selecting bus width failed\n=
",
>>>>> +                               mmc_hostname(card->host));
>>>>> +                       goto err;
>>>>> +               }
>>>>>         }
>>>>>
>>>>> Best regards,
>>>>>
>>>>> MW Jang.
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-m=
mc" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20

