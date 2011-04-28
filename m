From: Colin Cross <ccross@google.com>
Subject: Re: [PATCH] mmc: subtract boot sectors from disk size for eMMC 4.3+ devices
Date: Thu, 28 Apr 2011 11:00:29 -0700
Message-ID: <BANLkTi=DpCm-12CAkFbwYMgRkzPTVatd+g@mail.gmail.com>
References: <1299327344-12462-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTinzAzg6ot5bLLjey04Do4ZFT6_5FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:47183 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758617Ab1D1SAf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 14:00:35 -0400
Received: from kpbe14.cbf.corp.google.com (kpbe14.cbf.corp.google.com [172.25.105.78])
	by smtp-out.google.com with ESMTP id p3SI0VXN031424
	for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 11:00:31 -0700
Received: from yia28 (yia28.prod.google.com [10.243.65.28])
	by kpbe14.cbf.corp.google.com with ESMTP id p3SHxPRg020015
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 11:00:30 -0700
Received: by yia28 with SMTP id 28so1529312yia.35
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 11:00:30 -0700 (PDT)
In-Reply-To: <BANLkTinzAzg6ot5bLLjey04Do4ZFT6_5FA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Sebastian Rasmussen <Sebastian.Rasmussen@stericsson.com>

On Thu, Apr 28, 2011 at 3:33 AM, Linus Walleij <linus.walleij@linaro.or=
g> wrote:
> 2011/3/5 Linus Walleij <linus.walleij@stericsson.com>:
>
>> This patch is a squash of patches from Gary King and Ulf
>> Hansson done in Android trees, hopefully fixing the issue properly.
>>
>> The csd sector count reported by eMMC 4.3+ cards includes the boot
>> partition size; subtract this from the size reported to the disk
>> since the boot partition is inaccessible.
>
> I'm trying to get somewhere with this.
>
> AFAICT reading the spec it does not say anything about the
> boot sectors being subtracted from the pool of available sectors,
> i.e. either you set these sectors aside permanently or you do not
> support the feature.
>
> So the behaviour fixed in this patch should be a per-card quirk,
> not generic.
>
> Then this:
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* size is in 256K chu=
nks, i.e. 512 sectors each */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 boot_sectors =3D ext_c=
sd[EXT_CSD_BOOT_SIZE_MULTI] * 512;
>
> This is not what the spec says. It states that the size is
> in 128KB chunks, so the correct code shoul be:
>
> boot_sectors =3D ext_csd[EXT_CSD_BOOT_SIZE_MULTI] * 256;
>
> Any comments on this? I guess it's been working, the
> patch prent in the Android kernels simply remove twice as
> many sectors as required from the card sector pool :-/

This patch was dropped from the Android tree, it is clearly not
correct for all eMMC devices.  We have worked around the problem on
the affected by letting the bootloader tell us where it put the GPT
near the end of the device, in which case the actual size of the
device becomes irrelevant.

I'm not convinced that any eMMC chip has this problem, it may have
just been confusion on the part of nVidia caused by their bootloader's
"logical block" addressing system, where the boot sectors are
addressed as 0, and the regular area starts at sizeof(boot sector).
The off-by-two error may have been caused by the affected eMMC having
two boot sectors.

I would suggest forgetting about this patch unless someone can prove
that there is a device that fails to write at the end.
