From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Fri, 22 Oct 2010 02:20:10 +0200
Message-ID: <201010220220.10398.marek.vasut@gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com> <20101021141302.GA11912@void.printf.net> <20101021145249.GA13095@void.printf.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55105 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab0JVAUP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2010 20:20:15 -0400
Received: by bwz11 with SMTP id 11so106483bwz.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2010 17:20:13 -0700 (PDT)
In-Reply-To: <20101021145249.GA13095@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Chris Ball <cjb@laptop.org>, zhangfei gao <zhangfei.gao@gmail.com>, Matt Fleming <matt@console-pimps.org>, eric.y.miao@gmail.com, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>

Dne =C4=8Ct 21. =C5=99=C3=ADjna 2010 16:52:49 Chris Ball napsal(a):
> Hi,
>=20
> On Thu, Oct 21, 2010 at 03:13:02PM +0100, Chris Ball wrote:
> > On Mon, Oct 18, 2010 at 08:32:46AM -0400, zhangfei gao wrote:
> > > Update with comments from Matt and Eric.
> > > Test with sd and emmc.
> > >=20
> > > >From e5dd554ed4d3488a83d9a4888d68d1d85482f747 Mon Sep 17 00:00:0=
0 2001
> > >=20
> > > From: Zhangfei Gao <zhangfei.gao@marvell.com>
> > > Date: Mon, 20 Sep 2010 10:51:28 -0400
> > > Subject: [PATCH] mmc: add support of sdhci-pxa driver
> > >=20
> > > 	Support Marvell PXA168/PXA910/MMP2 SD Host Controller
> > >=20
> > > Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> > > ---
> > >=20
> > >  arch/arm/plat-pxa/include/plat/sdhci.h |   32 ++++
> > >  drivers/mmc/host/Kconfig               |   12 ++
> > >  drivers/mmc/host/Makefile              |    1 +
> > >  drivers/mmc/host/sdhci-pxa.c           |  259
> > >  ++++++++++++++++++++++++++++++++ 4 files changed, 304 insertions=
(+),
> > >  0 deletions(-)
> > >  create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
> > >  create mode 100644 drivers/mmc/host/sdhci-pxa.c
> >=20
> > I'll take the drivers/mmc/ hunks, but you should send the plat-pxa/
> > patch through the ARM tree.
>=20
> Oh.  If we do that then the driver won't compile until everything's
> together, because it #includes <plat/sdhci.h>.  Haojian/Eric, what do
> you prefer here?  Should I take the arch/arm/ hunk via the MMC tree?
> (If so, please provide ACKs.)
>=20
> Thanks,

Hi, where can I find the whole driver so I can take a look? It didn't c=
rash into=20
linux-arm-kernel for some reason.

Thanks
