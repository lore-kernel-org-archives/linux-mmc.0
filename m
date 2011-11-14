From: Per Forlin <per.forlin@stericsson.com>
Subject: [PATCH] ARM: mmci: add capabilities2 for MMC_CAP2
Date: Mon, 14 Nov 2011 12:02:28 +0100
Message-ID: <1321268548-21933-1-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:33396 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754418Ab1KNLDd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2011 06:03:33 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@stericsson.com, Linus Walleij <linus.walleij@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, Per Forlin <per.forlin@stericsson.com>

Signed-off-by: Per Forlin <per.forlin@stericsson.com>
---
This patch depends on patches adding CAP2 available on mmc-next.
Chris, would you mind merging this through your tree when it
has been accepted.

 drivers/mmc/host/mmci.c   |    1 +
 include/linux/amba/mmci.h |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 4602771..c1cf80c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1231,6 +1231,7 @@ static int __devinit mmci_probe(struct amba_device *dev,
 	if (host->vcc == NULL)
 		mmc->ocr_avail = plat->ocr_mask;
 	mmc->caps = plat->capabilities;
+	mmc->caps2 = plat->capabilities2;
 
 	/*
 	 * We can do SGIO
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index 2111481..3749e13 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -30,6 +30,7 @@ struct dma_chan;
  * @cd_invert: true if the gpio_cd pin value is active low
  * @capabilities: the capabilities of the block as implemented in
  * this platform, signify anything MMC_CAP_* from mmc/host.h
+ * @capabilities2: more capabilities, MMC_CAP2_* from mmc/host.h
  * @dma_filter: function used to select an appropriate RX and TX
  * DMA channel to be used for DMA, if and only if you're deploying the
  * generic DMA engine
@@ -52,6 +53,7 @@ struct mmci_platform_data {
 	int	gpio_cd;
 	bool	cd_invert;
 	unsigned long capabilities;
+	unsigned long capabilities2;
 	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
 	void *dma_rx_param;
 	void *dma_tx_param;
-- 
1.6.3.3

