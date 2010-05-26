From: akpm@linux-foundation.org
Subject: [patch 003/203] sdhci: implement CAP_CLOCK_BASE_BROKEN quirk
Date: Wed, 26 May 2010 14:41:53 -0700
Message-ID: <201005262141.o4QLfr3I015307@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60598 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753378Ab0EZVmz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 17:42:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, ben@simtec.co.uk, david.vrabel@csr.com, linux-mmc@vger.kernel.org, pierre@ossman.eu, richard.rojfors@pelagicore.com

=46rom: Anton Vorontsov <avorontsov@ru.mvista.com>

Some hosts (e.g.  as found in CNS3xxx SOCs) report wrong value in
CLOCK_BASE capability field, and currently there is no way to force the
SDHCI core to use the platform-provided base clock value.

This patch implements CAP_CLOCK_BASE_BROKEN quirk.  When enabled, the
SDHCI core will always use base clock frequency provided by the platfor=
m.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Richard R=F6jfors <richard.rojfors@pelagicore.com>
Cc: David Vrabel <david.vrabel@csr.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci.c |    3 ++-
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/host/sdhci.c~sdhci-implement-cap_clock_base_broke=
n-quirk drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c~sdhci-implement-cap_clock_base_broken-qu=
irk
+++ a/drivers/mmc/host/sdhci.c
@@ -1744,7 +1744,8 @@ int sdhci_add_host(struct sdhci_host *ho
 	host->max_clk =3D
 		(caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
 	host->max_clk *=3D 1000000;
-	if (host->max_clk =3D=3D 0) {
+	if (host->max_clk =3D=3D 0 || host->quirks &
+			SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN) {
 		if (!host->ops->get_max_clock) {
 			printk(KERN_ERR
 			       "%s: Hardware doesn't specify base clock "
diff -puN drivers/mmc/host/sdhci.h~sdhci-implement-cap_clock_base_broke=
n-quirk drivers/mmc/host/sdhci.h
--- a/drivers/mmc/host/sdhci.h~sdhci-implement-cap_clock_base_broken-qu=
irk
+++ a/drivers/mmc/host/sdhci.h
@@ -236,6 +236,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
 /* Controller uses SDCLK instead of TMCLK for data timeouts */
 #define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
+/* Controller reports wrong base clock capability */
+#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
=20
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
_
