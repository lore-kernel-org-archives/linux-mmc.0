From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 2/4] mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
Date: Mon, 20 Jun 2011 18:38:43 +0800
Message-ID: <1308566325-11600-3-git-send-email-shawn.guo@linaro.org>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37917 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab1FTK3N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 06:29:13 -0400
Received: by mail-iw0-f174.google.com with SMTP id 6so1058030iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 03:29:13 -0700 (PDT)
In-Reply-To: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

The function esdhc_readl_le intends to clear bit SDHCI_CARD_PRESENT,
when the card detect gpio tells there is no card.  But it does not
clear the bit actually.  The patch gives a fix on that.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 248b8e5..94097c0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -84,7 +84,7 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 		if (boarddata && gpio_is_valid(boarddata->cd_gpio)
 				&& gpio_get_value(boarddata->cd_gpio))
 			/* no card, if a valid gpio says so... */
-			val &= SDHCI_CARD_PRESENT;
+			val &= ~SDHCI_CARD_PRESENT;
 		else
 			/* ... in all other cases assume card is present */
 			val |= SDHCI_CARD_PRESENT;
-- 
1.7.4.1

