From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH RESEND#2] mmc: at91_mci: Don't include asm/mach/mmc.h
Date: Wed, 21 Oct 2009 09:46:59 +0200
Message-ID: <1256111219-25266-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <4ADDF2E7.4010200@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46057 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbZJUHrI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2009 03:47:08 -0400
In-Reply-To: <4ADDF2E7.4010200@billgatliff.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Pierre Ossman <drzeus@drzeus.cx>, linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

This fixes a compile bug introduced in

	6ef297f (ARM: 5720/1: Move MMCI header to amba include dir)

That commit moved arch/arm/include/asm/mach/mmc.h to
include/linux/amba/mmci.h.  Just removing the include was enough.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Bill Gatliff <bgat@billgatliff.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Pierre Ossman <drzeus@drzeus.cx>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
Hello,

this patch is a build fix that seems to bite quite some people, but
nobody has picked it up until now.

Linus Walleij suggested to send it to Russell's patch tracker, but I
don't think this is the right way for that patch.  It should either go
via Pierre or (IMO preferably) via Andrew.

Best regards
Uwe

 drivers/mmc/host/at91_mci.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index e556d42..63924e0 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -72,7 +72,6 @@
 #include <asm/irq.h>
 #include <asm/gpio.h>
=20
-#include <asm/mach/mmc.h>
 #include <mach/board.h>
 #include <mach/cpu.h>
 #include <mach/at91_mci.h>
--=20
1.6.5

