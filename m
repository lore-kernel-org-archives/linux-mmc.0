From: =?UTF-8?B?7J6l66+87Jqw?= <huskey27@gmail.com>
Subject: Re: use default speed of the eMMC
Date: Thu, 26 May 2016 14:16:48 +0900
Message-ID: <CA+pahgf-gfB9YBNgvSCP8wexhXxnuxgpUx3fDhStK3pPcoYxKw@mail.gmail.com>
References: <CGME20160524090753epcas1p125c06a036988b476840c79048cb45428@epcas1p1.samsung.com>
	<CA+pahgdUP3Zam-cSeW8fJR9AmiUo2_Ok_uDHqWTgwvzCGC58+g@mail.gmail.com>
	<574421CE.4080503@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34903 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbcEZFQt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 01:16:49 -0400
Received: by mail-vk0-f66.google.com with SMTP id e126so872481vkb.2
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2016 22:16:49 -0700 (PDT)
In-Reply-To: <574421CE.4080503@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org

Hello, Jaehoon Chung.

I mentioned "default speed mode" not hs200, hs400, ddr and hs mode.

I think If "default speed mode" is set, there is no bus width change.

If you have any advice to use "default speed mode" of the eMMC. please
let me know.

Thank you.

Best Regards,
Minwoo Jang.

2016-05-24 18:41 GMT+09:00 Jaehoon Chung <jh80.chung@samsung.com>:
> Hi,
>
> On 05/24/2016 06:07 PM, =EC=9E=A5=EB=AF=BC=EC=9A=B0 wrote:
>> Dear linux-mmc.
>>
>> Hello, I'm Minwoo Jang.
>>
>> I have a question about using default speed of the eMMC.
>>
>> When default speed is used, mmc_select_bus_width() is never called.
>>
>> So, eMMC can not be set 4 bit or 8 bit bus width, I think.
>>
>> Please, give me your opinions on the following diff codes.
>
> In mmc_select_timing(), timing should be set to MMC_TIMING_HS or othe=
rs.
> Then mmc_select_bus_width() should be entered.
>
> Best Regards,
> Jaehoon Chung
>
>>
>> Thank you.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 94b4462..3b1cc4d 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -952,6 +952,8 @@ static int mmc_select_bus_width(struct mmc_card =
*card)
>>
>>                 if (!err) {
>>                         err =3D bus_width;
>> +                       pr_warn("%s: switch to bus width %d\n",
>> +                               mmc_hostname(host), (1 << bus_width)=
);
>>                         break;
>>                 } else {
>>                         pr_warn("%s: switch to bus width %d failed\n=
",
>> @@ -1500,6 +1502,14 @@ static int mmc_init_card(struct mmc_host *hos=
t, u32 ocr,
>>                         if (err)
>>                                 goto err;
>>                 }
>> +       } else {
>> +               /* Select the bus width for normal speed mode */
>> +               err =3D mmc_select_bus_width(card);
>> +               if (IS_ERR_VALUE(err)) {
>> +                       pr_warn("%s: Selecting bus width failed\n",
>> +                               mmc_hostname(card->host));
>> +                       goto err;
>> +               }
>>         }
>>
>> Best regards,
>>
>> MW Jang.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>
