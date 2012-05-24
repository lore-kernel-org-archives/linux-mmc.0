From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC_CAP_POWER_OFF_CARD, MMC_PM_KEEP_POWER - when to set
Date: Fri, 25 May 2012 00:43:13 +0300
Message-ID: <CAK=WgbY258g92zg9YtCM01pNQz+LswpmHSFe9C24s8ejjWKm+g@mail.gmail.com>
References: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
 <CAK=Wgbb7RwAhhSCwb-NYCd8SNzQTJSNna8t4Zqdi5Q9T1ADSxg@mail.gmail.com>
 <Pine.LNX.4.64.1205241441240.1462@axis700.grange> <CAK=WgbZNeMZ+J-0t-piUNuMnrh5TjCAPBMpaTSJc=GnSx6z2YA@mail.gmail.com>
 <Pine.LNX.4.64.1205241559060.1462@axis700.grange> <CAK=WgbZggEEyrbp6QLHC+O+H7nOZrZuRuam2KJijTGGs=Oeozg@mail.gmail.com>
 <Pine.LNX.4.64.1205241737420.1462@axis700.grange> <CAK=WgbZ+Cjafh==X84TNq+rZurxpswg61F=UenHKMB05k7oCGw@mail.gmail.com>
 <Pine.LNX.4.64.1205242308510.1462@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34996 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572Ab2EXVne (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 17:43:34 -0400
Received: by pbbrp8 with SMTP id rp8so834615pbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 14:43:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205242308510.1462@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Daniel Drake <dsd@laptop.org>

On Fri, May 25, 2012 at 12:15 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> I think it'd be better to go with driver-assisted PM straight away instead
> of implementing black-/white-lists to later find out about cards with the
> same IDs and different behaviour.

I'm not sure - we usually prefer to evolve as real use cases show up
instead of aiming for the final design in the first place (which, as
practice shows, most likely anyway have to change when the real use
case show up).

This usually proves itself as the minimum effort for nailing the
existing requirements (less code to develop, debug and maintain).

We also want to support powering off the cards even if their driver
isn't at all loaded (as I wrote previously).

> Thanks:-) It was important for me in the first place to understand the
> problem. Now that the problem has become clearer we can think about
> whether, when and how to solve it and who shall do it:-)

Oh I thought you volunteered ! ;)

Thanks,
Ohad.
