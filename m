From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [Bug 15836] Commit 6ad696d2cf535772dff659298ec7e7260e344595
	breaks my SD card reader [197b:2381]
Date: Tue, 4 May 2010 22:13:03 +0200
Message-ID: <20100504201302.GD13655@basil.fritz.box>
References: <bug-15836-27@https.bugzilla.kernel.org/> <201004262048.o3QKml95025961@demeter.kernel.org> <20100426135800.28378e99.akpm@linux-foundation.org> <20100430170614.GA22807@gargoyle.fritz.box> <1272739661.10538.30.camel@weslok.olx.intra> <20100501230443.GB8074@gargoyle.fritz.box> <1272912441.7490.6.camel@weslok.olx.intra>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:46276 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933608Ab0EDUNE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2010 16:13:04 -0400
Content-Disposition: inline
In-Reply-To: <1272912441.7490.6.camel@weslok.olx.intra>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephan =?iso-8859-1?Q?S=FCrken?= <absurd@olurdix.de>
Cc: Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org

On Mon, May 03, 2010 at 08:47:21PM +0200, Stephan S=FCrken wrote:
> On Sun, 2010-05-02 at 01:04 +0200, Andi Kleen wrote:
> (..)=20
> > > config-2.6.33.2.git19f00f0-config-2.6.33-2-amd64.nohiber:CONFIG_M=
EMORY_HOTPLUG=3Dy
> > > =3D>"bad"
> > > config-2.6.33.2.git19f00f0-config-2.6.33-2-amd64.nohotplug:# CONF=
IG_MEMORY_HOTPLUG is not set
> > > =3D>"good"
> (..)
> > Can send the diff of two boot logs with memory hotplug on and off?
> > I wonder if you have the same memory layout in both cases.
>=20
> Attached, from the above two good/bad kernel builds; I stripped the
> stamps to make it more readable.

Thanks,

I was hoping for a comparison between memory hotplug on and off with
hibernation always off, this seems to be between memory hotplug and=20
hibernation.=20

Anyways looking at this log. The only significant difference I can
see is that in the one case a lot of stuff including sdhci=20
get initialized earlier. Presumably the timing is somewhat=20
different related to the USB scanning and the memory hotadd
kernel being a bit slower to boot (perhaps due to the increased printks=
)

Perhaps this exposes some races that cause the problem.
What these races are I don't know.

I would suggest to check with the mmc maintainer.

-Andi
