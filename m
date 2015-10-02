From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Fri, 02 Oct 2015 09:06:48 +0200
Message-ID: <3312969.jJ2hfB2JkV@diego>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de> <CAPDyKFqrkYXsbBJ61yYo0G8za1szARvA=as-5nLTiwGH5pCrEQ@mail.gmail.com> <560DF150.3000906@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:33421 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbbJBHG4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2015 03:06:56 -0400
In-Reply-To: <560DF150.3000906@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Doug Anderson <dianders@chromium.org>, Alexandru Stan <amstan@chromium.org>

Am Freitag, 2. Oktober 2015, 11:52:00 schrieb Jaehoon Chung:
> On 10/02/2015 06:05 AM, Ulf Hansson wrote:
> > On 1 October 2015 at 19:35, Stephen Boyd <sboyd@codeaurora.org> wro=
te:
> >> On 10/01, Heiko St=FCbner wrote:
> >>> Am Donnerstag, 1. Oktober 2015, 11:54:24 schrieb Ulf Hansson:
> >>>> On 30 September 2015 at 16:55, Heiko St=FCbner <heiko@sntech.de>=
 wrote:
> >>>>> Am Mittwoch, 30. September 2015, 16:42:05 schrieb Ulf Hansson:
> >>>>>> On 30 September 2015 at 16:07, Heiko Stuebner <heiko@sntech.de=
>=20
wrote:
> >>>>> The clock changes of course only touch internals of the phase-c=
locks,
> >>>>> so
> >>>>> should have no problem going through another tree.
> >>>>=20
> >>>> What happens if I take mmc and dt changes, wouldn't I need the c=
lock
> >>>> patches as well?
> >>>=20
> >>> The API stays of course the same, only the degree to settings
> >>> translation gets optimized, so I guess in the worst case you woul=
d get
> >>> no good phase and thus fall back to non-highspeed modes - but the
> >>> system would stay running.
> >>>=20
> >>> But of course, if the clock maintainers could Ack the two clock p=
atches
> >>> and
> >>> everything would stay together that would work even better :-)
> >>=20
> >> If Ulf doesn't want to take them we can apply them to clk tree.
> >> Otherwise, you can have my acked-by on the clk patches.
> >=20
> > I don't mind picking up the clock patches. So I consider this as an
> > ack for both patch 1 and patch2, thanks.
> >=20
> > Now, let's give Jaehoon some time to review the dw_mmc parts.
>=20
> I will check other patches on today, if it's ok, i will apply at my
> repository. Thanks for giving time! :)

I think Ulf wanted to apply the whole series via the mmc tree directly,=
 but I=20
guess that is between you two to decide ;-)


Heiko
