From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC_CAP_POWER_OFF_CARD, MMC_PM_KEEP_POWER - when to set
Date: Thu, 24 May 2012 22:08:40 +0300
Message-ID: <CAK=WgbZ+Cjafh==X84TNq+rZurxpswg61F=UenHKMB05k7oCGw@mail.gmail.com>
References: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
 <CAK=Wgbb7RwAhhSCwb-NYCd8SNzQTJSNna8t4Zqdi5Q9T1ADSxg@mail.gmail.com>
 <Pine.LNX.4.64.1205241441240.1462@axis700.grange> <CAK=WgbZNeMZ+J-0t-piUNuMnrh5TjCAPBMpaTSJc=GnSx6z2YA@mail.gmail.com>
 <Pine.LNX.4.64.1205241559060.1462@axis700.grange> <CAK=WgbZggEEyrbp6QLHC+O+H7nOZrZuRuam2KJijTGGs=Oeozg@mail.gmail.com>
 <Pine.LNX.4.64.1205241737420.1462@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57895 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab2EXTJC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 15:09:02 -0400
Received: by pbbrp8 with SMTP id rp8so657044pbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 12:09:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205241737420.1462@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Daniel Drake <dsd@laptop.org>

Hi Guennadi,

On Thu, May 24, 2012 at 6:42 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Yes, exactly, in certain cases. And when it's not hard-wired?

We don't support this yet.

Daniel suggested using either black or white listing (based on
vendor/device id presumably) so we can support regular cards without
breaking others, but I'm not sure if Daniel had any free cycles to
look into it.

> Because with pluggable cards one flag is not enough. I think, you need (1)
> board capability to switch power, and (2) driver's allowance to power the
> card down.
...
> The problem of hot-pluggable cards. One card / driver combination will
> support powering down at runtime, another one will not.

Ah ok now I understand you, thanks for the explanation.

Whether or not to involve the driver here probably depends on the
actual hardware requirements. E.g., if the vendor/device id is enough
information, then we might be able to implement this below the drivers
without involving them. But in case only the driver could tell between
variants of specific chips, then a generic white/black listing might
not be enough.

Feel free to propose a solution, but please back it up with real
hardware and show that it satisfies the MMC_CAP_POWER_OFF_CARD issues
we had in the past.

Thanks,
Ohad.
