From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5 3/7] wireless: wl12xx: add platform data passing
	support
Date: Wed, 15 Sep 2010 09:25:44 +0100
Message-ID: <20100915082544.GA4625@n2100.arm.linux.org.uk>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com> <1283376410-9999-4-git-send-email-ohad@wizery.com> <AANLkTi=goLEUqM1XQ__PrGu4=Erw2utaNP4qFmSgRta2@mail.gmail.com> <20100906120716.GE20903@n2100.arm.linux.org.uk> <AANLkTikAFCd+3ggZKhQXY=+bG==KgLkv3qNVdEGa=GBX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56543 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0IOI0H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2010 04:26:07 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikAFCd+3ggZKhQXY=+bG==KgLkv3qNVdEGa=GBX@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Kalle Valo <kalle.valo@iki.fi>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Roger Quadros <roger.quadros@nokia.com>, Ido Yariv <ido@wizery.com>, San Mehat <san@google.com>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

On Mon, Sep 06, 2010 at 09:42:41PM +0200, Micha=C5=82 Miros=C5=82aw wro=
te:
> W dniu 6 wrze=C5=9Bnia 2010 14:07 u=C5=BCytkownik Russell King - ARM =
Linux
> <linux@arm.linux.org.uk> napisa=C5=82:
> > On Sat, Sep 04, 2010 at 02:23:19PM +0200, Micha=C5=82 Miros=C5=82aw=
 wrote:
> >> 2010/9/1 Ohad Ben-Cohen <ohad@wizery.com>:
> >> > Add a simple mechanism to pass platform data to the
> >> > SDIO instances of wl12xx.
> [cut patch]
> >> Why do you need all that copying? Isn't the data constant?
> >
> > The first copy is to allow platforms to have their data marked with
> > __initdata. =C2=A0The second copy probably isn't necessary, but avo=
ids
> > problems where the driver may decide to modify the platform data.
>=20
> Sorry for pushing at this, but why would you mark data that's meant t=
o
> be used after init phase as __initdata?

Because you may have many instances of the data (due to multiple platfo=
rm
support), and only need one of them at run-time.
