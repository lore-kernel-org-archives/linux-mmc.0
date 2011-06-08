From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Wed, 8 Jun 2011 17:02:54 +0300
Message-ID: <BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com> <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
 <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com> <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
 <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com> <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54813 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208Ab1FHODP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 10:03:15 -0400
Received: by wwa36 with SMTP id 36so606361wwa.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2011 07:03:14 -0700 (PDT)
In-Reply-To: <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Wed, Jun 8, 2011 at 4:36 PM, Daniel Drake <dsd@laptop.org> wrote:
> If I add the reset (shown commented-out in the patch), it matches the
> behaviour of other known-good codepaths and also solves the problem.

Yeah, but we don't know why. And we may very well be covering a
different bug if we just take it as-is.

Don't get me wrong, I have no objection to have this if it's needed,
but we shouldn't do this just "because it works".

So I'll try to look at the logs you provided a bit more later, but the
main questions I have are:

1. How come power off+on works for you in the first time, but doesn't
work in the second time ?
2. Was the card really powered off in this 2nd-time failed scenario ?
3. what if you do a series of insmod+rmmod ? does this work ? (power
should be taken down and up every time)
4. Are you also interested in powering off the card when the wlan
interface is down (i.e. coupling the power of the card with the state
of the interface) too ? it should be easy to debug.
