From: Stephan =?ISO-8859-1?Q?S=FCrken?= <absurd@olurdix.de>
Subject: Re: [Bug 15836] Commit 6ad696d2cf535772dff659298ec7e7260e344595
	breaks my SD card reader [197b:2381]
Date: Fri, 30 Apr 2010 18:53:30 +0200
Message-ID: <1272646410.6394.29.camel@weslok.olx.intra>
References: <bug-15836-2531@https.bugzilla.kernel.org/>
	 <201004282338.o3SNcfHW007926@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62915 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab0D3QzK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Apr 2010 12:55:10 -0400
In-Reply-To: <201004282338.o3SNcfHW007926@demeter.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org, matt@console-pimps.org
Cc: Andi Kleen <andi@firstfloor.org>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Matt,

On Wed, 2010-04-28 at 23:38 +0000, bugzilla-daemon@bugzilla.kernel.org =
wrote:=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D15836
(...)=20
> this one definitely looks strange.

ok, I am desperate. Maybe its time to just throw out any information I
can think of right now, hoping for some educated guess ;).

> Have you tried running other diagnostic tools on you SD card, e.g. fs=
ck?

Actually, s.th. like "mkfs;fsck --force" was my initial test before I
switched to badblocks.

As for bad media, the laptop is my working horse. I work on it every
day; when I work on it, the sd card is in use. I had no issues with it
whatsoever until I switched to 2.6.32, and I continue to have no issues
(sticking to a 2.6.30 kernel) with the very same card. And yes, after I
found the kernel upgrade broke it, I tested with a different sd card
with the same results.

So it's definitely not a media problem.

> How about on your hard disks or other mass storage devices?

Ok, good point (although I booted from the hard disk for the tests). I
run the same badblocks test (with a "bad" kernel) on a hard disk
partition and on an usb stick without issues.

So it's not a general mass storage problem.

> Is it always the same block that's reported as bad?

Ok, good point. I noted that they seem to be different, but I did not
care much yet. Now I have retested on a bad kernel (actually stock
2.6.33.2), running the test 5 times (0-4) in a row, and this three time=
s
on three bootups; the number is the first found bad blocks:

Boot 0:
0   14144
1-4 64
Boot 1 (warm boot):
0   64
1-4 64
Boot 2 (cold boot):
0   140
1-4 76

=46wiw, read-only badblock tests always work fine.

> Were you doing any suspend/hibernation during these tests?

No, all tests after fresh reboot.

> It might also be an idea to turn on
> CONFIG_DEBUG_PAGEALLOC and run badblocks again.
>=20
> If you turn off CONFIG_HOTPLUG and CONFIG_HIBERNATION on a recent ker=
nel
> does it work then?

Ok, later ;).

Thx,

Stephan
--=20
Stephan S=C3=BCrken <absurd at olurdix.de>

