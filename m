From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/12] mmci: allow the card detect status not to be
	inverted
Date: Thu, 29 Jul 2010 13:34:43 +0100
Message-ID: <20100729123443.GA18923@n2100.arm.linux.org.uk>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com> <1277198267-10860-4-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33261 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756996Ab0G2MfI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jul 2010 08:35:08 -0400
Content-Disposition: inline
In-Reply-To: <1277198267-10860-4-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin.vincent@stericsson.com>, Colin Tuckley <colin.tuckley@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, STEricsson_nomadik_linux@list.st.com, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>

On Tue, Jun 22, 2010 at 02:47:39PM +0530, Rabin Vincent wrote:
> On some platforms, the GPIO value from the gpio_cd pin doesn't need to
> be inverted to get it active high.

Argh.

Actually, I think the inversion of the card status is a bug - certainly
for Versatile it is.  It was on Realview as well before b56ba8a changed
the sense for Realview - so it seems b56ba8a was the wrong fix.

So, this patch restores the card detect functionality across the ARM
devel platforms to what it was prior to the addition of GPIOLIB support.

What now needs to happen is the sense of the GPIOLIB support on platforms
needs to be checked - eg, I suspect the card detect via the GPIO primecell
is inverted on Realview - in which case we need a 'cd_invert' rather
than the negative 'cd_noinvert'.

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index d8179ea..f9dc99c 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -243,7 +243,7 @@ static unsigned int realview_mmc_status(struct device *dev)
 		 * way to do this on the PB1176.
 		 */
 		inserted = !inserted;
-		return inserted ? 0 : 1;
+		return inserted ? 1 : 0;
 	}
 
 	if (adev->res.start == REALVIEW_MMCI0_BASE)
@@ -251,7 +251,7 @@ static unsigned int realview_mmc_status(struct device *dev)
 	else
 		mask = 2;
 
-	return !(readl(REALVIEW_SYSMCI) & mask);
+	return readl(REALVIEW_SYSMCI) & mask;
 }
 
 struct mmci_platform_data realview_mmc0_plat_data = {
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9bf9194..02bf365 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -557,7 +557,7 @@ static int mmci_get_cd(struct mmc_host *mmc)
 	else
 		status = gpio_get_value(host->gpio_cd);
 
-	return !status;
+	return status;
 }
 
 static const struct mmc_host_ops mmci_ops = {
