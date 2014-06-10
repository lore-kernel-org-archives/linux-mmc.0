From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 5/5] ARM: dts: imx51-babbage: Fix esdhc setup
Date: Tue, 10 Jun 2014 10:01:59 +0200
Message-ID: <20140610100159.7a45f9e1@ipc1.ka-ro>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
	<1400848384-3226-6-git-send-email-s.hauer@pengutronix.de>
	<20140609034058.GF11061@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:65083 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbaFJICU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jun 2014 04:02:20 -0400
In-Reply-To: <20140609034058.GF11061@dragon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org

Hi,

Shawn Guo wrote:
> On Fri, May 23, 2014 at 02:33:04PM +0200, Sascha Hauer wrote:
> > - Move cd/wp pinctrl from the hog group to the esdhc groups
> > - use gpio for card detection / write protection on esdhc2 since
> >   the controller based detection does not work
> > - Fix cd gpio polarity for esdhc1. This is wrong and currently
> >   only works because the imx esdhc driver ignores the polarity.
> >=20
[...]
> > @@ -330,6 +326,8 @@
> > =20
> >  		pinctrl_esdhc1: esdhc1grp {
> >  			fsl,pins =3D <
> > +				MX51_PAD_GPIO1_0__GPIO1_0		0x20d5
> > +				MX51_PAD_GPIO1_1__GPIO1_1		0x20d5
>=20
> The pad config value 0x20d5 still makes sense here when switching to
> GPIO function?  Probably should be 0x100 like what we have in esdhc2g=
rp?
>
The pad config 0x20d5 doesn't make any sense at all because according
to the Ref. Manual only bits 0..2 and 4..8 (mask 0x01f7) are defined fo=
r
those pads. Thus 0x2000 doesn't serve any purpose at all.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
