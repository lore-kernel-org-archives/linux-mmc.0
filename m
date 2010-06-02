From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] Recognize CSD structure version 3
Date: Wed, 2 Jun 2010 17:12:41 +0900
Message-ID: <AANLkTinx9jQPysr5tnWRkEFGx6d6UJQSrizSNedE_xyR@mail.gmail.com>
References: <20100531064035.GA25269@july>
	<4C04D822.5040208@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53325 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684Ab0FBIMm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Jun 2010 04:12:42 -0400
Received: by vws11 with SMTP id 11so2239814vws.19
        for <linux-mmc@vger.kernel.org>; Wed, 02 Jun 2010 01:12:42 -0700 (PDT)
In-Reply-To: <4C04D822.5040208@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

Hi

On Tue, Jun 1, 2010 at 6:51 PM, Adrian Hunter <adrian.hunter@nokia.com>=
 wrote:
> Kyungmin Park wrote:
>>
>> The eMMC spec 4.4 and 4.3 + additional feature chips has CSD structu=
re
>> version 3
>
> That is not exactly correct. =A0There is no CSD structure version 1.3=
=2E
> =A0Instead
> there are two fields for CSD structure version. =A0One in CSD and one=
 in
> Extended CSD.
>
> In CSD there is:
>
> CSD_STRUCTURE [127:126]
> Describes the version of the CSD structure.
> Table 44 =97 CSD register structure
> CSD_STRUCTURE =A0 =A0CSD Structure Version =A0 =A0Valid for System Sp=
ecification
> Version
> 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSD version No. =A0 =A0 =A0 =A0 =A01=
=2E0 Allocated by MMCA
> 1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSD version No. =A0 =A0 =A0 =A0 =A01=
=2E1 Allocated by MMCA
> 2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSD version No. =A0 =A0 =A0 =A0 =A01=
=2E2 Version 4.1=964.2=964.3
> 3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Version is coded in the CSD_STRUCTUR=
E byte in the EXT_CSD
> register
>
> So the 3 does not mean version 1.3 it just means look at Extended CSD
> instead.
> But the Extended CSD field does not define CSD structure version 3 at=
 all.
>
> CSD_STRUCTURE [194]
> This field is a continuation of the CSD_STRUCTURE field in the CSD re=
gister
> Table 78 =97 CSD register structure
> CSD_STRUCTURE =A0 =A0CSD structure version =A0 =A0Valid for System Sp=
ecification
> Version
> 0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSD version No. 1.0 =A0 =A0 =A0Alloc=
ated by MMCA
> 1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSD version No. 1.1 =A0 =A0 =A0Alloc=
ated by MMCA
> 2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CSD version No. 1.2 =A0 =A0 =A0Versi=
on 4.1=964.2=964.3-4.4
> 3=96255 =A0 =A0 =A0 =A0 =A0 =A0Reserved for future use

Thank you for Info. I got the eMMC v4.4 spec yesterday.

>
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
>> =A0 =A0 =A0 =A0u32 *resp =3D card->raw_csd;
>> =A0 =A0 =A0 =A0/*
>> - =A0 =A0 =A0 =A0* We only understand CSD structure v1.1 and v1.2.
>> + =A0 =A0 =A0 =A0* We understand all CSD structure v1.1, v1.2 and v1=
=2E3.
>
> This comment is not correct. v1.3 does not exist.

I will fix it correctly.

>
>> =A0 =A0 =A0 =A0 * v1.2 has extra information in bits 15, 11 and 10.
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0csd_struct =3D UNSTUFF_BITS(resp, 126, 2);
>> - =A0 =A0 =A0 if (csd_struct !=3D 1 && csd_struct !=3D 2) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: unrecognised CSD =
structure version
>> %d\n",
>
> I don't agree with removing this validation without a reason. =A0Inst=
ead
> extend it to 3.

With above description. it has all meaning. even though we don't use
the '0' value.
Do you want to check if csd_struct =3D=3D 0 case then fail?

>
> To support the '3' value properly, the Extended CSD CSD_STRUCTURE
> field needs to be validated also i.e. in mmc_read_ext_csd() do
> something like:
>
>
> =A0 =A0 =A0 =A0u32 *resp =3D card->raw_csd;
>
> =A0 =A0 =A0 =A0if (UNSTUFF_BITS(resp, 126, 2) =3D=3D 3) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check ext_csd[194]
> =A0 =A0 =A0 =A0}

I wonder are there any use case of csd version? it's just check
routine for proper operation.
basically no problem to display csd version and ext_csd version.

Thank you,
Kyungmin Park
>
>
>
>
>> + =A0 =A0 =A0 printk(KERN_DEBUG "%s: recognised CSD structure versio=
n %d\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->ho=
st), csd_struct);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0csd->mmca_vsn =A0 =A0=3D UNSTUFF_BITS(resp, 122, 4);
>> =A0 =A0 =A0 =A0m =3D UNSTUFF_BITS(resp, 115, 4);
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
