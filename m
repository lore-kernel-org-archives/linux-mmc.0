From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: MMC_CAP_POWER_OFF_CARD, MMC_PM_KEEP_POWER - when to set
Date: Thu, 24 May 2012 17:42:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205241737420.1462@axis700.grange>
References: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
 <CAK=Wgbb7RwAhhSCwb-NYCd8SNzQTJSNna8t4Zqdi5Q9T1ADSxg@mail.gmail.com>
 <Pine.LNX.4.64.1205241441240.1462@axis700.grange>
 <CAK=WgbZNeMZ+J-0t-piUNuMnrh5TjCAPBMpaTSJc=GnSx6z2YA@mail.gmail.com>
 <Pine.LNX.4.64.1205241559060.1462@axis700.grange>
 <CAK=WgbZggEEyrbp6QLHC+O+H7nOZrZuRuam2KJijTGGs=Oeozg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63878 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327Ab2EXPm5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 11:42:57 -0400
In-Reply-To: <CAK=WgbZggEEyrbp6QLHC+O+H7nOZrZuRuam2KJijTGGs=Oeozg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>

Hi Ohad

On Thu, 24 May 2012, Ohad Ben-Cohen wrote:

> Hi Guennadi,
> 
> On Thu, May 24, 2012 at 5:06 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Sorry, I mean - you don't know what card will be plugged in, so, you
> > cannot know, whether that specific card and its driver can be safely
> > powered off.
> 
> We do know in certain cases, most commonly with wifi SDIO cards which
> are hardwired to the board.

Yes, exactly, in certain cases. And when it's not hard-wired?

> > Ok, I think, it's this: MMC_PM_KEEP_POWER is for system-wide suspend /
> > resume, whereas MMC_CAP_POWER_OFF_CARD is for runtime PM. Am I right?
> 
> MMC_CAP_POWER_OFF_CARD is used by SDIO runtime PM, but I won't
> classify it as "runtime PM" specific. It describes the hardware, and
> not inherently limited to a specific use case.

Ok

> > that case, I think, they also should function similar
> 
> Can you explain why ?

Because with pluggable cards one flag is not enough. I think, you need (1) 
board capability to switch power, and (2) driver's allowance to power the 
card down.

> > - wouldn't it make
> > sense to use MMC_CAP_POWER_OFF_CARD similar to MMC_PM_KEEP_POWER - as a
> > static capability flag (meaning, whether the board is physically able to
> > switch power) and a dynamic flag, that, say, an SDIO function driver could
> > set if it knows, that it cannot handle runtime power switching properly?
> 
> I'm not sure I'm following the reasoning.
> 
> Can you explain what are you trying to solve ? Is there a specific
> problem you have in mind ?

The problem of hot-pluggable cards. One card / driver combination will 
support powering down at runtime, another one will not.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
