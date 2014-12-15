From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: regression on rk3288 with - mmc: dw_mmc: Remove old card detect infrastructure
Date: Mon, 15 Dec 2014 22:19:44 +0100
Message-ID: <2085305.zZfFZXcZ7g@phil>
References: <8867707.LK6gZlxufx@phil> <CAD=FV=VfnXHpZiTMh8+WHyEQ=N0cVNrDLLjmU+xC1ne-uYbuEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:32790 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbaLOVT4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Dec 2014 16:19:56 -0500
In-Reply-To: <CAD=FV=VfnXHpZiTMh8+WHyEQ=N0cVNrDLLjmU+xC1ne-uYbuEQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>

Am Freitag, 12. Dezember 2014, 15:54:15 schrieb Doug Anderson:
> Hi,
>=20
> On Fri, Dec 12, 2014 at 12:22 PM, Heiko St=FCbner <heiko@sntech.de> w=
rote:
> > Hi,
> >=20
> > when trying linux-next for 20141210 on my rk3288 eval board I got e=
rrors
> > when ejecting sd cards. Especially a timeout for a command and foll=
owing
> > this an rcu stall which essentially stops everything [0].
> >=20
> > My way to reproduce the issue is:
> > - boot into an initramfs
> > - insert card
> > - remove card
> > - boom
> >=20
> > It happens 100% of the time on the first removal of the card.
> >=20
> >=20
> > Bisecting the issue brought me to
> >=20
> > first bad commit
> > 6130e7a9c34d01afbd4e7e215846d1f2d70333bb
> > mmc: dw_mmc: Remove old card detect infrastructure
> >=20
> > and indeed if I revert this one, card ejection works again - also m=
ultiple
> > times in a row. Affected machine is a rk3288-evb-rk808 board which
> > currently uses the internal card-detect mechanism of the dw_mmc and
> > relevant git history (--oneline) is:
> >=20
> > 864de9b Revert "mmc: dw_mmc: Remove old card detect infrastructure"
> > 5bd48e0 ARM: dts: Bump SD card pin drive strength up on rk3288-evb
> > 12fd072 Add linux-next specific files for 20141210
> > ...
> >=20
> >=20
> > I'll try to dig deeper, but if anybody has ideas beforehand I would=
 also
> > be very glad.
>=20
> I tried to reproduce this on the same board on 20141211.  I have a
> different bootloader, but I hope that doesn't matter?

Doug also seems to have found the cause of the problem and in fact the=20
bootloader did seem to make the difference.

The rk3288 has a function to switch the sdmmc pins between sdmmc and jt=
ag=20
functions automatically depending on the card status. On Doug's board t=
his=20
function was deactivated by the bootloader while on my board it is defa=
ult-
active.

Deactivating this "feature" also solves the timeout + hang issue report=
ed=20
above.

So the commit mentioned above is in fact inocent :-)


Heiko
