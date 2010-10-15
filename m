From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 3/6] mmc: sdhci: introduce private get_ro
Date: Fri, 15 Oct 2010 12:21:01 +0200
Message-ID: <1287138064-21385-4-git-send-email-w.sang@pengutronix.de>
References: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58916 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab0JOKVU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Oct 2010 06:21:20 -0400
In-Reply-To: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

Some controllers handle their write-protection differently. Introduce a
callback to be able to handle it, ensuring the same locking takes place
for it. Rename the status variable to make it more obvious why the read
from the registers needs to be inverted.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by : Eric B=C3=A9nard <eric@eukrea.com>
---

Changes since last version:

rename the variable to make usage of '!' more obvious

 drivers/mmc/host/sdhci.c |   15 +++++++++------
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9cb60ba..782c0ee 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1223,22 +1223,25 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
-	int present;
+	int is_readonly;
=20
 	host =3D mmc_priv(mmc);
=20
 	spin_lock_irqsave(&host->lock, flags);
=20
 	if (host->flags & SDHCI_DEVICE_DEAD)
-		present =3D 0;
+		is_readonly =3D 0;
+	else if (host->ops->get_ro)
+		is_readonly =3D host->ops->get_ro(host);
 	else
-		present =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
+		is_readonly =3D !(sdhci_readl(host, SDHCI_PRESENT_STATE)
+				& SDHCI_WRITE_PROTECT);
=20
 	spin_unlock_irqrestore(&host->lock, flags);
=20
-	if (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT)
-		return !!(present & SDHCI_WRITE_PROTECT);
-	return !(present & SDHCI_WRITE_PROTECT);
+	/* This quirk needs to be replaced by a callback-function later */
+	return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
+		!is_readonly : is_readonly;
 }
=20
 static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index bfcd611..b7b8a3b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -214,6 +214,7 @@ struct sdhci_ops {
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
+	unsigned int    (*get_ro)(struct sdhci_host *host);
 };
=20
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
--=20
1.7.1

