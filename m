From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [Bug 15836] Commit 6ad696d2cf535772dff659298ec7e7260e344595
 breaks my SD card reader [197b:2381]
Date: Wed, 28 Apr 2010 23:41:39 +0100
Message-ID: <87d3xjxkrg.fsf@linux-g6p1.site>
References: <bug-15836-27@https.bugzilla.kernel.org/>
	<201004262048.o3QKml95025961@demeter.kernel.org>
	<20100426135800.28378e99.akpm@linux-foundation.org>
	<1272365957.10657.15.camel@manwe.use.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:56394 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757314Ab0D1Wln (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Apr 2010 18:41:43 -0400
In-Reply-To: <1272365957.10657.15.camel@manwe.use.schlund.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephan Suerken <absurd@olurdix.de>
Cc: linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>

On Tue, 27 Apr 2010 12:59:17 +0200, Stephan Suerken <absurd@olurdix.de> wrote:
> On Mon, 2010-04-26 at 13:58 -0700, Andrew Morton wrote:
> (...)
> > > https://bugzilla.kernel.org/show_bug.cgi?id=15836
> > > 
> > 
> > OK, I give up.
> 
> Ok, I guess it would be very helpful, first of all, if someone could
> affirm the buggy behavior on the same or similar hardware with kernels
> >=2.6.32.
> 
> The bug occurs on a "HP HDX 16" laptop; attaching some hardware
> information...

Stephan,

this one definitely looks strange. Have you tried running other
diagnostic tools on you SD card, e.g. fsck? How about on your hard disks
or other mass storage devices? Is it always the same block that's
reported as bad? Were you doing any suspend/hibernation
during these tests? It might also be an idea to turn on
CONFIG_DEBUG_PAGEALLOC and run badblocks again.

If you turn off CONFIG_HOTPLUG and CONFIG_HIBERNATION on a recent kernel
does it work then?

I'm pretty stumped as to what is going on here...
