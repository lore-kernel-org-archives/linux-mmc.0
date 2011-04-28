From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] mmc: subtract boot sectors from disk size for eMMC 4.3+ devices
Date: Thu, 28 Apr 2011 14:05:49 -0500
Message-ID: <BANLkTin5Kw=08HsYWzAwph8AS6mSoWWBMg@mail.gmail.com>
References: <1299327344-12462-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTinzAzg6ot5bLLjey04Do4ZFT6_5FA@mail.gmail.com>
	<BANLkTi=DpCm-12CAkFbwYMgRkzPTVatd+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:41034 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab1D1TFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 15:05:52 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3SJ3mlV007527
	for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 15:03:48 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3SIx51p004866
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 15:03:48 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so3222569wwb.3
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 12:05:49 -0700 (PDT)
In-Reply-To: <BANLkTi=DpCm-12CAkFbwYMgRkzPTVatd+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Sebastian Rasmussen <Sebastian.Rasmussen@stericsson.com>

On Thu, Apr 28, 2011 at 1:00 PM, Colin Cross <ccross@google.com> wrote:
> On Thu, Apr 28, 2011 at 3:33 AM, Linus Walleij <linus.walleij@linaro.=
org> wrote:
>> 2011/3/5 Linus Walleij <linus.walleij@stericsson.com>:
>>
>>> This patch is a squash of patches from Gary King and Ulf
>>> Hansson done in Android trees, hopefully fixing the issue properly.
>>>
>>> The csd sector count reported by eMMC 4.3+ cards includes the boot
>>> partition size; subtract this from the size reported to the disk
>>> since the boot partition is inaccessible.
>>
>> I'm trying to get somewhere with this.
>>
>> AFAICT reading the spec it does not say anything about the
>> boot sectors being subtracted from the pool of available sectors,
>> i.e. either you set these sectors aside permanently or you do not
>> support the feature.
>>
>> So the behaviour fixed in this patch should be a per-card quirk,
>> not generic.
>>
>> Then this:
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* size is in 256K ch=
unks, i.e. 512 sectors each */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 boot_sectors =3D ext_=
csd[EXT_CSD_BOOT_SIZE_MULTI] * 512;
>>
>> This is not what the spec says. It states that the size is
>> in 128KB chunks, so the correct code shoul be:
>>
>> boot_sectors =3D ext_csd[EXT_CSD_BOOT_SIZE_MULTI] * 256;
>>
>> Any comments on this? I guess it's been working, the
>> patch prent in the Android kernels simply remove twice as
>> many sectors as required from the card sector pool :-/
>
> This patch was dropped from the Android tree, it is clearly not
> correct for all eMMC devices. =A0We have worked around the problem on
> the affected by letting the bootloader tell us where it put the GPT
> near the end of the device, in which case the actual size of the
> device becomes irrelevant.
>
> I'm not convinced that any eMMC chip has this problem, it may have
> just been confusion on the part of nVidia caused by their bootloader'=
s
> "logical block" addressing system, where the boot sectors are
> addressed as 0, and the regular area starts at sizeof(boot sector).
> The off-by-two error may have been caused by the affected eMMC having
> two boot sectors.
>
> I would suggest forgetting about this patch unless someone can prove
> that there is a device that fails to write at the end.

Plus as far as linux-mmc tree, the boot size calculation is now
correct for enabling the boot hardware partitions as separate logical
devices...
All the cards I've tested (granted, wasn't too many) handled boot
partitions correctly, and the user partition area size never included
the boot partitions.

So I think we can forget about Gary's patch. For broken hardware we
now have the quirk hooks in block.c to work around this if said broken
hardware actually exists...

A
