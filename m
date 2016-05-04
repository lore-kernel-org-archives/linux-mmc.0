From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: fix set_clock when a phy is supported
Date: Wed, 04 May 2016 10:35:21 +0200
Message-ID: <1879484.KeYGv3HTkz@phil>
References: <1461832731-28422-1-git-send-email-shawn.lin@rock-chips.com> <CAPDyKFp8GmNjU_G9p5u3KFPB8h-BcqL9s6FUAUnAABt8g4Bw0w@mail.gmail.com> <1d3a9de8-9092-add5-078e-66ce4ce5f6f3@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:41182 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757601AbcEDIft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 04:35:49 -0400
In-Reply-To: <1d3a9de8-9092-add5-078e-66ce4ce5f6f3@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

Am Mittwoch, 4. Mai 2016, 09:48:55 schrieb Shawn Lin:
> =E5=9C=A8 2016/4/28 18:38, Ulf Hansson =E5=86=99=E9=81=93:
> > On 28 April 2016 at 10:38, Shawn Lin <shawn.lin@rock-chips.com> wro=
te:
> >> commit 61b914eb81f8 ("mmc: sdhci-of-arasan: add phy support for
> >> sdhci-of-arasan") introduce phy support for arasan. According to
> >> the vendor's databook, we should make sure the phy is in poweroff
> >> status before we configure the clk stuff. Otherwise it may cause
> >> some IO sample timing issues from the test. And we don't need this
> >> extra operation while running in low performance mode since phy
> >> doesn't trigger sampling block.
> >>=20
> >> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >=20
> > Thanks, applied for next!
>=20
> Thanks for applying v2 but, could you please drop it and applied v3
> I just send :) .
> Because v2 introduces a bug. Set_clock callback will be
> called under the protection of spinlock in sdhci_do_set_ios. However
> PHY APIs need mutex which fails the kernel's debug check
>=20
> BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c

I think in general you will need to provide a follow-up patch instead o=
f=20
replacing the old version, as Ulf might not want to restructure an alre=
ady=20
published branch (depends on the maintainer), especially as already oth=
er=20
stuff is on top of your patch [0].


Heiko

[0]=20
https://git.linaro.org/people/ulf.hansson/mmc.git/shortlog/refs/heads/n=
ext




> > Kind regards
> > Uffe
> >=20
> >> ---
> >>=20
> >> Changes in v2:
> >> - change commit msg title to indicate it's a fix
> >> - fix a typo in commmit msg
> >>=20
> >>  drivers/mmc/host/sdhci-of-arasan.c | 20 +++++++++++++++++++-
> >>  1 file changed, 19 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> >> b/drivers/mmc/host/sdhci-of-arasan.c index 2e482b1..20b859e 100644
> >> --- a/drivers/mmc/host/sdhci-of-arasan.c
> >> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> >> @@ -55,8 +55,26 @@ static unsigned int
> >> sdhci_arasan_get_timeout_clock(struct sdhci_host *host)>>=20
> >>         return freq;
> >> =20
> >>  }
> >>=20
> >> +static void sdhci_arasan_set_clock(struct sdhci_host *host, unsig=
ned
> >> int clock) +{
> >> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >> +       struct sdhci_arasan_data *sdhci_arasan =3D
> >> sdhci_pltfm_priv(pltfm_host); +       bool ctrl_phy =3D false;
> >> +
> >> +       if (clock > MMC_HIGH_52_MAX_DTR &&
> >> (!IS_ERR(sdhci_arasan->phy)))
> >> +               ctrl_phy =3D true;
> >> +
> >> +       if (ctrl_phy)
> >> +               phy_power_off(sdhci_arasan->phy);
> >> +
> >> +       sdhci_set_clock(host, clock);
> >> +
> >> +       if (ctrl_phy)
> >> +               phy_power_on(sdhci_arasan->phy);
> >> +}
> >> +
> >>=20
> >>  static struct sdhci_ops sdhci_arasan_ops =3D {
> >>=20
> >> -       .set_clock =3D sdhci_set_clock,
> >> +       .set_clock =3D sdhci_arasan_set_clock,
> >>=20
> >>         .get_max_clock =3D sdhci_pltfm_clk_get_max_clock,
> >>         .get_timeout_clock =3D sdhci_arasan_get_timeout_clock,
> >>         .set_bus_width =3D sdhci_set_bus_width,
> >>=20
> >> --
> >> 2.3.7
> >>=20
> >>=20
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html

