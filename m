From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC RESEND] sdhci-s3c: support clock enable/disable
	(clock-gating)
Date: Tue, 5 Oct 2010 03:08:50 +0100
Message-ID: <20101005020848.GA9044@void.printf.net>
References: <4C91BD5A.1040804@samsung.com> <20100929233751.GA31473@void.printf.net> <alpine.LFD.2.00.1009292334050.1146@xanadu.home> <20100930040958.GA3170@void.printf.net> <AANLkTin=9KwC0Paa8yAhG-OBXFrfJDKJSYokzLLa6jPN@mail.gmail.com> <AANLkTikywfU_C4QTQet64aQJgQyyDdTh4xRpaYu6q0di@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:32894 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756162Ab0JECI5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 4 Oct 2010 22:08:57 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikywfU_C4QTQet64aQJgQyyDdTh4xRpaYu6q0di@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Nicolas Pitre <nico@fluxnic.net>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, matt@console-pimps.org, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Pierre Ossman <pierre-list@ossman.eu>, Kukjin Kim <kgene.kim@samsung.com>

Hi Linus,

On Thu, Sep 30, 2010 at 09:22:17AM +0200, Linus Walleij wrote:
> That's it. If there is interest I can surely pick it up and wrap the
> current enable/disable calls around it or even rewrite all drivers
> to use the set_ios() approach as in this patchset I think.
>=20
> What happened was that I had this iterated a few times as Pierre was
> getting increasingly overloaded and it was on the verge of merging
> when he resigned as MMC maintainer.
>=20
> The next week or so the big hammer callbacks from OMAP were
> merged as part of their mainline procedure.
>=20
> I can move the timeing code to wrap the current callbacks
> instead atleast that would make things more according to spec.

Sounds excellent.  Thank you!

There are a few groups to keep in touch with on this:

* The omap_hsmmc folks, of course
* Ohad Ben-Cohen has SDIO runtime PM patches=B9, which I think should
  be merged
* Kevin Hilman is working on converting omap_hsmmc over to runtime PM=B2
* Matthew Garrett is working on a patch to power down unused SDHCI
  devices using runtime PM

- Chris.

=B9:  http://thread.gmane.org/gmane.linux.kernel.mmc/3968
=B2:  http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm=
=2Egit;a=3Dshortlog;h=3Drefs/heads/pm-wip/mmc

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
