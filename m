From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Wed, 24 Nov 2010 14:15:57 +0100
Message-ID: <AANLkTimtF1kUEVNbz19x+UpJX+w1yfWZCxHu7wSdOX4f@mail.gmail.com>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTika=H3EOA=WSdyuP9Mexrrh0z6-KjjTiNCj=mLc@mail.gmail.com>
	<AANLkTiniyy_rC4wUAhxN4i09d4GqhdnqPOqXMYNZyBXT@mail.gmail.com>
	<20101109035948.GA32119@void.printf.net>
	<20101122232743.GA27895@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37004 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab0KXNQA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2010 08:16:00 -0500
Received: by wwa36 with SMTP id 36so9931391wwa.1
        for <linux-mmc@vger.kernel.org>; Wed, 24 Nov 2010 05:15:59 -0800 (PST)
In-Reply-To: <20101122232743.GA27895@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ghorai Sukumar <s-ghorai@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com

2010/11/23 Chris Ball <cjb@laptop.org>:

> [ =A0 10.136067] mmc0: frequency set to 0 in disable function, this m=
eans the clock is already disabled.
> [ =A0 10.164089] mmc0: frequency set to 0 in disable function, this m=
eans the clock is already disabled.
> [ =A0 10.192076] mmc0: frequency set to 0 in disable function, this m=
eans the clock is already disabled.
> [ =A0 10.291095] mmc1: frequency set to 0 in disable function, this m=
eans the clock is already disabled.
> [ =A0 10.319029] mmc1: frequency set to 0 in disable function, this m=
eans the clock is already disabled.
>
> * Are we expecting mmc_host_clk_gate_delayed() to be called so often
> =A0with host->ios.clock =3D=3D 0?

It didn't use to be like that back when I first wrote the patch, but
it seems to be like
that nowadays. So yes.

Did the gating work by the way? No strangeness because of it?

> =A0There's a full log with CONFIG_MMC_DEBUG=3Dy
> =A0at http://chris.printf.net/mmc-clkgate-debug in case it helps you =
see
> =A0what's going on.
>
> * If you think the current behavior should stay, we would at least wa=
nt
> =A0to convert it to a dev_dbg so that it's only visible under MMC_DEB=
UG=3Dy,
> =A0right?

Hm?

It's pr_debug() already in host.c:
pr_debug("%s: frequency set to 0 in disable function, "
	 "this means the clock is already disabled.\n",
	 mmc_hostname(host));

pr_debug is only printed when -DDEBUG is set, which is what
MMC_DEBUG=3Dy does isn't it?

But I can patch it to use dev_dbg() I think, does the below patch
solve the thing you want?

Yours,
Linus Walleij

=46rom 75428e5cc51f1775389d5e3ad953e3b9edd43984 Mon Sep 17 00:00:00 200=
1
=46rom: Linus Walleij <linus.walleij@stericsson.com>
Date: Wed, 24 Nov 2010 14:08:14 +0100
Subject: [PATCH] mmc: switch clockgating message from pr_debug to dev_d=
bg

This prints clock gating information with the dev_* macro instead.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/core/host.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 92e3370..69fa70a 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -68,9 +68,9 @@ static void mmc_host_clk_gate_delayed(struct mmc_host=
 *host)
 	unsigned long flags;

 	if (!freq) {
-		pr_debug("%s: frequency set to 0 in disable function, "
-			 "this means the clock is already disabled.\n",
-			 mmc_hostname(host));
+		dev_dbg(mmc_dev(host), "frequency set to 0 in disable "
+			"function, this means the clock is already "
+			"disabled\n");
 		return;
 	}
 	/*
@@ -101,7 +101,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_ho=
st *host)
 		/* This will set host->ios.clock to 0 */
 		mmc_gate_clock(host);
 		spin_lock_irqsave(&host->clk_lock, flags);
-		pr_debug("%s: gated MCI clock\n", mmc_hostname(host));
+		dev_dbg(mmc_dev(host), "gated MCI clock\n");
 	}
 	spin_unlock_irqrestore(&host->clk_lock, flags);
 	mutex_unlock(&host->clk_gate_mutex);
@@ -136,7 +136,7 @@ void mmc_host_clk_ungate(struct mmc_host *host)
 		spin_unlock_irqrestore(&host->clk_lock, flags);
 		mmc_ungate_clock(host);
 		spin_lock_irqsave(&host->clk_lock, flags);
-		pr_debug("%s: ungated MCI clock\n", mmc_hostname(host));
+		dev_dbg(mmc_dev(host), "ungated MCI clock\n");
 	}
 	host->clk_requests++;
 	spin_unlock_irqrestore(&host->clk_lock, flags);
--=20
1.7.3.2
