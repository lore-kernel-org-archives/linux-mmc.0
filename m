From: "Tardy, Pierre" <pierre.tardy@intel.com>
Subject: RE: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Tue, 25 Jan 2011 21:34:28 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69934EFA98B2@irsmsx501.ger.corp.intel.com>
References: <20110114082310.GB27523@intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
	<5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AAB20@irsmsx501.ger.corp.intel.com>
	<5D8008F58939784290FAB48F5497519835247E72AD@shsmsx502.ccr.corp.intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AACCC@irsmsx501.ger.corp.intel.com>
	<20110120050803.GA5732@void.printf.net>
 <AANLkTimZyv9f5b5VxmmYyO3qPrb9Y25-=yUV_GYma3e_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:61017 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112Ab1AYVed convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jan 2011 16:34:33 -0500
In-Reply-To: <AANLkTimZyv9f5b5VxmmYyO3qPrb9Y25-=yUV_GYma3e_@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Linus Walleij [mailto:linus.ml.walleij@gmail.com]
> Sent: Monday, January 24, 2011 11:11 PM
> To: Chris Ball
> Cc: Tardy, Pierre; linux-mmc@vger.kernel.org; Ohad Ben-Cohen; linux-o=
map Mailing List
> Subject: Re: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
>=20
> 2011/1/20 Chris Ball <cjb@laptop.org>:
> > On Wed, Jan 19, 2011 at 09:45:57AM +0000, Tardy, Pierre wrote:
> >> Chris,
> >> (Sorry for top posting)
> >> Seems we have a intel intern disagreement.
> >>
> >> Could we have maintainer opinion on this ?
> >
> > Linus W and Ohad, any input here? =A0Thanks,
>=20
> What I see is orthogonal purposes altogether. Usually there is
> something like two clocks and two regulators or switches
> available in every sufficiently advanced system:
>=20
> - One regulator to power the card
> - One clock to clock the card (MCLK)
> - One regulator or switch to power the MMC IP block
> - One clock to clock the MMC IP block
>=20
> The MMC core regulator handling and the clock gating I
> implemented is about the two first things.
>=20
> I think this patch is about the two *other* things, if I read it
> right.

Actually in sdhci, you power off the MMC IP block, you power OFF the MC=
LK (at least on our platform)

I don't know other platform where mmc clock is not controlled more or l=
ess directlty by the sdhc IP.

> Further this patch cannot be applied as-is.
> It needs a clause where it will wait for the clock gating to
> be sync:ed *before* calling the suspend hook.
That's the purpose of those hunks:

iff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8c3769b..27931f6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
=20
 #include <linux/leds.h>
=20
@@ -1221,6 +1222,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, s=
truct mmc_ios *ios)
 {
        struct sdhci_host *host;
        unsigned long flags;
+       unsigned int lastclock;
        u8 ctrl;
=20
        host =3D mmc_priv(mmc);
@@ -1231,6 +1233,27 @@ static void sdhci_set_ios(struct mmc_host *mmc, =
struct mmc_ios *ios)
                goto out;
=20
        /*
+        * get/put runtime_pm usage counter at ios->clock transitions
+        * We need to do it before any other chip access, as sdhci coul=
d
+        * be power gated
+        */
+       lastclock =3D host->iosclock;
+       host->iosclock =3D ios->clock;
+       if (lastclock =3D=3D 0 && ios->clock !=3D 0) {
+               spin_unlock_irqrestore(&host->lock, flags);
+               pm_runtime_get_sync(host->mmc->parent);
+               spin_lock_irqsave(&host->lock, flags);
+       } else if (lastclock !=3D 0 && ios->clock =3D=3D 0) {
+               spin_unlock_irqrestore(&host->lock, flags);
+               pm_runtime_mark_last_busy(host->mmc->parent);
+               pm_runtime_put_autosuspend(host->mmc->parent);
+               spin_lock_irqsave(&host->lock, flags);
+       }
+       /* no need to configure the rest.. */
+       if (host->iosclock =3D=3D 0)
+               goto out;
+
+       /*
         * Reset the chip on each power off.
         * Should clear out any weird states.
         */
@@ -1303,6 +1326,8 @@ static int sdhci_get_ro(struct mmc_host *mmc)

I'm wondering if this code could be generic to all drivers, and if cloc=
k gating could not be taking/releasing reference counter on the mmc_bus=
 whenever there is a clock gating transition?
We could condition that on some MMC_CAP_POWERGATE_WILL_CLKGATE capabili=
ty flag.


Regards,
Pierre
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris,=20
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

