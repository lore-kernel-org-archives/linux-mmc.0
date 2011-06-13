From: =?ISO-8859-1?Q?Ren=E9_K=F6cher?= <shirk@bitspin.org>
Subject: Re: Support for NetXtreme BCM57765 Memory Card Reader?
Date: Mon, 13 Jun 2011 18:13:51 +0200
Message-ID: <1307981633.11567.2.camel@horo.kamakura>
References: <1307790907.3615.8.camel@horo.kamakura>
	 <m21uyz96bc.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65157 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab1FMQN4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2011 12:13:56 -0400
Received: by fxm17 with SMTP id 17so2758410fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2011 09:13:54 -0700 (PDT)
In-Reply-To: <m21uyz96bc.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Ok,

looks like Majordomo didn't like my previous post..

On Sat, 2011-06-11 at 21:39 -0400, Chris Ball wrote:
> Hi,
>=20
> On Sat, Jun 11 2011, Ren=C3=A9 K=C3=B6cher wrote:
> > The card reader mentioned in the subject is part of the Broadcom
> > NetXtreme BCM57765 chip which provides a card reader as well as a
> > network interface[=C2=B9].
> >
> > It is recognized by the sdhci-pci driver however it won't read any =
card
> > (tested with different SD, SDHC, SDXC cards).
> >
> > I'm not sure if it is recognized by its advertised features or if i=
t's
> > really supported (unlikely).
>=20
> I expect there's not much we can do without access to the hardware, b=
ut
> could you post dmesg output with CONFIG_MMC_DEBUG=3Dy?
>=20
> Thanks,
>=20
> - Chris.

I created a pastebin: http://pastebin.com/pP1ZmqDL showing the=20
requested logs.

In addition I had a talk with a nice gui with broadcom-knowledge=E2=84=A2=
=2E
It looks like this card has an additional (private) mmio-block above th=
e
normal 0x100 bytes in the PCI bar.

Cheers,
Ren=C3=A9

