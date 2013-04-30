From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Allow MMCI to request channels with
 information acquired from DT
Date: Tue, 30 Apr 2013 14:12:15 +0100
Message-ID: <20130430131215.GA25256@gmail.com>
References: <1366801122-13302-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdY+WtjnJGhVOCk3OZW+Z1maO0ru+Fc2wPR7OzWe+RMuJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:47490 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760334Ab3D3NMW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Apr 2013 09:12:22 -0400
Received: by mail-wg0-f53.google.com with SMTP id z11so457236wgg.32
        for <linux-mmc@vger.kernel.org>; Tue, 30 Apr 2013 06:12:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdY+WtjnJGhVOCk3OZW+Z1maO0ru+Fc2wPR7OzWe+RMuJg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linus WALLEIJ <linus.walleij@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, 30 Apr 2013, Linus Walleij wrote:

> On Wed, Apr 24, 2013 at 12:58 PM, Lee Jones <lee.jones@linaro.org> wr=
ote:
>=20
> > Currently, if DMA information isn't passed from platform data, then=
 DMA
> > will not be used. This patch allows DMA information obtained though=
 Device
> > Tree to be used as well.
> >
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> (...)
>=20
> I tried to test this patch, but:
>   CC      drivers/mmc/host/mmci.o
> /drivers/mmc/host/mmci.c: In function 'mmci_dma_setup':
> /drivers/mmc/host/mmci.c:307:51: error: 'dev' undeclared (first use i=
n
> this function)
> /drivers/mmc/host/mmci.c:307:51: note: each undeclared identifier is
> reported only once for each function it appears in
> make[5]: *** [drivers/mmc/host/mmci.o] Error 1
> make[4]: *** [drivers/mmc/host] Error 2
> make[3]: *** [drivers/mmc] Error 2
>=20
> Due to:
>=20
> > @@ -304,10 +304,8 @@ static void mmci_dma_setup(struct mmci_host *h=
ost)
> >         const char *rxname, *txname;
> >         dma_cap_mask_t mask;
> >
> > -       if (!plat || !plat->dma_filter) {
> > -               dev_info(mmc_dev(host->mmc), "no DMA platform data\=
n");
> > -               return;
> > -       }
> > +       host->dma_rx_channel =3D dma_request_slave_channel(dev, "rx=
");
> > +       host->dma_tx_channel =3D dma_request_slave_channel(dev, "tx=
");
>=20
> There is no "dev" here.

You've missed v2 again dude.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
