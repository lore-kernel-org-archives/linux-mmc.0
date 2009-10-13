From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] mmc: at91_mci: Don't include asm/mach/mmc.h
Date: Tue, 13 Oct 2009 09:36:48 +0200
Message-ID: <4AD42E10.7010801@atmel.com>
References: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de> <1255418388-27866-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atmel.fr ([81.80.104.162]:47423 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933460AbZJMHmY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Oct 2009 03:42:24 -0400
In-Reply-To: <1255418388-27866-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Pierre Ossman <drzeus@drzeus.cx>, linux-arm-kernel@lists.infradead.org

Uwe Kleine-K=C3=B6nig :
> This fixes a compile error introduced in
>=20
> 	6ef297f (ARM: 5720/1: Move MMCI header to amba include dir)
>=20
> That commit moved arch/arm/include/asm/mach/mmc.h to
> include/linux/amba/mmci.h.  Just removing the include was enough.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Bill Gatliff <bgat@billgatliff.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Pierre Ossman <drzeus@drzeus.cx>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> Hello,
>=20
> what is the right path to Linus for this patch?

Uwe,

I gess that Andrew Morton will have to handle it.

Let's help him not forget it ;-)

Bye,

>  drivers/mmc/host/at91_mci.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.=
c
> index e556d42..63924e0 100644
> --- a/drivers/mmc/host/at91_mci.c
> +++ b/drivers/mmc/host/at91_mci.c
> @@ -72,7 +72,6 @@
>  #include <asm/irq.h>
>  #include <asm/gpio.h>
> =20
> -#include <asm/mach/mmc.h>
>  #include <mach/board.h>
>  #include <mach/cpu.h>
>  #include <mach/at91_mci.h>


--=20
Nicolas Ferre

