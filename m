From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] Move the judgement of timeout into
 mmc_switch_status_error()
Date: Thu, 24 Dec 2015 19:15:20 +0900
Message-ID: <567BC5B8.6080308@samsung.com>
References: <008f01d13e2b$4a2a3150$de7e93f0$@samsung.com>
 <567BB9CF.3090301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:40723 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbbLXKP2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Dec 2015 05:15:28 -0500
In-reply-to: <567BB9CF.3090301@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?EUC-KR?B?wOW/tcH4?= <yj84.jang@samsung.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: js07.lee@samsung.com, =?EUC-KR?B?J8DMsaTIoyc=?= <demon.lee@samsung.com>

Hi,

NAK.

Maybe..It seems that this is not the patch based on latest kernel..
Which kernel version did you use? Plz, check the latest kernel.

Best Regards,
Jaehoon Chung

On 12/24/2015 06:24 PM, Jaehoon Chung wrote:
> Hi,
>=20
> Before send the patch at mailing list, you need to make the patch as =
mainline style.
> Maybe..maintainer should not review this patch.
>=20
> Refer to "Linux kernel coding style" and "submitting Patches".
> Also set  your email environment. (Documentation/email-clients.txt)
>=20
> Best Regards,
> Jaehoon Chung
>=20
> On 12/24/2015 06:13 PM, =C0=E5=BF=B5=C1=F8 wrote:
>> >From bc1e491b29d9199f16c6e002a69f9377677b93af Mon Sep 17 00:00:00 2=
001
>>
>> From: "yj84.jang" <yj84.jang@samsung.com>
>>
>> Date: Wed, 16 Dec 2015 08:52:47 +0900
>>
>> Subject: [PATCH] Move the judgement of timeout into
>> mmc_switch_status_error()
>>
>> =20
>>
>> __mmc_switch() is possible to misjudge error.
>>
>> =20
>>
>> Although jiffies was overed timeout,=20
>>
>> the chance about "R1_CURRENT_STATE(status) !=3D R1_STATE_PRG" is exi=
sts.=20
>>
>> In other words, Successful completion of CMD6 with timeout error.
>>
>> =20
>>
>> Kernel expects failure of __mmc_switch,
>>
>> but card is completed CMD6 in this case.
>>
>> It makes mismatch status between mmc subsystem and mmc card.
>>
>> =20
>>
>> Especially, in case of partition switch,
>>
>> If timeout occurs with normal status of CMD13 response unfortunatley=
,=20
>>
>> "main_md->curr" will not be set, even card switched successfully.
>>
>> =20
>>
>> Checking state of mmc card is needed when judging an timeout error,=20
>>
>> if it is just timeout or timeout with error.
>>
>> =20
>>
>> Signed-off-by: yj84.jang <yj84.jang@samsung.com>
>>
>> ---
>>
>> drivers/mmc/core/mmc_ops.c |    5 +++--
>>
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> =20
>>
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>
>> index 1f44426..033f475 100644
>>
>> --- a/drivers/mmc/core/mmc_ops.c
>>
>> +++ b/drivers/mmc/core/mmc_ops.c
>>
>> @@ -456,6 +456,8 @@ int mmc_switch_status_error(struct mmc_host *hos=
t, u32
>> status)
>>
>>                     if (status & R1_SPI_ILLEGAL_COMMAND)
>>
>>                                return -EBADMSG;
>>
>>          } else {
>>
>> +                   if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG=
)
>>
>> +                              return -ETIMEDOUT;
>>
>>                     if (status & 0xFDFFA000)
>>
>>                                pr_warn("%s: unexpected status %#x af=
ter
>> switch\n",
>>
>>                                          mmc_hostname(host), status)=
;
>>
>> @@ -568,8 +570,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, =
u8
>> index, u8 value,
>>
>>                     if (time_after(jiffies, timeout)) {
>>
>>                                pr_err("%s: Card stuck in programming=
 state!
>> %s\n",
>>
>>                                          mmc_hostname(host), __func_=
_);
>>
>> -                               err =3D -ETIMEDOUT;
>>
>> -                               goto out;
>>
>> +                              break;
>>
>>                     }
>>
>>          } while (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG);
>>
>> =20
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

