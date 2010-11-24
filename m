From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Wed, 24 Nov 2010 13:38:24 +0000
Message-ID: <20101124133824.GA20804@void.printf.net>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com> <AANLkTika=H3EOA=WSdyuP9Mexrrh0z6-KjjTiNCj=mLc@mail.gmail.com> <AANLkTiniyy_rC4wUAhxN4i09d4GqhdnqPOqXMYNZyBXT@mail.gmail.com> <20101109035948.GA32119@void.printf.net> <20101122232743.GA27895@void.printf.net> <AANLkTimtF1kUEVNbz19x+UpJX+w1yfWZCxHu7wSdOX4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53056 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322Ab0KXNi2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Nov 2010 08:38:28 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimtF1kUEVNbz19x+UpJX+w1yfWZCxHu7wSdOX4f@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ghorai Sukumar <s-ghorai@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com

On Wed, Nov 24, 2010 at 02:15:57PM +0100, Linus Walleij wrote:
> > [ =A0 10.136067] mmc0: frequency set to 0 in disable function, this=
 means the clock is already disabled.
>=20
> It didn't use to be like that back when I first wrote the patch, but
> it seems to be like
> that nowadays. So yes.

Hm, okay.  Printing the same message seven times in a second is a littl=
e
undesirable, but we could leave it in until we're more confident that
the code's all working well.  It might help if the message made it
clearer that nothing is wrong, and this is an expected event.

> Did the gating work by the way? No strangeness because of it?

Yep, no strangeness so far.

> It's pr_debug() already in host.c:
> pr_debug("%s: frequency set to 0 in disable function, "
> 	 "this means the clock is already disabled.\n",
> 	 mmc_hostname(host));
>=20
> pr_debug is only printed when -DDEBUG is set, which is what
> MMC_DEBUG=3Dy does isn't it?

Ah, apologies, I understand now.  My linux-next build was too old for
"mmc: protect against clock-gating races", which does s/pr_err/pr_debug=
/
on that printk, so it was coming out unconditional on MMC_DEBUG.  I've
moved up to today's linux-next now.

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
