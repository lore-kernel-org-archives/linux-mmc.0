From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: MMC_CAP_POWER_OFF_CARD, MMC_PM_KEEP_POWER - when to set
Date: Thu, 24 May 2012 16:06:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205241559060.1462@axis700.grange>
References: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
 <CAK=Wgbb7RwAhhSCwb-NYCd8SNzQTJSNna8t4Zqdi5Q9T1ADSxg@mail.gmail.com>
 <Pine.LNX.4.64.1205241441240.1462@axis700.grange>
 <CAK=WgbZNeMZ+J-0t-piUNuMnrh5TjCAPBMpaTSJc=GnSx6z2YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57150 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932304Ab2EXOGz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 10:06:55 -0400
In-Reply-To: <CAK=WgbZNeMZ+J-0t-piUNuMnrh5TjCAPBMpaTSJc=GnSx6z2YA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>

On Thu, 24 May 2012, Ohad Ben-Cohen wrote:

> Hi Guennadi,
> 
> On Thu, May 24, 2012 at 4:07 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > How do you know, if this is a normal sd-card slot?
> 
> Not sure I follow the question.

Sorry, I mean - you don't know what card will be plugged in, so, you 
cannot know, whether that specific card and its driver can be safely 
powered off.

> But if you ask whether we can dynamically set MMC_CAP_POWER_OFF_CARD,
> then we can't (with what we know today).
> 
> This CAP is dealing with issues of specific boards which,
> unfortunately, we have no way (today) to dynamically probe.
> 
> >> No, MMC_PM_KEEP_POWER is different: it is a dynamic user decision
> >> controlling whether the card should stay on while the system is
> >> suspended,
> >
> > Isn't it both?
> 
> Yes, you're right - we need host support to keep the card powered
> while the system is suspended.
> 
> > A complete board reset in this case will differ from the card power-off
> > only in the state of the rest of the SD-card ping, e.g., the clock. So,
> > additionally switching off the clock in this case should be equivalent to
> > the board reset?
> 
> Not really - consider the example I gave you, where you are required
> to toggle a card reset pin after you power cycle it, but there's no
> way to control that pin. In that case, only a complete board reset can
> help you.
> 
> > Given the above, wouldn't it be sufficient to test (mmc->pm_flags &
> > MMC_PM_KEEP_POWER) to decide, whether the card can be suspended?
> 
> No,
> 
> MMC_PM_KEEP_POWER is about the ability (and desire) to keep the card
> powered while the system is suspended.
> 
> MMC_CAP_POWER_OFF_CARD is about the ability to power off the card
> without killing it completely until the next board reset.

Ok, I think, it's this: MMC_PM_KEEP_POWER is for system-wide suspend / 
resume, whereas MMC_CAP_POWER_OFF_CARD is for runtime PM. Am I right? In 
that case, I think, they also should function similar - wouldn't it make 
sense to use MMC_CAP_POWER_OFF_CARD similar to MMC_PM_KEEP_POWER - as a 
static capability flag (meaning, whether the board is physically able to 
switch power) and a dynamic flag, that, say, an SDIO function driver could 
set if it knows, that it cannot handle runtime power switching properly?

Thanks
Guennadi

> These two flags really address completely different problems, despite
> the similar nomenclature.
> 
> Thanks,
> Ohad.

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
