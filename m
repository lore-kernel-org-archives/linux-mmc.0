From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Wed, 8 Jun 2011 23:05:06 +0300
Message-ID: <BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
 <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com> <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
 <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com> <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
 <BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com> <BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45143 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab1FHUIK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 16:08:10 -0400
Received: by wwa36 with SMTP id 36so955434wwa.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2011 13:08:09 -0700 (PDT)
In-Reply-To: <BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Wed, Jun 8, 2011 at 5:21 PM, Daniel Drake <dsd@laptop.org> wrote:
>> 1. How come power off+on works for you in the first time, but doesn't
>> work in the second time ?
>
> I assume it is because a different codepath was taken in order to
> power up the device the first time, before it then got powered down,
> compared to the codepath that failed to power it up the 2nd time. My
> efforts so far have been based around eliminating the differences in
> those codepaths, and this approach seems to be successful.

We have 3 power-on paths here: on boot, on insmod, and and resume.

I understand the first one succeeds (naturally), and the last one
failed, but now I'm confused what was the outcome of the 2nd (without
sending a reset cmd) ?

>> 3. what if you do a series of insmod+rmmod ? does this work ? (power
>> should be taken down and up every time)
>
> rmmod doesn't appear to take down the power.

Let's nail this one first. if we get it right, the rest will immediately follow.

Please reboot, and immediately after booting (without insmoding the
driver) tell me what's the output of :

mount -t debugfs none /sys/kernel/debug
cat /sys/kernel/debug/mmc1/ios

Then insmod the driver, and tell me again what's the output of
/sys/.../mmc1/ios.

Please send a contiguous terminal session of these steps (incl. the
boot messages), thanks !
