From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 6/8] mmc: dw_mmc: Generic MMC tuning with the clock phase framework
Date: Wed, 16 Sep 2015 16:52:26 +0200
Message-ID: <2272810.k4vHSW5D0y@diego>
References: <1441045446-30858-1-git-send-email-heiko@sntech.de> <8878355.D5Q8mk4qcM@diego> <55F8D442.5020004@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <55F8D442.5020004@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandru M Stan <amstan@chromium.org>, CPGS <cpgs@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

Am Mittwoch, 16. September 2015, 11:30:26 schrieb Jaehoon Chung:
> On 09/16/2015 07:09 AM, Heiko St=FCbner wrote:
> > Am Dienstag, 15. September 2015, 17:25:38 schrieb Jaehoon Chung:
> >> On 09/01/2015 03:24 AM, Heiko Stuebner wrote:
> >>> From: Alexandru M Stan <amstan@chromium.org>
> >>>=20
> >>> This algorithm will try 1 degree increments, since there's no way=
 to
> >>> tell
> >>> what resolution the underlying phase code uses. As an added bonus=
, doing
> >>> many tunings yields better results since some tests are run more =
than
> >>> once
> >>> (ex: if the underlying driver uses 45 degree increments, the tuni=
ng code
> >>> will try the same angle more than once).
> >>>=20
> >>> It will then construct a list of good phase ranges (even ranges t=
hat
> >>> cross
> >>> 360/0), will pick the biggest range then it will set the sample_c=
lk to
> >>> the
> >>> middle of that range.
> >>>=20
> >>> We do not touch ciu_drive (and by extension define default-drive-=
phase).
> >>> Drive phase is mostly used to define minimum hold times, while on=
e could
> >>> write some code to determine what phase meets the minimum hold ti=
me (ex
> >>> 10
> >>> degrees) this will not work with the current clock phase framewor=
k
> >>> (which
> >>> floors angles, so we'll get 0 deg, and there's no way to know wha=
t
> >>> resolution the floors happen at). We assume that the default driv=
e
> >>> angles
> >>> set by the hardware are good enough.
> >>>=20
> >>> If a device has device specific code (like exynos) then that will=
 still
> >>> take precedence, otherwise this new code will execute. If the dev=
ice
> >>> wants
> >>> to tune, but has no sample_clk defined we'll return EIO with an e=
rror
> >>> message.
> >>=20
> >> Which point is "_generic_"? I don't find the code that control the
> >> register
> >> relevant to CLK_DRV/SMPL PHASE. It seems that posted the similar p=
atches
> >> at
> >> u-boot mailing list..
> >=20
> > The "generic" part is that it uses the clk phase API for dw_mmc
> > implementations where the clkgen controlling interface is outside t=
he
> > dw_mmc IP itself. So it's open for other implementations as well.
>=20
> Designware IP also has the CLK phase register(UHS_REG_EXT register)..=
=2E
> if this code is related with it, it should be located into dw-mmc.c.

UHS_REG_EXT is acutally "reserved" on both the rk3288 as well as the rk=
3368.=20
rk3036/rk3128 (Cortex-A7) provide a bit description, but the tuning=20
documentation still uses the controls located in the clock controller.

So I guess UHS_REG_EXT is the real "generic" solution.

> > But if you are more comfortable with it, I can also move it into th=
e
> > dw_mmc- rockchip variant for the time being, until another user com=
es
> > along.
> I think more better that this code is located into dw_mmc-rockchip. h=
ow
> about?

As described above, moving that to the rockchip part sounds sensible. A=
nd I=20
guess we can think more about it, once a second user appears.


Heiko
