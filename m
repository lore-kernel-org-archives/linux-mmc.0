From: Rabin VINCENT <rabin.vincent@stericsson.com>
Subject: Re: [PATCH 04/12] mmci: allow the card detect status not to be
 inverted
Date: Mon, 9 Aug 2010 16:07:05 +0530
Message-ID: <20100809103704.GB5826@bnru01.bnr.st.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
 <1277198267-10860-4-git-send-email-rabin.vincent@stericsson.com>
 <20100729123443.GA18923@n2100.arm.linux.org.uk>
 <AANLkTikQi+SPpx8Wpvb0siSSsw0ZhusWaaKmqRnfHrnz@mail.gmail.com>
 <20100729142011.GG18923@n2100.arm.linux.org.uk>
 <20100805061453.GA7524@bnru02.bnr.st.com>
 <20100805092531.GA23473@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:50812 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756049Ab0HIKiB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2010 06:38:01 -0400
Content-Disposition: inline
In-Reply-To: <20100805092531.GA23473@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Colin Tuckley <colin.tuckley@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Aug 05, 2010 at 11:25:31 +0200, Russell King - ARM Linux wrote:
> On Thu, Aug 05, 2010 at 11:44:54AM +0530, Rabin VINCENT wrote:
> > so are you OK with the cd_noinvert addition (for the GPIO case)?
> > Or a cd_invert and a patch to existing platforms?
> 
> I'd much prefer positive logic.  Double negatives (eg, not noinverted)
> are always bad news.

Here's the new patch.  I'll rebase the rest of the unapplied patches in
the series on top of this.

>From 8a8be58873c571703ee03296744a3719ff16a026 Mon Sep 17 00:00:00 2001
From: Rabin Vincent <rabin.vincent@stericsson.com>
Date: Wed, 16 Jun 2010 15:58:59 +0530
Subject: [PATCH] mmci: allow the card detect GPIO value not to be inverted

On some platforms, the GPIO value from the gpio_cd pin doesn't need to
be inverted to get it active high.  Add a cd_invert platform data
parameter and change existing platforms using GPIO for CD (only
Realview) to enable it.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-realview/core.c |    2 ++
 drivers/mmc/host/mmci.c       |    5 +++--
 include/linux/amba/mmci.h     |    2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 2fa38df..07c0815 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -259,6 +259,7 @@ struct mmci_platform_data realview_mmc0_plat_data = {
 	.status		= realview_mmc_status,
 	.gpio_wp	= 17,
 	.gpio_cd	= 16,
+	.cd_invert	= true,
 };
 
 struct mmci_platform_data realview_mmc1_plat_data = {
@@ -266,6 +267,7 @@ struct mmci_platform_data realview_mmc1_plat_data = {
 	.status		= realview_mmc_status,
 	.gpio_wp	= 19,
 	.gpio_cd	= 18,
+	.cd_invert	= true,
 };
 
 /*
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 840b301..9a9aeac 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -570,12 +570,13 @@ static int mmci_get_ro(struct mmc_host *mmc)
 static int mmci_get_cd(struct mmc_host *mmc)
 {
 	struct mmci_host *host = mmc_priv(mmc);
+	struct mmci_platform_data *plat = host->plat;
 	unsigned int status;
 
 	if (host->gpio_cd == -ENOSYS)
-		status = host->plat->status(mmc_dev(host->mmc));
+		status = plat->status(mmc_dev(host->mmc));
 	else
-		status = !gpio_get_value(host->gpio_cd);
+		status = !!gpio_get_value(host->gpio_cd) ^ plat->cd_invert;
 
 	/*
 	 * Use positive logic throughout - status is zero for no card,
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index ca84ce7..f4ee9ac 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -24,6 +24,7 @@
  * whether a card is present in the MMC slot or not
  * @gpio_wp: read this GPIO pin to see if the card is write protected
  * @gpio_cd: read this GPIO pin to detect card insertion
+ * @cd_invert: true if the gpio_cd pin value is active low
  * @capabilities: the capabilities of the block as implemented in
  * this platform, signify anything MMC_CAP_* from mmc/host.h
  */
@@ -35,6 +36,7 @@ struct mmci_platform_data {
 	unsigned int (*status)(struct device *);
 	int	gpio_wp;
 	int	gpio_cd;
+	bool	cd_invert;
 	unsigned long capabilities;
 };
 
-- 
1.7.2.dirty

