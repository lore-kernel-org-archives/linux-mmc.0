From: Alex Dubov <oakad@yahoo.com>
Subject: Re: [Bugme-new] [Bug 18602] New: mmc_block / tifm_sd not completely registering when a new sd card is inserted
Date: Sat, 18 Sep 2010 00:23:55 -0700 (PDT)
Message-ID: <198229.26049.qm@web37602.mail.mud.yahoo.com>
References: <20100917135414.GB11462@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from web37602.mail.mud.yahoo.com ([209.191.87.85]:48008 "HELO
	web37602.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754603Ab0IRHai convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Sep 2010 03:30:38 -0400
In-Reply-To: <20100917135414.GB11462@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>
Cc: linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, pioto@pioto.org

> > >=20
> > >=20
> > >=A0=A0=A00f:06.3 SD Host controller:
> Texas Instruments PCIxx12 SDA Standard Compliant
> > > SD Host Controller
> > >=20
> > > Any advice would be appreciated. Thanks.
> > >=20
> >=20

=46rom what I recollect, these controllers (the xx12 ones) were never t=
hat well
tested (there are some differences between xx21 and xx12 and I only had=
 the
former). I suppose, compiling tifm_* module with DEBUG enabled and post=
ing
the trace may help to diagnose the problem.



     =20
