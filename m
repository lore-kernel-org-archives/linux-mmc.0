From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [RFC PATCH] mmc: tmio: check mmc_regulator_get_supply return
 value
Date: Wed, 4 Oct 2017 10:50:54 +0000
Message-ID: <TY1PR06MB089584E681911E2C49953F29C0730@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1506079337-12882-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <7e1bdda1-d790-0db2-540c-69fabe22850a@rock-chips.com>
 <20170922160405.wfpi4fyziz3sxtmh@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170922160405.wfpi4fyziz3sxtmh@katana>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Thank you guys for your comments!

> > > However, there are side effects to it as the mmc devices will be enum=
erated
> > > in a different order (due to -EPROBE_DEFER), this means this patch wo=
uld likely
> > > break existing platforms.
> >
> > However this doesn't. The user daemon should never relies on the
> > sequency of probing the mmc block part. We neither support to provide
> > alias for the device id, nor guarantee the first probed controller get
> > the first block id. Please use PARTUUID for rootfs, etc. So this
> > shouldn't be a big deal.
>
> That's exactly what I thought as well...
>
> Thanks for the patch! Will test it the next days, but it looks good
> already.

How is the testing going? Any problem with the patch?

Thanks,
Fabrizio



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
