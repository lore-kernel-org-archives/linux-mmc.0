From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] Disable the non working eMMC on Zoom2/3
Date: Thu, 1 Apr 2010 17:58:48 -0500
Message-ID: <009a01cad1ee$e3bbae70$544ff780@am.dhcp.ti.com>
References: <37310.192.168.10.89.1270081542.squirrel@dbdmail.itg.ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030D32CEE8@dbde02.ent.ti.com> <008601cad1bd$6d0022b0$544ff780@am.dhcp.ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030D32D372@dbde02.ent.ti.com> <4BB51740.2060802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58453 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab0DAW6z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2010 18:58:55 -0400
In-Reply-To: <4BB51740.2060802@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Nishanth Menon' <nm@ti.com>, "'Ghorai, Sukumar'" <s-ghorai@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com]
> Sent: Thursday, April 01, 2010 4:59 PM
> To: Ghorai, Sukumar
> Cc: Chikkature Rajashekar, Madhusudhan; tony@atomide.com; linux-
> omap@vger.kernel.org; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
> 
> Ghorai, Sukumar had written, on 04/01/2010 01:34 PM, the following:
> 
> >>>> -----Original Message-----
> >>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >>>> owner@vger.kernel.org] On Behalf Of Chikkature Rajashekar,
> Madhusudhan
> >>>> Sent: 2010-04-01 05:56
> >>>> To: tony@atomide.com
> >>>> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org
> >>>> Subject: [PATCH] Disable the non working eMMC on Zoom2/3
> >>>>
> >>>> From: Madhusudhan Chikkature <madhu.cr@ti.com>
> >>>> Date: Wed, 31 Mar 2010 12:29:19 -0400
> >>>> Subject: [PATCH] Zoom2/3: Disable MMC
> >>>>
> >>>> The eMMC on Zoom2/3 seems to have a lower EXT_CSD Rev.This causes the
> >>>> writes to fail since the card size is not detected correctly by the
> >> MMC
> >>>> core. Disable the MMC2 support for Zoom2/3.
> >>>
> >>> [Ghorai] Please let us know the EXT_CSD Rev you see in zoom3 and the
> >> exact
> >>> problem. Because we never face any issue for eMMC in ZOOM3. Because we
> >>> have the same eMMC device in 3630-SDP and could have the same problem.
> >>>
> >> On Zoom3 the EXT_CSD Rev reported by eMMC is zero. See the log
> attached.
> >>
> >> Hence the failures which are reported by people on the list. I had
> already
> >> bought this problem up on the list previously and was discussed, right?
> >> From the log you can also see that a 16GB device is detected as a 1GB.
> >
> > [Ghorai] I feel it's an issue with eMMC in pilot-board. And production-
> board is working fine. And I feel outside TI people having production
> board only. And 16GB eMMC device is a very good size to work with
> different things. Otherwise we are talking about MMC#2 boot, eMMC boot,
> 16GB eMMC device in zoom,.. all these information in different page/ link
> looks very misleading information, if really having such problem.
> > I the mean time I will check this in Pilot board too and think you
> checked in pilot board only.
> >
> Ref [1] I believe tony has the brand new zoom board - I think your
> assumption here might be flawed..
> 

Wait, I just looked up the serial number on the board. The one I was using
is a pilot version where this problem exists.

I happen to get an other board which is production unit with ser # 1013089
Rev B. The eMMC on this board has no issue. It reports the EXT_CSD Rev 2
which is correct and works fine.

http://omappedia.org/wiki/Zoom_Resources

There is a table here which could help.

Tony, do you care to just look up the serial number of your board?

But again there are several boards out there which could have this
non-working eMMC. So what do we do?? It does not make sense to keep
something enabled which does not work.

Regards,
Madhu

> --
> Regards,
> Nishanth Menon
> Ref:
> [1] http://marc.info/?l=linux-omap&m=126938456103707&w=2

