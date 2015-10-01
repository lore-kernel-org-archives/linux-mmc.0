From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Thu, 01 Oct 2015 12:21:19 +0200
Message-ID: <2695161.Z1IhqPE0bd@diego>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de> <17200614.QxCe8zAb7I@diego> <CAPDyKFpis8XnvrppHq7q_7DQeN2UiEpykNTJ=1iJJ9AGOHTW6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpis8XnvrppHq7q_7DQeN2UiEpykNTJ=1iJJ9AGOHTW6Q@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Doug Anderson <dianders@chromium.org>, Alexandru Stan <amstan@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Am Donnerstag, 1. Oktober 2015, 11:54:24 schrieb Ulf Hansson:
> On 30 September 2015 at 16:55, Heiko St=FCbner <heiko@sntech.de> wrot=
e:
> > Am Mittwoch, 30. September 2015, 16:42:05 schrieb Ulf Hansson:
> >> On 30 September 2015 at 16:07, Heiko Stuebner <heiko@sntech.de> wr=
ote:
> >> > From: Douglas Anderson <dianders@chromium.org>
> >> >=20
> >> > This adds logic to the MMC core to set VQMMC.  This is expected =
to be
> >> > called by MMC drivers like dw_mmc as part of (or instead of) the=
ir
> >> > start_signal_voltage_switch() callback.
> >> >=20
> >> > A few notes:
> >> >=20
> >> > * When setting the signal voltage to 3.3V we do our best to make=
 VQMMC
> >> >=20
> >> >   and VMMC match.  It's been reported that this makes some old c=
ards
> >> >   happy since they were tested back in the day before UHS when V=
QMMC
> >> >   and VMMC were provided by the same regulator.  A nice side eff=
ect of
> >> >   this is that we don't end up on the hairy edge of VQMMC (2.7V)=
,
> >> >   which some EEs claim is a little too close to the minimum for
> >> >   comfort.
> >> >   This is done in two steps. At first we try to find a VQMMC wit=
hin
> >> >   a 0.3V tolerance of VMMC and if this is not supported by the
> >> >   supplying regulator we try to find a suitable voltage within t=
he
> >> >   whole 2.7V-3.6V area of the spec.
> >> >=20
> >> > * The two step approach is currently necessary, as the used
> >> >=20
> >> >   regulator_set_voltage_triplet(min, target, max) uses a simple
> >> >  =20
> >> >   implementation that just tries two basic steps:
> >> >         regulator_set_voltage(target, max);
> >> >         regulator_set_voltage(min, target);
> >> >  =20
> >> >   So with only one step with 2.7-3.6V borders, if a suitable vol=
tage
> >> >   is a bit below VMMC, we would directly get the lowest 2.7V
> >> >   which some boards (like Rockchips) don't like at all.
> >> >=20
> >> > * When setting the signal voltage to 1.8V or 1.2V we aim for tha=
t
> >> >=20
> >> >   specific voltage instead of picking the lowest one in the rang=
e.
> >> >=20
> >> > * We very purposely don't print errors in mmc_regulator_set_vqmm=
c().
> >> >=20
> >> >   There are cases where the MMC core will try several different
> >> >   voltages and we don't want to pollute the logs.
> >> >=20
> >> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >>=20
> >> This looks good to me!
> >=20
> > very cool :-)
> >=20
> >> Once all are happy with the patches, can we take the mmc patches v=
ia
> >> my mmc tree or does it all have to go together?
> >=20
> > The clock changes of course only touch internals of the phase-clock=
s, so
> > should have no problem going through another tree.
>=20
> What happens if I take mmc and dt changes, wouldn't I need the clock
> patches as well?

The API stays of course the same, only the degree to settings translati=
on gets=20
optimized, so I guess in the worst case you would get no good phase and=
 thus=20
fall back to non-highspeed modes - but the system would stay running.

But of course, if the clock maintainers could Ack the two clock patches=
 and=20
everything would stay together that would work even better :-)


Heiko

>=20
> > For the devicetree part I'm unsure. If the boards enable the
> > tuning-related
> > settings without the new voltage handling, 2.7V gets set on all Roc=
kchip
> > boards which doesn't work on those at all.
> >=20
> > So either the dts patches would need to go into your tree, I would =
need a
> > stable branch or we could simply postpone dts changes for the next =
cycle.
>=20
> Kind regards
> Uffe

