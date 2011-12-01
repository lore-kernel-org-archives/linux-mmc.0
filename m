From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Thu, 1 Dec 2011 10:07:24 +0200
Message-ID: <CAK=WgbbBF1=YJyc2MF2fgNtPbbqF=-9L53=LKoEmkgA43PjSdw@mail.gmail.com>
References: <WC20111129111750.470087@terrafix.co.uk> <CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
 <CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
 <CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com>
 <CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com>
 <CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com> <WC20111130150051.910209@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47538 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab1LAIHq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2011 03:07:46 -0500
Received: by ggnr5 with SMTP id r5so1545358ggn.19
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2011 00:07:46 -0800 (PST)
In-Reply-To: <WC20111130150051.910209@terrafix.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Nov 30, 2011 at 5:00 PM, Joe Woodward <jw@terrafix.co.uk> wrote:
> It seems CMD5 fails (which seems to be what the workarounds were aiming to fix).

Right; you get a timeout (-110), which means the 8686 didn't send any response.

This is unexpected because the sdio reset (the CMD52 you see before
the init sequence) should be enough to reset the device (we confirmed
this with the Marvell folks on this list awhile ago).

> I'm afraid I may not be of much more use as Gumstix (annoyingly) don't release schematics of their COMs, so actually probing any signals isn't really possible.

Yes, it makes it difficult to debug.

You can try to verify (in the code) that all the text book
prerequisites are there (e.g. all SDIO lines are pulled up and muxed
correctly. though since stuff work for you without SDIO runtime PM, I
assume these are ok), and maybe even play a bit with stuff like
delays, sdio resets and power cycles and see if things change. If you
have access to the other inputs of the 8686 (it has several of them
which are related to power and resets. Neither me nor Daniel have
intimate knowledge about what any of those really do, but you could
dig some info from emails send by Marvell folks on this list), then
you can also try to play with them and see if things change. With
luck, you could learn more about the problem and can hopefully get
closer to finding a solution.

It could be great if a solution will be found, but if not, we'll
probably have to proceed with the revert...

Good luck!
Ohad.
