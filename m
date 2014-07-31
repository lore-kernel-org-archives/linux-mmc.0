From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/10 v2] mmc: tmio: fixup patches
Date: Thu, 31 Jul 2014 13:30:59 +0900
Message-ID: <20140731043059.GA28708@verge.net.au>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>
 <87simtenpi.wl%kuninori.morimoto.gx@renesas.com>
 <cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>
 <87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>
 <53AD638C.5060907@renesas.com>
 <87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
 <87mwbso8sp.wl%kuninori.morimoto.gx@gmail.com>
 <53D9A148.1000802@jinso.co.jp>
 <20140731023037.GC2558@verge.net.au>
 <53D9C5A3.8090908@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56139 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbaGaEbD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jul 2014 00:31:03 -0400
Content-Disposition: inline
In-Reply-To: <53D9C5A3.8090908@jinso.co.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?= <cm-hiep@jinso.co.jp>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, "(Renesas)goda" <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, ryo.kataoka.wt@renesas.com, shinobu.uehara.xc@renesas.com, kouei.abe.cp@renesas.com

On Thu, Jul 31, 2014 at 01:27:15PM +0900, =E3=82=AB=E3=82=AA =E3=83=9F=E3=
=83=B3 =E3=83=92=E3=82=A7=E3=83=83=E3=83=97 wrote:
> Hi Simon-san
>=20
> On 07/31/2014 11:30 AM, Simon Horman wrote:
> >Hi Hiep-san,
> >
> >On Thu, Jul 31, 2014 at 10:52:08AM +0900, =E3=82=AB=E3=82=AA =E3=83=9F=
=E3=83=B3 =E3=83=92=E3=82=A7=E3=83=83=E3=83=97 wrote:
> >>Hi Morimoto-san, Simon-san
> >>
> >>On 07/29/2014 05:42 PM, Kuninori Morimoto wrote:
> >>>Hi Chris, Simon
> >>>
> >>>These are v2 of fixup patches for mmc tmio/shmobile.
> >>>I tesed these patches on my environment.
> >>>I'm very happy if someone test these patches.
> >>I have just tested these series on Lager. if remove CONFIG_HIGHMEM =
from
> >>config file,
> >>They are good at SDHI and MMC on my environment.
> >Could you provided a Tested-by tag?
> Tested-by: Nguyen Xuan Nui <nx-nui@jinso.co.jp>
> Reported-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Thanks.

Chris, would you consider taking this series?

> >>>Kuninori Morimoto (4):
> >>>       mmc: tmio: care about DMA tx/rx addr offset
> >>>       mmc: tmio: remove Renesas specific #ifdef
> >>>       mmc: tmio: remove SCLKEN bit setting from tmio_mmc_set_cloc=
k()
> >>>       mmc: tmio: ensure that the clock has been stopped before se=
t_clock
> >>>
> >>>Shinobu Uehara (6):
> >>>       mmc: block: add block number limitation flag for multiple b=
lock read
> >>>       mmc: tmio: clear error IRQ status
> >>>       mmc: tmio: control multiple block transfer mode
> >>>       mmc: tmio: add TMIO_MMC_SDIO_STATUS_QUIRK
> >>>       mmc: tmio: check ILL_FUNC instead of CBSY
> >>>       mmc: tmio: add actual clock support as option
> >>>
> >>>  arch/arm/mach-shmobile/board-koelsch.c |    6 ++---
> >>>  arch/arm/mach-shmobile/board-lager.c   |    4 ++--
> >>>  drivers/mmc/card/block.c               |   19 +++++++++++++--
> >>>  drivers/mmc/host/sh_mobile_sdhi.c      |   26 ++++++++++++++++++=
---
> >>>  drivers/mmc/host/tmio_mmc_dma.c        |    8 +++----
> >>>  drivers/mmc/host/tmio_mmc_pio.c        |   40 ++++++++++++++++++=
+++++++++++---
> >>>  include/linux/mfd/tmio.h               |   22 ++++++++++++++++++
> >>>  include/linux/mmc/host.h               |    3 +++
> >>>  8 files changed, 110 insertions(+), 18 deletions(-)
> >>>
> >>>
> >>>
> >>Best regards,
> >>Cao Minh Hiep.
> >>
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe linux-sh"=
 in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-sh" =
in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
>=20
