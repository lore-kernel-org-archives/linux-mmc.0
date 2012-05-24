From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: MMC_CAP_POWER_OFF_CARD, MMC_PM_KEEP_POWER - when to set
Date: Thu, 24 May 2012 23:15:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205242308510.1462@axis700.grange>
References: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
 <CAK=Wgbb7RwAhhSCwb-NYCd8SNzQTJSNna8t4Zqdi5Q9T1ADSxg@mail.gmail.com>
 <Pine.LNX.4.64.1205241441240.1462@axis700.grange>
 <CAK=WgbZNeMZ+J-0t-piUNuMnrh5TjCAPBMpaTSJc=GnSx6z2YA@mail.gmail.com>
 <Pine.LNX.4.64.1205241559060.1462@axis700.grange>
 <CAK=WgbZggEEyrbp6QLHC+O+H7nOZrZuRuam2KJijTGGs=Oeozg@mail.gmail.com>
 <Pine.LNX.4.64.1205241737420.1462@axis700.grange>
 <CAK=WgbZ+Cjafh==X84TNq+rZurxpswg61F=UenHKMB05k7oCGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54468 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759325Ab2EXVPi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 17:15:38 -0400
In-Reply-To: <CAK=WgbZ+Cjafh==X84TNq+rZurxpswg61F=UenHKMB05k7oCGw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Daniel Drake <dsd@laptop.org>

On Thu, 24 May 2012, Ohad Ben-Cohen wrote:

> Hi Guennadi,
> 
> On Thu, May 24, 2012 at 6:42 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Yes, exactly, in certain cases. And when it's not hard-wired?
> 
> We don't support this yet.

Ic, so, basically, for boards with normal SD-card slots SDIO-card runtime 
PM is not supported.

> Daniel suggested using either black or white listing (based on
> vendor/device id presumably) so we can support regular cards without
> breaking others, but I'm not sure if Daniel had any free cycles to
> look into it.
> 
> > Because with pluggable cards one flag is not enough. I think, you need (1)
> > board capability to switch power, and (2) driver's allowance to power the
> > card down.
> ...
> > The problem of hot-pluggable cards. One card / driver combination will
> > support powering down at runtime, another one will not.
> 
> Ah ok now I understand you, thanks for the explanation.

Sorry, I had to clarify the situation first with the flags before I could 
formulate the problem properly.

> Whether or not to involve the driver here probably depends on the
> actual hardware requirements. E.g., if the vendor/device id is enough
> information, then we might be able to implement this below the drivers
> without involving them. But in case only the driver could tell between
> variants of specific chips, then a generic white/black listing might
> not be enough.

I think it'd be better to go with driver-assisted PM straight away instead 
of implementing black-/white-lists to later find out about cards with the 
same IDs and different behaviour.

> Feel free to propose a solution, but please back it up with real
> hardware and show that it satisfies the MMC_CAP_POWER_OFF_CARD issues
> we had in the past.

Thanks:-) It was important for me in the first place to understand the 
problem. Now that the problem has become clearer we can think about 
whether, when and how to solve it and who shall do it:-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
