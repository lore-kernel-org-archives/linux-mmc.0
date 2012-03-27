From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
Subject: Re: [MX25][MMC] mmc esdhc failure in 3.3
Date: Tue, 27 Mar 2012 10:58:19 +0200
Message-ID: <20120327105819.00d89783@eb-e6520>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
	<20120312132423.GC2459@pengutronix.de>
	<9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
	<0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
	<a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
	<85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
	<20120327101259.73525f9d@eb-e6520>
	<ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:42126 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757699Ab2C0I63 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Mar 2012 04:58:29 -0400
In-Reply-To: <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: joancarles <joancarles@fqingenieria.es>
Cc: Zhu Richard-R65037 <r65037@freescale.com>, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, linux-arm-kernel@lists.infradead.org

Hi Joan Carles,

Le Tue, 27 Mar 2012 10:46:45 +0200,
joancarles <joancarles@fqingenieria.es> a =E9crit :
> >> This is still present, and we have absolutely no idea where to=20
> >> continue
> >> searching for the solution of the problem. Any pointers? Any git=20
> >> trees
> >> of mmc driver changes we could try? Anybody else with a MX25 that=20
> >> has
> >> this issue?
> >>
> > does that attached patch fix your problem ?
>=20
> YES, indeed it does to a certain degree. The timeout errors do not=20
> occur anymore and I can successfully perform many fs->ops, such as RE=
AD,=20
> WRITE, UNLINK ... . So thank you very much for this insight through y=
our=20
> patch!
>=20
> The speed of the card is excruciatingly slow, however. We roughly get=
=20
> between 34KB/s and 64KB/s from a dd if=3D/dev/zero write to any of th=
e=20
> following partitions:
>=20
I have the same speed problem here on i.MX25 but still haven't found
the reason.
Shawn, Richard : do you have an idea of why the eSDHC is so slow on
i.MX25 ?

Thanks,
Eric
