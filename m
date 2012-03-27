From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3
Date: Tue, 27 Mar 2012 11:06:15 +0200
Message-ID: <20120327110615.3bfaf969@eb-e6520>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
	<20120312132423.GC2459@pengutronix.de>
	<9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
	<0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
	<a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
	<85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
	<20120327101259.73525f9d@eb-e6520>
	<ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
	<20120327090148.GB6790@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:42712 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755633Ab2C0JGY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 05:06:24 -0400
In-Reply-To: <20120327090148.GB6790@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: joancarles <joancarles@fqingenieria.es>, Zhu Richard-R65037 <r65037@freescale.com>, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Wolfram,

Le Tue, 27 Mar 2012 11:01:49 +0200,
Wolfram Sang <w.sang@pengutronix.de> a =E9crit :
> > >does that attached patch fix your problem ?
> >=20
> > YES, indeed it does to a certain degree. The timeout errors do not
> > occur anymore and I can successfully perform many fs->ops, such as
>=20
> Interesting question is now why it worked on your older kernel? The c=
ode
> around BROKEN_TIMEOUT is there for much longer, I'd think.
>=20
not in fact it seems to have been broken from a long time and I think
I'm responsible of that in 37865fe91582582a6f6c00652f6a2b1ff71f8a78
"mmc: sdhci-esdhc-imx: fix timeout on i.MX's sdhc"
because unlike the i.MX35 it seems that the i.MX25 manages to read
properly the partition table even without the timeout quirk and it
seems that I didn't do more extensive tests for this patch.

Eric
