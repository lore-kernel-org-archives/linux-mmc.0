From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: + s5pc110-sdhci-s3c-can-override-host-capabilities.patch added to
	-mm tree
Date: Fri, 11 Jun 2010 12:24:00 +0900
Message-ID: <AANLkTim-ltyN6dj-eKUKXIMxOe18ipzvos6m68hGpSve@mail.gmail.com>
References: <201006102043.o5AKhEtI022722@imap1.linux-foundation.org>
	<20100611003414.GB3498@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41447 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382Ab0FKDYB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2010 23:24:01 -0400
In-Reply-To: <20100611003414.GB3498@trinity.fluff.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-mmc@vger.kernel.org

On Fri, Jun 11, 2010 at 9:34 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Thu, Jun 10, 2010 at 01:43:14PM -0700, akpm@linux-foundation.org w=
rote:
>>
>> The patch titled
>> =A0 =A0 =A0s5pc110: SDHCI-s3c can override host capabilities
>> has been added to the -mm tree. =A0Its filename is
>> =A0 =A0 =A0s5pc110-sdhci-s3c-can-override-host-capabilities.patch
>>
>> Before you just go and hit "reply", please:
>> =A0 =A0a) Consider who else should be cc'ed
>> =A0 =A0b) Prefer to cc a suitable mailing list as well
>> =A0 =A0c) Ideally: find the original patch on the mailing list and d=
o a
>> =A0 =A0 =A0 reply-to-all to that, adding suitable additional cc's
>>
>> *** Remember to use Documentation/SubmitChecklist when testing your =
code ***
>>
>> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
>> out what to do about this
>>
>> The current -mm tree may be found at http://userweb.kernel.org/~akpm=
/mmotm/
>>
>> ------------------------------------------------------
>> Subject: s5pc110: SDHCI-s3c can override host capabilities
>> From: Kyungmin Park <kmpark@infradead.org>
>>
>> Each board can override the default sdhci host capabilities.
>> Some board has broken features by hardwares and support 8-bit bandwi=
dth.
>
> I'd much rather see a mask to remove unsupported features than simply
> override the already read hardware mask.

what do you mean? please see the Marek patch, each boards can use its
own connection and configurations. So there's default caps (it's from
you) and board can override it for their own purpose.

Thank you,
Kyungmin Park

>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: <linux-mmc@vger.kernel.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>> =A0arch/arm/plat-samsung/dev-hsmmc.c =A0| =A0 =A02 ++
>> =A0arch/arm/plat-samsung/dev-hsmmc1.c | =A0 =A02 ++
>> =A0arch/arm/plat-samsung/dev-hsmmc2.c | =A0 =A02 ++
>> =A03 files changed, 6 insertions(+)
>>
>> diff -puN arch/arm/plat-samsung/dev-hsmmc.c~s5pc110-sdhci-s3c-can-ov=
erride-host-capabilities arch/arm/plat-samsung/dev-hsmmc.c
>> --- a/arch/arm/plat-samsung/dev-hsmmc.c~s5pc110-sdhci-s3c-can-overri=
de-host-capabilities
>> +++ a/arch/arm/plat-samsung/dev-hsmmc.c
>> @@ -65,4 +65,6 @@ void s3c_sdhci0_set_platdata(struct s3c_
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_gpio =3D pd->cfg_gpio;
>> =A0 =A0 =A0 if (pd->cfg_card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_card =3D pd->cfg_card;
>> + =A0 =A0 if (pd->host_caps)
>> + =A0 =A0 =A0 =A0 =A0 =A0 set->host_caps =3D pd->host_caps;
>> =A0}
>> diff -puN arch/arm/plat-samsung/dev-hsmmc1.c~s5pc110-sdhci-s3c-can-o=
verride-host-capabilities arch/arm/plat-samsung/dev-hsmmc1.c
>> --- a/arch/arm/plat-samsung/dev-hsmmc1.c~s5pc110-sdhci-s3c-can-overr=
ide-host-capabilities
>> +++ a/arch/arm/plat-samsung/dev-hsmmc1.c
>> @@ -65,4 +65,6 @@ void s3c_sdhci1_set_platdata(struct s3c_
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_gpio =3D pd->cfg_gpio;
>> =A0 =A0 =A0 if (pd->cfg_card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_card =3D pd->cfg_card;
>> + =A0 =A0 if (pd->host_caps)
>> + =A0 =A0 =A0 =A0 =A0 =A0 set->host_caps =3D pd->host_caps;
>> =A0}
>> diff -puN arch/arm/plat-samsung/dev-hsmmc2.c~s5pc110-sdhci-s3c-can-o=
verride-host-capabilities arch/arm/plat-samsung/dev-hsmmc2.c
>> --- a/arch/arm/plat-samsung/dev-hsmmc2.c~s5pc110-sdhci-s3c-can-overr=
ide-host-capabilities
>> +++ a/arch/arm/plat-samsung/dev-hsmmc2.c
>> @@ -66,4 +66,6 @@ void s3c_sdhci2_set_platdata(struct s3c_
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_gpio =3D pd->cfg_gpio;
>> =A0 =A0 =A0 if (pd->cfg_card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set->cfg_card =3D pd->cfg_card;
>> + =A0 =A0 if (pd->host_caps)
>> + =A0 =A0 =A0 =A0 =A0 =A0 set->host_caps =3D pd->host_caps;
>> =A0}
>> _
>>
>> Patches currently in -mm which might be from kmpark@infradead.org ar=
e
>>
>> mmc-recognize-csd-structure.patch
>> mmc-recognize-csd-structure-fix.patch
>> s5pc110-sdhci-s3c-can-override-host-capabilities.patch
>> s5pc110-sdhci-s3c-support-on-s5pc110.patch
>> sdhci-add-no-hi-speed-bit-quirk-support.patch
>>
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
