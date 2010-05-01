From: Stephan =?ISO-8859-1?Q?S=FCrken?= <absurd@olurdix.de>
Subject: Re: [Bug 15836] Commit 6ad696d2cf535772dff659298ec7e7260e344595
	breaks my SD card reader [197b:2381]
Date: Sat, 01 May 2010 20:47:41 +0200
Message-ID: <1272739661.10538.30.camel@weslok.olx.intra>
References: <bug-15836-27@https.bugzilla.kernel.org/>
	 <201004262048.o3QKml95025961@demeter.kernel.org>
	 <20100426135800.28378e99.akpm@linux-foundation.org>
	 <20100430170614.GA22807@gargoyle.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58358 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756915Ab0EASsv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 1 May 2010 14:48:51 -0400
In-Reply-To: <20100430170614.GA22807@gargoyle.fritz.box>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org

On Fri, 2010-04-30 at 19:06 +0200, Andi Kleen wrote:
> The mission information is which CONFIG_* option changes the behaviou=
r.
> (or maybe it's in the bugzilla, i just skimmed it very quickly)
>=20
> presumably it's either hibernation or memory hotadd that introduces
> the problem.
>=20
> My patch just allowed to have both together.
>=20
> Once it's determined which one it is one could do a second bisect
> with that option always on (and the other off)? Or maybe it's not a=20
> regression.

Thx Andi. I now get the obvious: the way I built the kernels (using
standard Debian configs as template, having both CONFIG_MEMORY_HOTPLUG
and CONIG_HIBERNATION enabled), without your commit,
CONFIG_MEMORY_HOTPLUG was implicitly turned off. Bummer.

Enabling CONFIG_MEMORY_HOTPLUG actually enables the bug.

I explicitly confirmed this on top of 2.6.33.2:

config-2.6.33.2.git19f00f0-config-2.6.33-2-amd64.nohiber:CONFIG_MEMORY_=
HOTPLUG=3Dy
=3D>"bad"
config-2.6.33.2.git19f00f0-config-2.6.33-2-amd64.nohotplug:# CONFIG_MEM=
ORY_HOTPLUG is not set
=3D>"good"

So any code enabled by CONFIG_MEMORY_HOTPLUG is the winner, presumable
somewhere in the mmc code (?).

I am not sure how to proceed, now. To bisect I would need to guess/find
a "good" kernel first, if there is one. Maybe some hints how to best
debug the code in question would be more helpful...

Thx,

Stephan
--=20
Stephan S=C3=BCrken <absurd at olurdix.de>

