From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: + mmc-recognize-csd-structure.patch added to -mm tree
Date: Mon, 7 Jun 2010 19:44:32 +0900
Message-ID: <AANLkTikCsNVwM8wtGiV6wDByKaEbUqq0h_f5V-DmIAeq@mail.gmail.com>
References: <201006042236.o54MaLod022299@imap1.linux-foundation.org>
	<4C0C9F58.4010504@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f187.google.com ([209.85.211.187]:37789 "EHLO
	mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab0FGKod convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jun 2010 06:44:33 -0400
In-Reply-To: <4C0C9F58.4010504@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Jun 7, 2010 at 4:27 PM, Adrian Hunter <adrian.hunter@nokia.com>=
 wrote:
> ext akpm@linux-foundation.org wrote:
>>
>> The patch titled
>> =A0 =A0 mmc: recognize CSD structure
>> has been added to the -mm tree. =A0Its filename is
>> =A0 =A0 mmc-recognize-csd-structure.patch
>>
>> Before you just go and hit "reply", please:
>> =A0 a) Consider who else should be cc'ed
>> =A0 b) Prefer to cc a suitable mailing list as well
>> =A0 c) Ideally: find the original patch on the mailing list and do a
>> =A0 =A0 =A0reply-to-all to that, adding suitable additional cc's
>>
>> *** Remember to use Documentation/SubmitChecklist when testing your =
code
>> ***
>>
>> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
>> out what to do about this
>>
>> The current -mm tree may be found at
>> http://userweb.kernel.org/~akpm/mmotm/
>>
>> ------------------------------------------------------
>> Subject: mmc: recognize CSD structure
>> From: Kyungmin Park <kmpark@infradead.org>
>>
>> The eMMC spec 4.4 and 4.3 + additional feature chips has CSD structu=
re
>> version 3 and version 3 have to check the CSD_STRUCTURE byte in the
>> EXT_CSD register.
>
> From my understanding there is no CSD structure version 3, so the com=
ment
> is a bit misleading. =A0The '3' value is used to mean something else =
i.e.
> look for the actual version value in another register. =A0The actual =
version
> is still '2'.

Right, right version is '2'.

Also v4.3 and v4.4 eMMCs do not need to use the '3' value
> and (apart from Samsung) probably won't because it is essentially
> meaningless.

Umm I got iNAND also and it has '3' value instead of '2'.

>
> The comment doesn't matter but the unsupported 0 value needs to be
> checked in EXT_CSD too - see below.

No problem to add the version check.

Thank you,
Kyungmin Park

>
>>
>> Also fix EXT_CSD revision message.
>>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: Adrian Hunter <adrian.hunter@nokia.com>
>> Cc: <linux-mmc@vger.kernel.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 26 +++++++++++++++++++-------
>> =A0include/linux/mmc/card.h | =A0 =A01 +
>> =A0include/linux/mmc/mmc.h =A0| =A0 =A01 +
>> =A03 files changed, 21 insertions(+), 7 deletions(-)
>>
>> diff -puN drivers/mmc/core/mmc.c~mmc-recognize-csd-structure
>> drivers/mmc/core/mmc.c
>> --- a/drivers/mmc/core/mmc.c~mmc-recognize-csd-structure
>> +++ a/drivers/mmc/core/mmc.c
>> @@ -114,17 +114,18 @@ static int mmc_decode_cid(struct mmc_car
>> =A0static int mmc_decode_csd(struct mmc_card *card)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_csd *csd =3D &card->csd;
>> - =A0 =A0 =A0 unsigned int e, m, csd_struct;
>> + =A0 =A0 =A0 unsigned int e, m;
>> =A0 =A0 =A0 =A0u32 *resp =3D card->raw_csd;
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * We only understand CSD structure v1.1 and v1.2.
>> =A0 =A0 =A0 =A0 * v1.2 has extra information in bits 15, 11 and 10.
>> + =A0 =A0 =A0 =A0* also support the for eMMC v4.4 & v4.41.
>> =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 csd_struct =3D UNSTUFF_BITS(resp, 126, 2);
>> - =A0 =A0 =A0 if (csd_struct !=3D 1 && csd_struct !=3D 2) {
>> + =A0 =A0 =A0 csd->structure =3D UNSTUFF_BITS(resp, 126, 2);
>> + =A0 =A0 =A0 if (csd->structure =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: unrecognised CSD=
 structure version
>> %d\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->hos=
t), csd_struct);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->hos=
t), csd->structure);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> =A0 =A0 =A0 =A0}
>> =A0@@ -207,11 +208,22 @@ static int mmc_read_ext_csd(struct mmc_c
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>> =A0 =A0 =A0 =A0}
>> =A0+ =A0 =A0 =A0/* Version is coded in the CSD_STRUCTURE byte in the=
 EXT_CSD
>> register */
>> + =A0 =A0 =A0 if (card->csd.structure =3D=3D 3) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ext_csd_struct =3D ext_csd[EXT_CSD=
_STRUCTURE];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd_struct > 2) {
>
> 0 still isn't supported i.e.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ext_csd_struct < 1 || ext_csd_stru=
ct > 2) {
>
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: u=
nrecognised EXT_CSD
>> structure "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "versi=
on %d\n", mmc_hostname(card->host),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ext_csd_struct);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0card->ext_csd.rev =3D ext_csd[EXT_CSD_REV];
>> =A0 =A0 =A0 =A0if (card->ext_csd.rev > 5) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: unrecognised EXT_=
CSD structure "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "version %d\n", mmc_ho=
stname(card->host),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: unrecognised EXT_=
CSD revision %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->hos=
t), card->ext_csd.rev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EINVAL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>> =A0 =A0 =A0 =A0}
>> diff -puN include/linux/mmc/card.h~mmc-recognize-csd-structure
>> include/linux/mmc/card.h
>> --- a/include/linux/mmc/card.h~mmc-recognize-csd-structure
>> +++ a/include/linux/mmc/card.h
>> @@ -24,6 +24,7 @@ struct mmc_cid {
>> =A0};
>> =A0struct mmc_csd {
>> + =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 structure;
>> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 mmca_vsn;
>> =A0 =A0 =A0 =A0unsigned short =A0 =A0 =A0 =A0 =A0cmdclass;
>> =A0 =A0 =A0 =A0unsigned short =A0 =A0 =A0 =A0 =A0tacc_clks;
>> diff -puN include/linux/mmc/mmc.h~mmc-recognize-csd-structure
>> include/linux/mmc/mmc.h
>> --- a/include/linux/mmc/mmc.h~mmc-recognize-csd-structure
>> +++ a/include/linux/mmc/mmc.h
>> @@ -254,6 +254,7 @@ struct _mmc_csd {
>> =A0#define EXT_CSD_BUS_WIDTH =A0 =A0 =A0183 =A0 =A0 /* R/W */
>> =A0#define EXT_CSD_HS_TIMING =A0 =A0 =A0185 =A0 =A0 /* R/W */
>> =A0#define EXT_CSD_CARD_TYPE =A0 =A0 =A0196 =A0 =A0 /* RO */
>> +#define EXT_CSD_STRUCTURE =A0 =A0 =A0194 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_REV =A0 =A0 =A0 =A0 =A0 =A0192 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_SEC_CNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0212 =A0 =A0=
 /* RO, 4 bytes */
>> =A0#define EXT_CSD_S_A_TIMEOUT =A0 =A0217
>> _
>>
>> Patches currently in -mm which might be from kmpark@infradead.org ar=
e
>>
>> mmc-recognize-csd-structure.patch
>>
>>
>
>
