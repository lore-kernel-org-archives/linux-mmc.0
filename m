From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Thu, 1 Oct 2015 10:35:54 -0700
Message-ID: <20151001173554.GB19319@codeaurora.org>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
 <17200614.QxCe8zAb7I@diego>
 <CAPDyKFpis8XnvrppHq7q_7DQeN2UiEpykNTJ=1iJJ9AGOHTW6Q@mail.gmail.com>
 <2695161.Z1IhqPE0bd@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2695161.Z1IhqPE0bd@diego>
Sender: linux-clk-owner@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Doug Anderson <dianders@chromium.org>, Alexandru Stan <amstan@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On 10/01, Heiko St=FCbner wrote:
> Am Donnerstag, 1. Oktober 2015, 11:54:24 schrieb Ulf Hansson:
> > On 30 September 2015 at 16:55, Heiko St=FCbner <heiko@sntech.de> wr=
ote:
> > > Am Mittwoch, 30. September 2015, 16:42:05 schrieb Ulf Hansson:
> > >> On 30 September 2015 at 16:07, Heiko Stuebner <heiko@sntech.de> =
wrote:
> > > The clock changes of course only touch internals of the phase-clo=
cks, so
> > > should have no problem going through another tree.
> >=20
> > What happens if I take mmc and dt changes, wouldn't I need the cloc=
k
> > patches as well?
>=20
> The API stays of course the same, only the degree to settings transla=
tion gets=20
> optimized, so I guess in the worst case you would get no good phase a=
nd thus=20
> fall back to non-highspeed modes - but the system would stay running.
>=20
> But of course, if the clock maintainers could Ack the two clock patch=
es and=20
> everything would stay together that would work even better :-)
>=20

If Ulf doesn't want to take them we can apply them to clk tree.
Otherwise, you can have my acked-by on the clk patches.

--=20
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
