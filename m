From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Wed, 8 Jun 2011 15:21:30 +0100
Message-ID: <BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
	<BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com>
	<BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
	<BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com>
	<BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
	<BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com>
	<BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
	<BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:40457 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959Ab1FHOVb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 10:21:31 -0400
Received: by pxi2 with SMTP id 2so403252pxi.10
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2011 07:21:30 -0700 (PDT)
In-Reply-To: <BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 8 June 2011 15:02, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Wed, Jun 8, 2011 at 4:36 PM, Daniel Drake <dsd@laptop.org> wrote:
>> If I add the reset (shown commented-out in the patch), it matches the
>> behaviour of other known-good codepaths and also solves the problem.
>
> Yeah, but we don't know why. And we may very well be covering a
> different bug if we just take it as-is.
>
> Don't get me wrong, I have no objection to have this if it's needed,
> but we shouldn't do this just "because it works".
>
> So I'll try to look at the logs you provided a bit more later, but the
> main questions I have are:
>
> 1. How come power off+on works for you in the first time, but doesn't
> work in the second time ?

I assume it is because a different codepath was taken in order to
power up the device the first time, before it then got powered down,
compared to the codepath that failed to power it up the 2nd time. My
efforts so far have been based around eliminating the differences in
those codepaths, and this approach seems to be successful.

> 2. Was the card really powered off in this 2nd-time failed scenario ?

How do you suggest I check that? I believe it was, since
mmc_stop_host() got called, and colleagues with proper equipment
measured the difference in power usage a while back.

> 3. what if you do a series of insmod+rmmod ? does this work ? (power
> should be taken down and up every time)

rmmod doesn't appear to take down the power.

> 4. Are you also interested in powering off the card when the wlan
> interface is down (i.e. coupling the power of the card with the state
> of the interface) too ? it should be easy to debug.

Yes, and I have a patch ready that does that. But first it depends on
getting the power on/off routines working reliably.

Thanks for your help.

Daniel
