From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [comments] MMC: Reliable write support.
Date: Wed, 30 Mar 2011 14:05:20 +0200
Message-ID: <201103301405.21047.arnd@arndb.de>
References: <1301001751-30785-1-git-send-email-andreiw@motorola.com> <201103290901.31680.arnd@arndb.de> <AANLkTinDdEJ0bwH3Kj_QmhD=Z=07eaRvpA=sASn+DmkJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57910 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803Ab1C3MF0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 08:05:26 -0400
In-Reply-To: <AANLkTinDdEJ0bwH3Kj_QmhD=Z=07eaRvpA=sASn+DmkJ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wednesday 30 March 2011, Andrei Warkentin wrote:
> On Tue, Mar 29, 2011 at 2:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 29 March 2011, Andrei Warkentin wrote:
> >> On Fri, Mar 25, 2011 at 10:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> I confirmed with two MMC vendors that there is no "flush". Once the
> >> DAT transfer completes, the data is stored on non-volatile storage as
> >> soon as the busy status is cleared.
> >>
> >> Reliable writes are still "more reliable" because if the DAT transfer
> >> is interrupted (power or reset through CMD0/CMD15 or hw pin for eMMC),
> >> you have predictable flash contents. So it makes sense to map REQ_FUA
> >> to it (and REQ_META, I would guess).
> >
> > Yes, sounds good.
> >
> > So I guess on MLC flash, a reliable write will go to a flash page
> > that does not have data in any of its paired pages.
> 
> Should I resubmit the patch?

I think the patch was ok, you can add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Chris, what is your opinion on the patch?

	Arnd
