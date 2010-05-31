From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] Recognize CSD structure version 3
Date: Mon, 31 May 2010 16:35:16 +0900
Message-ID: <AANLkTinYhC2plDtQYLKcQjlw85wiYKqWTKECCoyikBbE@mail.gmail.com>
References: <20100531064035.GA25269@july>
	<20100531070643.GJ4720@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37801 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab0EaHfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 May 2010 03:35:17 -0400
Received: by vws9 with SMTP id 9so355715vws.19
        for <linux-mmc@vger.kernel.org>; Mon, 31 May 2010 00:35:16 -0700 (PDT)
In-Reply-To: <20100531070643.GJ4720@trinity.fluff.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

On Mon, May 31, 2010 at 4:06 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Mon, May 31, 2010 at 03:40:35PM +0900, Kyungmin Park wrote:
>> The eMMC spec 4.4 and 4.3 + additional feature chips has CSD structu=
re version 3
>> To probe these chip properly and make it simple.
>> it doesn't check CSD structure.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 89f7a25..9e42bc6 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -118,15 +118,12 @@ static int mmc_decode_csd(struct mmc_card *car=
d)
>> =A0 =A0 =A0 u32 *resp =3D card->raw_csd;
>>
>> =A0 =A0 =A0 /*
>> - =A0 =A0 =A0* We only understand CSD structure v1.1 and v1.2.
>> + =A0 =A0 =A0* We understand all CSD structure v1.1, v1.2 and v1.3.
>> =A0 =A0 =A0 =A0* v1.2 has extra information in bits 15, 11 and 10.
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 csd_struct =3D UNSTUFF_BITS(resp, 126, 2);
>> - =A0 =A0 if (csd_struct !=3D 1 && csd_struct !=3D 2) {
>
> Hmm, it isn't easy to see what was going on here, this version field =
is 2bits?
>
> I'd still check for 0 in case someone repurposes the 0 bit to mean so=
me
> future version we don't know.

I also consider it. but even though we don't check the 0 at here.
later time it can't pass the EXT_CSD version check. so it will return
error.

That's reason I remain it printk at here. and even though '0' csd
version has some meaning at future. no need to modify for this.

I want to wait others comments.

Thank you,
Kyungmin Park
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: unrecognised CSD stru=
cture version %d\n",
>> + =A0 =A0 printk(KERN_DEBUG "%s: recognised CSD structure version %d=
\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host)=
, csd_struct);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 }
>>
>> =A0 =A0 =A0 csd->mmca_vsn =A0 =A0=3D UNSTUFF_BITS(resp, 122, 4);
>> =A0 =A0 =A0 m =3D UNSTUFF_BITS(resp, 115, 4);
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> --
> Ben
>
> Q: =A0 =A0 =A0What's a light-year?
> A: =A0 =A0 =A0One-third less calories than a regular year.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
