From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] Disable the non working eMMC on Zoom2/3
Date: Wed, 5 May 2010 20:35:51 -0500
Message-ID: <00a501caecbc$761ded40$544ff780@am.dhcp.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030D32D372@dbde02.ent.ti.com> <4BB51740.2060802@ti.com> <009a01cad1ee$e3bbae70$544ff780@am.dhcp.ti.com> <20100407114938.GF7153@atomide.com> <003801cad73e$86841df0$544ff780@am.dhcp.ti.com> <20100427182111.GE7225@atomide.com> <20100428192322.GG7225@atomide.com> <006801cae709$e136fe40$544ff780@am.dhcp.ti.com> <20100428194553.GH7225@atomide.com> <006f01cae886$38da6920$544ff780@am.dhcp.ti.com> <20100505182727.GA29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52216 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785Ab0EFBfz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 May 2010 21:35:55 -0400
In-Reply-To: <20100505182727.GA29604@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>
Cc: 'Nishanth Menon' <nm@ti.com>, "'Ghorai, Sukumar'" <s-ghorai@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, May 05, 2010 1:27 PM
> To: Madhusudhan
> Cc: 'Nishanth Menon'; 'Ghorai, Sukumar'; linux-omap@vger.kernel.org;
> linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
> 
> * Madhusudhan <madhu.cr@ti.com> [100430 09:52]:
> > <snip>
> >
> > > > >
> > > > > > Hmm, finally got around looking into this again. Looks like the
> mmc
> > > > > > is now working on my zoom3 with the current Linus' tree at
> commit
> > > > > > 7c6bd2010fced38444c9fd658f4c6ce61bd185bf. So I guess something
> that
> > > > > > we had in omap-fixes fixed this. Or maybe some fix for
> drivers/mmc?
> > > > > >
> > > > > > This is with the debug_ll patch applied:
> > > > > >
> > > > > > https://patchwork.kernel.org/patch/87532/
> > > > >
> > > > > For the microSD card, turns out the card I used was flakey. So
> > > > > that should explain some of the problems. I'm almost certain
> > > > > I tried with two different cards earlier though. In any case,
> > > > > let's assume the problem is only the eMMC.
> > > > >
> > > > Sorry, I did not get a complete picture. Your earlier email said
> that
> > > with
> > > > Linus tree eMMC on your Zoom3 is working. Is that correct?
> > >
> > > Nope, now the microSD is working, eMMC is not working.
> > >
> > > > IMHO, an omap level fix can not solve the problem with eMMC because
> as I
> > > can
> > > > see from the log you provided above that a 16G device is detected as
> 1G.
> > > > This is certainly due to the issue I mentioned earlier.
> > >
> > > OK
> >
> > This means that some production boards still have this issue with eMMC.
> So
> > my patch disables the support for MMC2 on zoom boards. Would you
> consider
> > that?
> 
> But is it also broken on zoom2?
>

Yes.

> And what about this "Simulate multi mmc card as one big" patch?
>
Did not get you, what patch are you referring to?

Regards,
Madhu
 
> Regards,
> 
> Tony

