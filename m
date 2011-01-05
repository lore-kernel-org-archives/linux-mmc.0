From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: outstanding TMIO MMC patches
Date: Thu, 6 Jan 2011 08:31:37 +0900
Message-ID: <20110105233137.GI23889@linux-sh.org>
References: <Pine.LNX.4.64.1012281211560.21647@axis700.grange> <AANLkTi=NWFmskvAosK9fO65OGNLrqEY-_PdvKydyn=G2@mail.gmail.com> <20110105045347.GA23889@linux-sh.org> <20110105165757.GA7876@void.printf.net> <20110105173029.GG23889@linux-sh.org> <20110105185717.GA9016@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:54046 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab1AEXdf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jan 2011 18:33:35 -0500
Content-Disposition: inline
In-Reply-To: <20110105185717.GA9016@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org

On Wed, Jan 05, 2011 at 06:57:17PM +0000, Chris Ball wrote:
> On Thu, Jan 06, 2011 at 02:30:30AM +0900, Paul Mundt wrote:
> > This is basically where the problem lies. Ian has some version of the
> > hardware that we don't, and he likewise doesn't have access to the
> > version that we do (of course there would be no problem in making the
> > hardware available to whoever decides to step up and look after TMIO in a
> > more constructive fashion, though). There are likewise issues with
> > regards to who has access to what specifications, and there are cases
> > where neither Ian nor any of the people from our side have any specs at
> > all. With this sort of a scenario it can be quite difficult to avoid
> > stepping on other peoples toes and making sure that things aren't being
> > inadvertently broken, and this is something I don't see any specific
> > resolution to, other than if you're not around to test and object in a
> > timely fashion, you lose. I don't know if other MMC drivers have the same
> > problem or not, but I can't imagine that this situation is terribly
> > unique when you have both corporations and hobbyists working on the same
> > driver from vastly different angles.
> 
> I see.  So, if most patches are coming from your side, it seems that the
> largest problem for the moment is that no-one except Ian can test your
> patches against his hardware.  Do we think there's any chance of someone
> (I guess ideally you but possibly me) getting hold of hardware with Ian's
> MMC block in, for at least occasional testing before releases?
> 
> If not, is there any kind of split in the driver that we could use to try
> to isolate changes more?
> 
The biggest difference is that the stuff Ian is working with is a
full-blown MFD, while from our side we're simply dealing with an insular
MFD cell. At the moment we have a shim single-function MFD driver
(sh_mobile_shdi) that simply packages up the insular cell and binds it to
tmio-mmc so that we could keep using the same interface on the MMC side
without having to hack up the driver irreperably.

The behaviour however is not always the same, which you can already see
in things like 311f3ac76826bfd8ed6213ded91ec947df164def when DMA support
was added. For the most part it's been posible to keep things fairly
compartmentalized by layering on top of MFD, but there are plenty of
cases where we just have to make assumptions about how the other versions
of the block work. Given that we don't have an MFD in any of the blocks
we're using, it's not always readily apparent what the best way to split
things out is while keeping within the spirit of the MFD layering. How
best to handle runtime PM for example remains an outstanding issue.

As far as I can tell, all of the other MFD drivers using tmio-mmc are
already years old and mostly seem to have come out of the handhelds.org
work. Some of them bear recent copyrights but were ported from 2.4 code,
and so date from that era of hardware. I expect that for the most part
these have all been end of lifed from Toshiba's side already, so it's not
entirely obvious how easy they will be to procure. I'll take a look and
see what I can dig up though, and of course we're happy to send hardware
with our version of the block in it to whoever wishes to do independent
testing.
