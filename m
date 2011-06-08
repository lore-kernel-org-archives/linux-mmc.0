From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Wed, 8 Jun 2011 21:58:50 +0100
Message-ID: <BANLkTinhRwr+qxujeFhy3C4LBkA5p2+ph_e1sy6vcuCiD_vKUA@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
	<BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com>
	<BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
	<BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com>
	<BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
	<BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com>
	<BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
	<BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com>
	<BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
	<BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63657 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab1FHU6u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 16:58:50 -0400
Received: by pwi15 with SMTP id 15so428932pwi.19
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2011 13:58:50 -0700 (PDT)
In-Reply-To: <BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 8 June 2011 21:05, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> We have 3 power-on paths here: on boot, on insmod, and and resume.
>
> I understand the first one succeeds (naturally), and the last one
> failed, but now I'm confused what was the outcome of the 2nd (without
> sending a reset cmd) ?

Not really sure what you're asking. Unless its the test below?

>>> 3. what if you do a series of insmod+rmmod ? does this work ? (power
>>> should be taken down and up every time)
>>
>> rmmod doesn't appear to take down the power.
>
> Let's nail this one first. if we get it right, the rest will immediately follow.
>
> Please reboot, and immediately after booting (without insmoding the
> driver) tell me what's the output of :
>
> mount -t debugfs none /sys/kernel/debug
> cat /sys/kernel/debug/mmc1/ios
>
> Then insmod the driver, and tell me again what's the output of
> /sys/.../mmc1/ios.

Which base kernel setup should I run these tests on?

Thanks,
Daniel
