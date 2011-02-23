From: Chris Ball <cjb@laptop.org>
Subject: [PATCH v2 2/3] mmc: cb710: Return err value in
	cb710_wait_while_busy()
Date: Wed, 23 Feb 2011 23:17:43 +0000
Message-ID: <20110223231743.GA30908@void.printf.net>
References: <1298500153-28081-1-git-send-email-cjb@laptop.org> <1298500153-28081-2-git-send-email-cjb@laptop.org> <20110223230309.GB15104@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51842 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753582Ab1BWXRo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 23 Feb 2011 18:17:44 -0500
Content-Disposition: inline
In-Reply-To: <20110223230309.GB15104@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>

=46ixes:

drivers/mmc/host/cb710-mmc.c: In function =E2=80=98cb710_wait_while_bus=
y=E2=80=99:
drivers/mmc/host/cb710-mmc.c:182:6: warning: variable =E2=80=98err=E2=80=
=99 set but not
used [-Wunused-but-set-variable]

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
Hi Wolfram,

> What about changing return 0 into return err? It gets checked in
> cb710_mmc_powerup().

Thanks, good idea.

- Chris.

 drivers/mmc/host/cb710-mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.=
c
index 66b4ce5..ce2a47b 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -205,7 +205,7 @@ static int cb710_wait_while_busy(struct cb710_slot =
*slot, uint8_t mask)
 			"WAIT12: waited %d loops, mask %02X, entry val %08X, exit val %08X\=
n",
 			limit, mask, e, x);
 #endif
-	return 0;
+	return err;
 }
=20
 static void cb710_mmc_set_transfer_size(struct cb710_slot *slot,
--=20
1.7.0.1

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
