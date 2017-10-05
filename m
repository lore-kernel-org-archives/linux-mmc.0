From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [RFC PATCH] mmc: tmio: check mmc_regulator_get_supply return
 value
Date: Thu, 5 Oct 2017 09:44:17 +0000
Message-ID: <TY1PR06MB08956748EF3D3A4A530903C0C0700@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1506079337-12882-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <7e1bdda1-d790-0db2-540c-69fabe22850a@rock-chips.com>
 <20170922160405.wfpi4fyziz3sxtmh@katana>
 <TY1PR06MB089584E681911E2C49953F29C0730@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <20171004183024.zv6oir7bc4te4k24@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171004183024.zv6oir7bc4te4k24@ninjato>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram, Ulf

> Hi Fabrizio,
>
> On Wed, Oct 04, 2017 at 10:50:54AM +0000, Fabrizio Castro wrote:
> > Thank you guys for your comments!
> >
> > > > > However, there are side effects to it as the mmc devices will be =
enumerated
> > > > > in a different order (due to -EPROBE_DEFER), this means this patc=
h would likely
> > > > > break existing platforms.
> > > >
> > > > However this doesn't. The user daemon should never relies on the
> > > > sequency of probing the mmc block part. We neither support to provi=
de
> > > > alias for the device id, nor guarantee the first probed controller =
get
> > > > the first block id. Please use PARTUUID for rootfs, etc. So this
> > > > shouldn't be a big deal.
> > >
> > > That's exactly what I thought as well...
> > >
> > > Thanks for the patch! Will test it the next days, but it looks good
> > > already.
> >
> > How is the testing going? Any problem with the patch?
>
> Sorry for the delay, there were some other things in the queue...

No worries at all!
And thank you for getting back to me.

>
> Well, the good news is that it didn't cause a regression for me on R-Car
> E2 (Alt board) and H3 (Salvator X board).
>
> Sadly, it doesn't also fix the SDR104 problems on Alt. I had a little
> hope this could be the culprit, but sadly it is not. But this is not a
> problem with this patch. It still fixes a valid issue.
>
> Looking how other drivers deal with the issue, though, I noticed they
> only bail out on -EPROBE_DEFER and would continue on other errors (if
> mmc_regulator_get_supply would throw them, but it doesn't). So some
> digging why other drivers do it that way seems to be apropriate to me.

Good point!
Maybe if this patch explicitly tested for -EPROBE_DEFER the maintenance
of mmc_regulator_get_supply would be easier as all of the drivers behaved
similarly.
On the other hand, both "vmmc" and "vqmmc" are considered optional by
mmc_regulator_get_supply, therefore their absence is tolerated (0 is
returned), and as you said the only other possible value returned by
mmc_regulator_get_supply is -EPROBE_DEFER.
If in the future the logic of mmc_regulator_get_supply changes, I guess
even the driver needs to adapt as there may be something wrong with the
regulators, therefore I personally rather the driver to bail out whatever
the error returned by mmc_regulator_get_supply. Looking at the history
of the other drivers I couldn't spot any meaningful comment connected
to the return value of mmc_regulator_get_supply.

> Or asking Ulf :)

I guess you are right! ;)

Ulf, what's the best option here?

Kind regards,
Fabrizio

>
> Kind regards,
>
>    Wolfram




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
