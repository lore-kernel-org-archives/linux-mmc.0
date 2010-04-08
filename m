From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] Disable the non working eMMC on Zoom2/3
Date: Thu, 8 Apr 2010 12:11:27 -0500
Message-ID: <003801cad73e$86841df0$544ff780@am.dhcp.ti.com>
References: <37310.192.168.10.89.1270081542.squirrel@dbdmail.itg.ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030D32CEE8@dbde02.ent.ti.com> <008601cad1bd$6d0022b0$544ff780@am.dhcp.ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030D32D372@dbde02.ent.ti.com> <4BB51740.2060802@ti.com> <009a01cad1ee$e3bbae70$544ff780@am.dhcp.ti.com> <20100407114938.GF7153@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52672 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833Ab0DHRL3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Apr 2010 13:11:29 -0400
In-Reply-To: <20100407114938.GF7153@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>
Cc: 'Nishanth Menon' <nm@ti.com>, "'Ghorai, Sukumar'" <s-ghorai@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, April 07, 2010 6:50 AM
> To: Madhusudhan
> Cc: 'Nishanth Menon'; 'Ghorai, Sukumar'; linux-omap@vger.kernel.org;
> linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
> 
> * Madhusudhan <madhu.cr@ti.com> [100401 15:54]:
> 
> <snip>
> 
> > > Ref [1] I believe tony has the brand new zoom board - I think your
> > > assumption here might be flawed..
> > >
> >
> > Wait, I just looked up the serial number on the board. The one I was
> using
> > is a pilot version where this problem exists.
> >
> > I happen to get an other board which is production unit with ser #
> 1013089
> > Rev B. The eMMC on this board has no issue. It reports the EXT_CSD Rev 2
> > which is correct and works fine.
> >
> > http://omappedia.org/wiki/Zoom_Resources
> >
> > There is a table here which could help.
> >
> > Tony, do you care to just look up the serial number of your board?
> 
> Sorry for the delay in replying, I've been travelling for a few weeks
> and been in meetings quite a bit. Anyways, it's a 1013037 REV A board,
> which seems to be production in the table above.
> 

That means we can not assume all production units have a working eMMC.
Would you mind sharing your bootup log? When this device is detected 
something like below is a clear issue.

mmcblk1: mmc1:0001 STM16G 1.00 GiB 
mmcblk1: p1 p2

Regards,
Madhu

> > But again there are several boards out there which could have this
> > non-working eMMC. So what do we do?? It does not make sense to keep
> > something enabled which does not work.
> 
> There's arm kernel parameter for ATAG_REVISION that can be passed from
> bootloader and then the board-*.c code can initialize things accordingly
> based on the board revision.
> 
> Regards,
> 
> Tony
> 
> 
> > > [1] http://marc.info/?l=linux-omap&m=126938456103707&w=2
> >

