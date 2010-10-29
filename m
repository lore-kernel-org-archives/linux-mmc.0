From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Fri, 29 Oct 2010 13:00:47 -0400
Message-ID: <AANLkTin6CdhNf4kyxaXLFnh9dVrrySzm0TS5jvO0q_2X@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40336 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab0J2RAt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2010 13:00:49 -0400
Received: by qyk10 with SMTP id 10so3590528qyk.19
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2010 10:00:48 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

2010/10/27 Ghorai, Sukumar <s-ghorai@ti.com>:

> =A0 =A0 Option-3: with the *existing* API calls, namely the set_ios()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 method as proposed by Linus Walleij =A0[4=
]

OK do you want to pick this up and fix it Sukumar? I will be
happy to review and test it on our hardware and forward-port
the second patch with the MMCI hooks.

I have this patchset on my TODO list, sadly with everything
else, I may find time on a flight tonite to look at it if there is
a lot of interest.

> =A0 2.a) Card sleep, Power cutoff to the card:
> =A0 =A0 This should be handled in the core where based on block layer
> =A0 =A0 activity, calling corresponding API's from bus layer:
> =A0 =A0 mmc_power_save_host/ mmc_power_restore_host

I think this is already discussed. What needs to be done in the
core is in the first patch, the driver then knows if the core is
happy with you shutting off the clock to the card, whether you
do it or not and under what circumstances is up to the driver.

The driver can then play around with it block clock and PM
hooks and whatnot, AFAICT the core does not need to be
aware of such stuff.

> 3. MMC_CAP_DISABLE - should not be a host capability.=A0 This should =
be
> =A0 a core feature that should be _transparent_ =A0to all hosts with =
no
> =A0 changes to any of the host drivers.

In my patchset the .set_ios(0) stuff is a Kconfig option. It cannot
be on per default until we are sure that all drivers will properly
deal with a zero clock argument from .set_ios(). If you're
confident with all host drivers handling the occasional .set_ios(0)
by all means just default-activate it.

Yours,
Linus Walleij
