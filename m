From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 06/13] mmc: tmio-mmc: define device-tree bindings
Date: Thu, 14 Feb 2013 15:51:07 +0000
Message-ID: <201302141551.08045.arnd@arndb.de>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de> <CANqRtoQCRahB1BUKFr+o+5gKysgw3FC_MC2AUvtODSz76XmGkA@mail.gmail.com> <Pine.LNX.4.64.1302141017280.29693@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:65015 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758040Ab3BNPvS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Feb 2013 10:51:18 -0500
In-Reply-To: <Pine.LNX.4.64.1302141017280.29693@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, SH-Linux <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Thursday 14 February 2013, Guennadi Liakhovetski wrote:
> On Thu, 14 Feb 2013, Magnus Damm wrote:
> > On Thu, Feb 14, 2013 at 5:28 PM, Guennadi Liakhovetski
> > > My take on this is the following: having N optionally available on
> > > different IP-versions features, I'd rather have N DT properties, than up
> > > to 2^N abstract vX versions. Yes, I realise, that in practice we'll never
> > > have 2^N, rather just a bit more than N, still, my main problem with those
> > > versions, is that they are purely abstracted. I'd be happy if that was a
> > > real hardware revision string, that you could look up in a datasheet. But
> > > if you have to look in some text file... That just seems much less
> > > user-friendly to me, than selecting single properties. Just imagine, what
> > > would you prefer, either specifying
> > >
> > >         feature-A;
> > >         feature-B;
> > >
> > > in your .dts or going through a list of
> > >
> > > v1: has no features
> > > v2: feature A only
> > > v3: feature B only
> > > v4: features A and B
> > > ...
> > 
> > In this particular case based on the information above:
> > 
> > toshiba,mmc-blksz-2bytes
> > toshiba,mmc-has-idle-wait
> > 
> > or my guess:
> > 
> > renesas,shmobile-sdhi-v1: TMIO_MMC_BLKSZ_2BYTES
> > renesas,shmobile-sdhi-v2: TMIO_MMC_BLKSZ_2BYTES + TMIO_MMC_HAS_IDLE_WAIT
> 
> toshiba,mmc-blksz-2bytes we don't need - it's set for all SDHI devices. 
> So, _so far_ we only have one feature, that we have to specify in DT 
> either via a property or a compatible version string.

Right. I would still prefer the different "compatible" property, but it's not
an extremely important thing here. Regarding the naming of the "compatible"
string, I would not use v1 and v2 postfixes though, unless that is what they
are called in the data sheet. Ideally we would know the exact version
of the IP block that went into the chip and drop the "shmobile-" part.

That would make it something like "toshiba,sdhi-1.23.45". If you cannot
easily find out those versions, the next best solution would be naming it
after the chip that first used a particular version of that IP block,
like "renesas,shmobile1234-sdhi". The device tree include file for
shmobile5678 should then list the sdhi part as being compatible with
the "reneasas,shmobile1234-sdhi" if they are the same, or as
a separate "reneasas,shmobile5678-sdhi" if they behave in a different
way. In either case, I would also list the "toshiba,sdhi" name as
the more generic option in the "compatible" list, but that is optional.

	Arnd
