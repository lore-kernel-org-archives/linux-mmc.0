From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC_CAP_POWER_OFF_CARD, MMC_PM_KEEP_POWER - when to set
Date: Thu, 24 May 2012 22:11:21 +0300
Message-ID: <CAK=WgbbLCvRW0skdb3hxGC-fPHpw6p_R-zzwaj+CDj7yu5k=Dw@mail.gmail.com>
References: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
 <CAK=Wgbb7RwAhhSCwb-NYCd8SNzQTJSNna8t4Zqdi5Q9T1ADSxg@mail.gmail.com>
 <Pine.LNX.4.64.1205241441240.1462@axis700.grange> <CAK=WgbZNeMZ+J-0t-piUNuMnrh5TjCAPBMpaTSJc=GnSx6z2YA@mail.gmail.com>
 <Pine.LNX.4.64.1205241559060.1462@axis700.grange> <CAK=WgbZggEEyrbp6QLHC+O+H7nOZrZuRuam2KJijTGGs=Oeozg@mail.gmail.com>
 <Pine.LNX.4.64.1205241737420.1462@axis700.grange> <CAK=WgbZ+Cjafh==X84TNq+rZurxpswg61F=UenHKMB05k7oCGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60176 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab2EXTLm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 15:11:42 -0400
Received: by pbbrp8 with SMTP id rp8so660376pbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 12:11:42 -0700 (PDT)
In-Reply-To: <CAK=WgbZ+Cjafh==X84TNq+rZurxpswg61F=UenHKMB05k7oCGw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Daniel Drake <dsd@laptop.org>

On Thu, May 24, 2012 at 10:08 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Feel free to propose a solution, but please back it up with real
> hardware and show that it satisfies the MMC_CAP_POWER_OFF_CARD issues
> we had in the past.

The solution should also still support powering off the card even if a
driver for it isn't loaded (at least for chips that support it).

Thanks,
Ohad.
