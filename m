From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
Date: Sun, 2 May 2010 00:28:23 +0100
Message-ID: <20100501232823.GB17693@n2100.arm.linux.org.uk>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com> <v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com> <CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local> <t2qe9c3a7c21004141815x70ecf123p4364802681417da9@mail.gmail.com> <q2o63386a3d1004162158v296379fat2b376d5c4c087378@mail.gmail.com> <20100422110025.GC20008@n2100.arm.linux.org.uk> <g2qe9c3a7c21005011500l11511d43i12d971775b139c3b@mail.gmail.com> <20100501224429.GA17693@n2100.arm.linux.org.uk> <x2u63386a3d1005011604kaee33364l880e90a4e2453e0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36136 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab0EAX2r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 1 May 2010 19:28:47 -0400
Content-Disposition: inline
In-Reply-To: <x2u63386a3d1005011604kaee33364l880e90a4e2453e0f@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, May 02, 2010 at 01:04:37AM +0200, Linus Walleij wrote:
> 2010/5/2 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>=20
> > Versatile has some MUXing on three of the DMA signals, so (eg) we
> > really don't want UARTs claiming DMAs just because they're in exist=
ence
> > and not in use - that would prevent DMAs from being used for (eg) A=
ACI
> > or MMC.
>=20
> As long as Versatile doesn't specify any filter function or
> data for the channel allocation function (it currently doesn't and de=
faults
> to NULL) it won't even try to call the DMA engine to allocate a chann=
el
> for say the UART.

But when we _do_ want to support DMA?

> There is nothing blocking some other peripheral from grabbing a
> muxed channel in that case.
>=20
> But the implementation of the DMA engine would be better of
> handling the muxing dynamically I believe, so when the PL011
> driver (say) requests a DMA channel, it doesn't mean it requests the
> *physical* channel and holds it (unless the driver is very na=EFvely
> implemented) it nominally means it reserves a placeholder in the
> DMA engine.

So what happens if we try to use DMA with the PL011 but the physical
channels are already in use?  From what I can see, it assumes that it
always has access to the transmit channel, and there's no recovery if
it doesn't.

Plus if we can't get DMA for the RX path, it _permanently_ disables
all DMA for the device.

> When the driver issues a request to perform a DMA transfer, it will p=
ull
> out a physical channel and use that, then return it. If there is too
> much combat about the physical channels, you configure out DMA
> for the least wanted PrimeCells.

Three physical channels shared between: AACI Tx, AACI Rx, MMCI 0, MMCI =
1,
UART3 Tx, UART3 Rx.  (USB and smartcard/SIM which we don't implement.)
In total there's 10 valid settings for the MUX for each channel, so
contention is going to happen.  All you need is to load both the AACI
and MMCI drivers, and if they want to use the DMA channels, you're
already wanting 4 channels with only 3 available.
