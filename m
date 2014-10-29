From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc:core: fix hs400 timing selection
Date: Wed, 29 Oct 2014 11:05:02 +0900
Message-ID: <54504B4E.2070208@samsung.com>
References: <1413946555-1266-1-git-send-email-chanho.min@lge.com>
 <544F1DB3.9050204@samsung.com> <00b601cff30a$3c57e710$b507b530$@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57014 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbaJ2CFG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Oct 2014 22:05:06 -0400
In-reply-to: <00b601cff30a$3c57e710$b507b530$@lge.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?EUC-KR?B?wK/H0bDm?= <hankyung.yu@lge.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chanho Min' <chanho.min@lge.com>, 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Seungwon Jeon' <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'HyoJun Im' <hyojun.im@lge.com>, gunho.lee@lge.com, 'CPGS' <cpgs@samsung.com>

Hi,

On 10/29/2014 08:52 AM, =C0=AF=C7=D1=B0=E6 wrote:
> Hi I'm Hankyung Yu
>=20
> I will answer instead Chanho Min
>=20
> After mmc_set_timing(card->host, MMC_TIMING_MMC_HS);=20
>=20
> Host controller set to SDR transfer
>=20
> so is to change to a DDR transfer mode.

As commit message was mentioned, I have checked the JEDEC v5.01 spec(6.=
6.5).
There is no mention that mode needs to change to DDR mode.

And i know HS400 mode is only support the 8bit buswidth.
If HS200 mode was set to 4bit buswidth, is HS400 working fine?

Best Regards,
Jaehoon Chung

>=20
>=20
> -----Original Message-----
> From: Jaehoon Chung [mailto:jh80.chung@samsung.com]=20
> Sent: Tuesday, October 28, 2014 1:38 PM
> To: Chanho Min; Chris Ball; Ulf Hansson; Seungwon Jeon; Jaehoon Chung
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; HyoJun I=
m;
> gunho.lee@lge.com; Hankyung Yu; CPGS
> Subject: Re: [PATCH] mmc:core: fix hs400 timing selection
>=20
> Hi, Chanho.
>=20
> On 10/22/2014 11:55 AM, Chanho Min wrote:
>> According to JEDEC v5.01 spec (6.6.5), In order to switch to HS400=20
>> mode, host should perform the following steps.
>>
>>  1. HS200 mode selection completed
>>  2. Set HS_TIMING to 0x01(High Speed)
>>  3. Host changes frequency to =3D< 52MHz  4. Set the bus width to DD=
R=20
>> 8bit (CMD6)  5. Host may read Driver Strength (CMD8)  6. Set HS_TIMI=
NG=20
>> to 0x03 (HS400)
>>
>> In current implementation, the order of 2 and 3 is reversed.
>> The HS_TIMING field should be set to 0x1 before the clock frequency =
is=20
>> set to a value not greater than 52 MHz. Otherwise, Initialization of=
=20
>> timing can be failed. Also, the host contoller's UHS timing mode=20
>> should be set to DDR50 after the bus width is set to DDR 8bit.
>>
>> Signed-off-by: Hankyung Yu <hankyung.yu@lge.com>
>> Signed-off-by: Chanho Min <chanho.min@lge.com>
>> ---
>>  drivers/mmc/core/mmc.c |   13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index=20
>> a301a78..52f78e0 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1061,9 +1061,6 @@ static int mmc_select_hs400(struct mmc_card *c=
ard)
>>  	 * Before switching to dual data rate operation for HS400,
>>  	 * it is required to convert from HS200 mode to HS mode.
>>  	 */
>> -	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>> -	mmc_set_bus_speed(card);
>> -
>>  	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>  			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
>>  			   card->ext_csd.generic_cmd6_time, @@ -1074,6
> +1071,14 @@ static=20
>> int mmc_select_hs400(struct mmc_card *card)
>>  		return err;
>>  	}
>> =20
>> +	/*
>> +	 * According to JEDEC v5.01 spec (6.6.5), Clock frequency should
>> +	 * be set to a value not greater than 52MHz after the HS_TIMING
>> +	 * field is set to 0x1.
>> +	 */
>> +	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>> +	mmc_set_bus_speed(card);
>> +
>>  	err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>  			 EXT_CSD_BUS_WIDTH,
>>  			 EXT_CSD_DDR_BUS_WIDTH_8,
>> @@ -1084,6 +1089,8 @@ static int mmc_select_hs400(struct mmc_card *c=
ard)
>>  		return err;
>>  	}
>> =20
>> +	mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
>> +
>=20
> I didn't know why timing is set to ddr50.
>=20
> Best Regards,
> Jaehoon Chung
>=20
>>  	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>  			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS400,
>>  			   card->ext_csd.generic_cmd6_time,
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

