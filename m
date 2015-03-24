From: NeilBrown <neil@brown.name>
Subject: [PATCH 3/4] mmc/sdio: keep device awake when interrupts expected in
 4bit mode
Date: Wed, 25 Mar 2015 07:56:10 +1100
Message-ID: <20150324205610.20572.48941.stgit@notabene.brown>
References: <20150324205316.20572.30538.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55437 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbbCXVIm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Mar 2015 17:08:42 -0400
In-Reply-To: <20150324205316.20572.30538.stgit@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

In 4-bit mode, SDIO interrupts are only reliable if clocks
are maintained.
So get an extra reference when that is the case.

Signed-off-by: NeilBrown  <neil@brown.name>
---
 drivers/mmc/core/sdio.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5bc6c7dbbd60..f432b11677bd 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -227,6 +227,9 @@ static int sdio_enable_wide(struct mmc_card *card)
 	if (ret)
 		return ret;
 
+	/* Interrupts only work in 4bit mode if clocks stay on */
+	if (card->host->caps & MMC_CAP_SDIO_IRQ)
+		pm_runtime_get(card->host->parent);
 	return 1;
 }
 
@@ -283,6 +286,8 @@ static int sdio_disable_wide(struct mmc_card *card)
 		return ret;
 
 	mmc_set_bus_width(card->host, MMC_BUS_WIDTH_1);
+	if (card->host->caps & MMC_CAP_SDIO_IRQ)
+		pm_runtime_put(card->host->parent);
 
 	return 0;
 }


