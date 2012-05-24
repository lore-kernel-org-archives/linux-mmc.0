From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC_CAP_POWER_OFF_CARD, MMC_PM_KEEP_POWER - when to set
Date: Thu, 24 May 2012 16:32:20 +0300
Message-ID: <CAK=WgbZNeMZ+J-0t-piUNuMnrh5TjCAPBMpaTSJc=GnSx6z2YA@mail.gmail.com>
References: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
 <CAK=Wgbb7RwAhhSCwb-NYCd8SNzQTJSNna8t4Zqdi5Q9T1ADSxg@mail.gmail.com> <Pine.LNX.4.64.1205241441240.1462@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50343 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298Ab2EXNcl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 09:32:41 -0400
Received: by yhmm54 with SMTP id m54so7746057yhm.19
        for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 06:32:40 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205241441240.1462@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>

Hi Guennadi,

On Thu, May 24, 2012 at 4:07 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> How do you know, if this is a normal sd-card slot?

Not sure I follow the question.

But if you ask whether we can dynamically set MMC_CAP_POWER_OFF_CARD,
then we can't (with what we know today).

This CAP is dealing with issues of specific boards which,
unfortunately, we have no way (today) to dynamically probe.

>> No, MMC_PM_KEEP_POWER is different: it is a dynamic user decision
>> controlling whether the card should stay on while the system is
>> suspended,
>
> Isn't it both?

Yes, you're right - we need host support to keep the card powered
while the system is suspended.

> A complete board reset in this case will differ from the card power-off
> only in the state of the rest of the SD-card ping, e.g., the clock. So,
> additionally switching off the clock in this case should be equivalent to
> the board reset?

Not really - consider the example I gave you, where you are required
to toggle a card reset pin after you power cycle it, but there's no
way to control that pin. In that case, only a complete board reset can
help you.

> Given the above, wouldn't it be sufficient to test (mmc->pm_flags &
> MMC_PM_KEEP_POWER) to decide, whether the card can be suspended?

No,

MMC_PM_KEEP_POWER is about the ability (and desire) to keep the card
powered while the system is suspended.

MMC_CAP_POWER_OFF_CARD is about the ability to power off the card
without killing it completely until the next board reset.

These two flags really address completely different problems, despite
the similar nomenclature.

Thanks,
Ohad.
