From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH RESEND#2] mmc: at91_mci: Don't include asm/mach/mmc.h
Date: Wed, 21 Oct 2009 10:12:12 +0200
Message-ID: <20091021081212.GA9453@pengutronix.de>
References: <4ADDF2E7.4010200@billgatliff.com> <1256111219-25266-1-git-send-email-u.kleine-koenig@pengutronix.de> <4ADEBE0B.3060007@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42002 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbZJUIMI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2009 04:12:08 -0400
Content-Disposition: inline
In-Reply-To: <4ADEBE0B.3060007@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc@vger.kernel.org, Pierre Ossman <drzeus@drzeus.cx>, linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>

On Wed, Oct 21, 2009 at 09:53:47AM +0200, Nicolas Ferre wrote:
> Uwe Kleine-K=F6nig :
> > This fixes a compile bug introduced in
> >=20
> > 	6ef297f (ARM: 5720/1: Move MMCI header to amba include dir)
> >=20
> > That commit moved arch/arm/include/asm/mach/mmc.h to
> > include/linux/amba/mmci.h.  Just removing the include was enough.
>=20
> FYI it is already in -mm patchsed as:
> mmc-at91_mci-dont-include-asm-mach-mmch.patch
oh right.  I was pretty sure I didn't get a "patch was added to mm" mai=
l
by Andrew, but searching my inbox proofed me wrong.

Sorry
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
