From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3 5/7] clk: add basic Rockchip rk3066a clock support
Date: Thu, 13 Jun 2013 01:40:05 +0200
Message-ID: <201306130140.05981.heiko@sntech.de>
References: <201306111328.52679.heiko@sntech.de> <201306130045.41723.heiko@sntech.de> <20130612230234.GB9016@quad.lixom.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:37804 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932201Ab3FLXjr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 19:39:47 -0400
In-Reply-To: <20130612230234.GB9016@quad.lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Mike Turquette <mturquette@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andy Shevchenko <andy.shevchenko@gmail.com>

Am Donnerstag, 13. Juni 2013, 01:02:34 schrieb Olof Johansson:
> On Thu, Jun 13, 2013 at 12:45:41AM +0200, Heiko St=FCbner wrote:
> > Part of me simply wants to wait for this - but rockchip stuff might=
 be to
> > late for 3.11 anyway, as we're near rc6.
>=20
> For a new platform like this, it's useful to get some of the drivers =
to
> land even if the main platform code isn't. Where things tend to get m=
essy
> is when we have to add a lot of code late in the cycle that has a lot=
 of
> external dependencies, since everybody then has to scramble about get=
ting
> things sorted out.
>=20
> It's not too late for 3.11 yet, and in particular it'd be nice to see
> things like clock and pinctrl stuff go in even if some other stuff mi=
sses
> the train.

pinctrl is already in Linus Walleijs tree :-)

Tomorrow I'll try to send the mmc stuff to the mmc lists, as my dw-mmc=20
dependency from Dinh Nguyen also seems to go this way.

The clocks are the really hard part, simply because Mike's upcoming dt =
support=20
for the divider and mux clocks will let me get rid of the small clocks =
that=20
simply hold. And of course I also need the HIWORD_MASK flag for the clo=
cks from=20
the hisilicon series.

Is there some sane intermediate step for the clocks? One possibility th=
at=20
comes to mind, would be to only declare the gates and provide fixed rat=
e=20
parents to the timer and mmc and add the divs and muxes when Mikes dt p=
atches=20
are ready.

I.e. I would keep the gate clocks grouped like now to not have to decla=
re 160=20
individual gates later :-)

