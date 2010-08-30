From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] sdhci: Enable high speed support for MMC cards
Date: Mon, 30 Aug 2010 16:56:44 +0100
Message-ID: <20100830155644.GA13076@void.printf.net>
References: <20100827191945.GI20407@void.printf.net> <AANLkTinmaio2PAcnwP7+U8P4O1-T3HiLYz_ej3zGAV5Y@mail.gmail.com> <m362yu4sef.fsf@pullcord.laptop.org> <AANLkTikswH2GdmXvRBWoeJcbrAn+JbzLTOA9fkPyV=fB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44912 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173Ab0H3P45 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Aug 2010 11:56:57 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikswH2GdmXvRBWoeJcbrAn+JbzLTOA9fkPyV=fB@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, "George G. Davis" <gdavis@mvista.com>, Zhangfei Gao <zgao6@marvell.com>

On Mon, Aug 30, 2010 at 10:34:48AM +0900, Kyungmin Park wrote:
> right, it's required patch and should be merged at this rc window.

Okay.  Andrew, would you mind sending the patch below to Linus for
-rc4?  (If you'd rather it go through someone else, that's fine.)

> > - =A0 =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_SD_HS &&
> > + =A0 =A0 =A0 if ((ios->timing =3D=3D MMC_TIMING_SD_HS ||
> > + =A0 =A0 =A0 =A0 =A0 =A0ios->timing =3D=3D MMC_TIMING_MMC_HS) &&
> > =A0 =A0 =A0 =A0 =A0 =A0!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl |=3D SDHCI_CTRL_HISPD;
> > =A0 =A0 =A0 =A0else
> >
> Does it need? I mean when probing the mmc card it doesn't have
> MMC_TIMING_MMC_HS. so it can't trigger the this condition at my
> environment.

I agree; MMC_TIMING_MMC_HS is set in response to moving to HS, which
can't happen without this flag.  George, let us know if you still=20
think this is necessary.

Here's Zhangfei's patch for merging:

=46rom: Zhangfei Gao <zgao6@marvell.com>
Date: Mon, 16 Aug 2010 21:15:32 -0400
Subject: [PATCH] sdhci: Enable high-speed support for MMC cards

Support MMC_CAP_MMC_HIGHSPEED.

Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
Acked-by: Matt Fleming <matt@console-pimps.org>
Acked-by: Kyungmin Park <kmpark@infradead.org>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 401527d..87ab234 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1824,7 +1824,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |=3D MMC_CAP_4_BIT_DATA;
=20
 	if (caps & SDHCI_CAN_DO_HISPD)
-		mmc->caps |=3D MMC_CAP_SD_HIGHSPEED;
+		mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
=20
 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
 		mmc->caps |=3D MMC_CAP_NEEDS_POLL;
--=20
1.7.0.1

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
