From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 3/6] mmc: sdhci: introduce private get_ro
Date: Mon, 11 Oct 2010 16:21:03 +0200
Message-ID: <1286806866-19258-4-git-send-email-w.sang@pengutronix.de>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48693 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab0JKOVP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Oct 2010 10:21:15 -0400
In-Reply-To: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

Some controllers handle their write-protection differently. Introduce a
callback to be able to handle it, ensuring the same locking takes place
for it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by : Eric B=C3=A9nard <eric@eukrea.com>
---
 drivers/mmc/host/sdhci.c |   11 +++++++----
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9cb60ba..970110a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1231,14 +1231,17 @@ static int sdhci_get_ro(struct mmc_host *mmc)
=20
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		present =3D 0;
+	else if (host->ops->get_ro)
+		present =3D host->ops->get_ro(host);
 	else
-		present =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
+		present =3D !(sdhci_readl(host, SDHCI_PRESENT_STATE)
+				& SDHCI_WRITE_PROTECT);
=20
 	spin_unlock_irqrestore(&host->lock, flags);
=20
-	if (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT)
-		return !!(present & SDHCI_WRITE_PROTECT);
-	return !(present & SDHCI_WRITE_PROTECT);
+	/* This quirk needs to be replaced by a callback-function later */
+	return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
+		!present : present;
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

