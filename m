From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 3/5] mmc: tmio: use CTL_STATUS consistently
Date: Tue, 26 Apr 2016 18:53:43 +0200
Message-ID: <1461689625-3693-4-git-send-email-wsa@the-dreams.de>
References: <1461689625-3693-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51373 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbcDZQx5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2016 12:53:57 -0400
In-Reply-To: <1461689625-3693-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms+renesas@verge.net.au>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

To prevent confusion, use the virtual u32 CTL_STATUS in card_busy() the
same way as in other parts of this driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/tmio_mmc.h     | 3 +--
 drivers/mmc/host/tmio_mmc_pio.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 74945c1a66ce81..55f251fdb78623 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -67,14 +67,13 @@
 #define TMIO_STAT_RXOVERFLOW    BIT(20)
 #define TMIO_STAT_TXUNDERRUN    BIT(21)
 #define TMIO_STAT_CMDTIMEOUT    BIT(22)
+#define TMIO_STAT_DAT0		BIT(23)	/* only known on R-Car so far */
 #define TMIO_STAT_RXRDY         BIT(24)
 #define TMIO_STAT_TXRQ          BIT(25)
 #define TMIO_STAT_ILL_FUNC      BIT(29)
 #define TMIO_STAT_CMD_BUSY      BIT(30)
 #define TMIO_STAT_ILL_ACCESS    BIT(31)
 
-#define TMIO_STATUS2_DAT0	BIT(7)
-
 #define	CLK_CTL_DIV_MASK	0xff
 #define	CLK_CTL_SCLKEN		BIT(8)
 
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index dad2ebd3dc22b4..f4d8b5a741a875 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -983,7 +983,7 @@ static int tmio_mmc_card_busy(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
-	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS2) & TMIO_STATUS2_DAT0);
+	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_DAT0);
 }
 
 static struct mmc_host_ops tmio_mmc_ops = {
-- 
2.7.0

