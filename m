From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: Fix SDIO interrupts
Date: Mon, 15 Apr 2013 17:08:35 +0200
Message-ID: <20130415150835.7614.98080.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mta1.parkeon.com ([91.121.43.66]:35813 "EHLO mta1.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab3DOPxT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Apr 2013 11:53:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Currently SDIO interrupts do not work on i.MX53 and maybe others.

This was observed with a Marvell 8787 based SDIO wifi adapter
using the mwifiex driver and firmware from the Marvell git
repository.
The symptom was a timeout after firmware download.

Observing the SDIO_DAT1 line showed that an interrupt was requested
(level 0) but no interrupt was generated in software, the line
stayed low until a timeout ocurred and the card was reset.

There is a Freescale errata
	ENGcm11186 "eSDHC misses SDIO interrupt when CINT is disabled"

The workaround suggested by this errata is already implemented and
involves clearing and then setting the D3CD bit in the host control
register [see esdhc_writel_le()]

However, when esdhc_writeb_le() is later used to write to
SDHCI_HOST_CONTROL it always resets the D3CD bit.

To fix this simply add the D3CD bit to the set of bits
not modified by esdhc_writeb_le().

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 78ac002..3c4c63d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -324,8 +324,10 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		/*
 		 * Do not touch buswidth bits here. This is done in
 		 * esdhc_pltfm_bus_width.
+		 * Do not touch the D3CD bit either which is used for the
+		 * SDIO interrupt errata workaround.
 		 */
-		mask = 0xffff & ~ESDHC_CTRL_BUSWIDTH_MASK;
+		mask = 0xffff & ~(ESDHC_CTRL_BUSWIDTH_MASK | ESDHC_CTRL_D3CD);
 
 		esdhc_clrset_le(host, mask, new_val, reg);
 		return;

