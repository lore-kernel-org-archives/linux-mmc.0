From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] mmc: at91_mci: Don't include asm/mach/mmc.h
Date: Thu, 8 Oct 2009 13:26:45 +0200
Message-ID: <63386a3d0910080426j2a48e5d7wd2d2cb633a5f7a15@mail.gmail.com>
References: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:61260 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317AbZJHL1X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2009 07:27:23 -0400
Received: by bwz6 with SMTP id 6so681354bwz.37
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2009 04:26:46 -0700 (PDT)
In-Reply-To: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@stericsson.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Pierre Ossman <drzeus@drzeus.cx>, linux-arm-kernel@lists.infradead.org

2009/10/8 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> This fixes a compile bug introduced in
>
> =A0 =A0 =A0 =A06ef297f (ARM: 5720/1: Move MMCI header to amba include=
 dir)
>
> That commit moved arch/arm/include/asm/mach/mmc.h to
> include/linux/amba/mmci.h. =A0Just removing the include was enough.
>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

The include paths in the kernel lead me astray... Weird that this
driver included that file at all though, but I guess the driver was der=
ived
from MMCI at some early staget and it got left in?

Linus Walleij
