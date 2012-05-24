From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC_CAP_POWER_OFF_CARD, MMC_PM_KEEP_POWER - when to set
Date: Thu, 24 May 2012 18:22:45 +0300
Message-ID: <CAK=WgbZggEEyrbp6QLHC+O+H7nOZrZuRuam2KJijTGGs=Oeozg@mail.gmail.com>
References: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
 <CAK=Wgbb7RwAhhSCwb-NYCd8SNzQTJSNna8t4Zqdi5Q9T1ADSxg@mail.gmail.com>
 <Pine.LNX.4.64.1205241441240.1462@axis700.grange> <CAK=WgbZNeMZ+J-0t-piUNuMnrh5TjCAPBMpaTSJc=GnSx6z2YA@mail.gmail.com>
 <Pine.LNX.4.64.1205241559060.1462@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:52330 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729Ab2EXPXF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 11:23:05 -0400
Received: by gglu4 with SMTP id u4so7819544ggl.19
        for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 08:23:05 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205241559060.1462@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>

Hi Guennadi,

On Thu, May 24, 2012 at 5:06 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Sorry, I mean - you don't know what card will be plugged in, so, you
> cannot know, whether that specific card and its driver can be safely
> powered off.

We do know in certain cases, most commonly with wifi SDIO cards which
are hardwired to the board.

> Ok, I think, it's this: MMC_PM_KEEP_POWER is for system-wide suspend /
> resume, whereas MMC_CAP_POWER_OFF_CARD is for runtime PM. Am I right?

MMC_CAP_POWER_OFF_CARD is used by SDIO runtime PM, but I won't
classify it as "runtime PM" specific. It describes the hardware, and
not inherently limited to a specific use case.

> that case, I think, they also should function similar

Can you explain why ?

> - wouldn't it make
> sense to use MMC_CAP_POWER_OFF_CARD similar to MMC_PM_KEEP_POWER - as a
> static capability flag (meaning, whether the board is physically able to
> switch power) and a dynamic flag, that, say, an SDIO function driver could
> set if it knows, that it cannot handle runtime power switching properly?

I'm not sure I'm following the reasoning.

Can you explain what are you trying to solve ? Is there a specific
problem you have in mind ?

Thanks,
Ohad.
