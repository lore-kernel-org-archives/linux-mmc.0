From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 06/10] mmc: dw_mmc-pltfm: add Rockchip variant
Date: Tue, 4 Jun 2013 10:43:59 +0200
Message-ID: <201306041044.00128.heiko@sntech.de>
References: <201306030055.15413.heiko@sntech.de> <201306030059.03783.heiko@sntech.de> <51AD67CF.60300@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51AD67CF.60300@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Seungwon Jeon <tgih.jun@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Olof Johansson <olof@lixom.net>, John Stultz <john.stultz@linaro.org>, Grant Likely <grant.likely@linaro.org>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, devicetree-discuss@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

Am Dienstag, 4. Juni 2013, 06:06:39 schrieb Jaehoon Chung:
> On 06/03/2013 07:59 AM, Heiko St=FCbner wrote:
> > Cortex-A9 SoCs from Rockchip use a slightly modified variant of dw_=
mmc
> > controllers that seems to require the SDMMC_CMD_USE_HOLD_REG bit to
> > always be set.
> >=20
> > There also seem to be no other modifications (additional register e=
tc)
> > present, so to keep the footprint low, add this small variant to th=
e
> > pltfm driver.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >=20
> >  drivers/mmc/host/dw_mmc-pltfm.c |   48
> >  +++++++++++++++++++++++++++----------- 1 files changed, 34
> >  insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/dw_mmc-pltfm.c
> > b/drivers/mmc/host/dw_mmc-pltfm.c index 0048da8..7d041b5 100644
> > --- a/drivers/mmc/host/dw_mmc-pltfm.c
> > +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> > @@ -24,6 +24,16 @@
> >=20
> >  #include "dw_mmc.h"
> >=20
> > +
> > +static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u=
32
> > *cmdr)
>=20
> How about using "dw_mci_pltfm_prepare_command()"?
> Maybe HOLD_REG could be used at other SoC.

The problem I had when thinking about it is that every implementation u=
sing=20
the HOLD_REG stuff does it differently ... on the Exynos variant it dep=
ends on=20
the CLKSEL register value and on the SOCFPGA variant on other clock val=
ues.

It's only on the Rockchip variant that it seems to needed all the time.

So, doing it with a "dw_mci_pltfm_prepare_command()" would need a flag =
to=20
signal that the implementation needs the HOLD_REG all the time, but we =
won't=20
know yet if other implementations will have other constraints on its us=
e -=20
like only i special cases or such.

So personally I would keep it as it is for now, until more platforms us=
ing the=20
HOLD_REG come along to see some sort of pattern of its use?
