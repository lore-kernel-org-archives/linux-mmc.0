From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH RESEND#2] mmc: at91_mci: Don't include asm/mach/mmc.h
Date: Wed, 21 Oct 2009 09:53:47 +0200
Message-ID: <4ADEBE0B.3060007@atmel.com>
References: <4ADDF2E7.4010200@billgatliff.com> <1256111219-25266-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atmel.fr ([81.80.104.162]:38394 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180AbZJUH5K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Oct 2009 03:57:10 -0400
In-Reply-To: <1256111219-25266-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org
Cc: Pierre Ossman <drzeus@drzeus.cx>, linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>

Uwe Kleine-K=C3=B6nig :
> This fixes a compile bug introduced in
>=20
> 	6ef297f (ARM: 5720/1: Move MMCI header to amba include dir)
>=20
> That commit moved arch/arm/include/asm/mach/mmc.h to
> include/linux/amba/mmci.h.  Just removing the include was enough.

=46YI it is already in -mm patchsed as:
mmc-at91_mci-dont-include-asm-mach-mmch.patch

We now just have to track its way to mainline.

Bye,
--=20
Nicolas Ferre

