From: Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH v2 0/5] Tegra SDHCI UHS-I support
Date: Wed, 17 Feb 2016 20:52:38 +0100
Message-ID: <1455738758.6319.5.camel@lynxeye.de>
References: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
	 <56C47368.4010304@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:53821 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161663AbcBQT6t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Feb 2016 14:58:49 -0500
In-Reply-To: <56C47368.4010304@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Hi Jon,

Am Mittwoch, den 17.02.2016, 13:19 +0000 schrieb Jon Hunter:
> Hi Lucas,
>=20
> On 22/12/15 18:40, Lucas Stach wrote:
> > Hi all,
> >=20
> > this series implements UHS-I signaling for the Tegra SDHCI host,
> > which mainly means putting a proper tuning sequence in place.
> >=20
> > I've tested this on Jetson TK1 and got the following speed results,
> > where mmcblk0 is the on-board eMMC and mmcblk1 is a micro SDXC
> > card:
> >=20
> > Without series applied:
> > hdparm -t /dev/mmcblk0
> > =C2=A0Timing buffered disk reads:=C2=A0=C2=A0110 MB in=C2=A0=C2=A03=
=2E05 seconds =3D=C2=A0=C2=A036.02
> > MB/sec
> > hdparm -t /dev/mmcblk1
> > =C2=A0Timing buffered disk reads:=C2=A0=C2=A0=C2=A056 MB in=C2=A0=C2=
=A03.01 seconds =3D=C2=A0=C2=A018.63
> > MB/sec
> > =C2=A0
> > With series applied:
> > hdparm -t /dev/mmcblk0
> > =C2=A0Timing buffered disk reads:=C2=A0=C2=A0236 MB in=C2=A0=C2=A03=
=2E00 seconds =3D=C2=A0=C2=A078.58
> > MB/sec
> > hdparm -t /dev/mmcblk1
> > =C2=A0Timing buffered disk reads:=C2=A0=C2=A0102 MB in=C2=A0=C2=A03=
=2E04 seconds =3D=C2=A0=C2=A033.51
> > MB/sec
> >=20
> > Tegra 30 does support UHS-I speeds too, but currently has problems
> > when lowering the card voltage, which is needed in order to switch
> > to UHS-I signaling. I have some more patches to fix this, but they
> > need a bit more cleanup, with them applied the gains on Tegra30 are
> > similar to the results above.
> >=20
> > For now the gains are limited to Tegra124+, with no regressions on
> > Tegra30 and Tegra20.
> >=20
> > V2 fixes some minor style problems and is rebased on top of
> > mmc/next.
> > This means it enables the same tuning logic on Tegra210 also. I
> > don't have a way to test this myself, so any testing on Tegra210
> > much
> > appreciated.
>=20
> I have recently noticed that on my tegra114-dalmore-a04, SD cards are
> no
> longer recognised on boot. It appears that the problem started after
> this series was merged.
>=20
> On tegra114 I see:
>=20
> [=C2=A0=C2=A0=C2=A0=C2=A01.777006] mmc0: error -110 whilst initialisi=
ng SD card
>=20
> If I disable the UHS-I changes then it works again (see below). I am
> guessing you don't have a tegra114 board to test on? I have not had
> time
> to look into this further, but I am not sure if we should disable
> UHS-I
> on tegra114 for now?
>=20
> Cheers
> Jon
>=20
Right I don't have a Tegra114 board to test with.

I already know that Tegra30 needs some more fixes to get UHS-I to work
and I have patches for that, but they are not yet ready for sending
out. I would guess that Tegra114 may need the same fix as Tegra30. I
can Cc you on those patches if you prefer.

Please submit a formal patch to disable UHS-I on Tegra114, I think it's
the right thing to do at this point and will happily ACK it.

Regards,
Lucas
