From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 04/10] mmc: sdhci-esdhc-imx: fix reading cap_1 register value for mx6sl
Date: Wed, 9 Oct 2013 19:20:10 +0800
Message-ID: <1381317616-1229-5-git-send-email-b29396@freescale.com>
References: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:39929
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751704Ab3JILex (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2013 07:34:53 -0400
In-Reply-To: <1381317616-1229-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, b29396@freescale.com, john.tobias.ph@gmail.com

When reading CAP_1 register for mx6sl, ignore bit[0-15] as it stores
CAP_2 register value which is new introduced in mx6sl.

Without this fix, the max clock for mx6sl may not be correct since
it's wrongly calculated by reading CAP_1 register.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2cce244..8721549 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -216,6 +216,10 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 	}
 
 	if (unlikely(reg == SDHCI_CAPABILITIES)) {
+		/* ignore bit[0-15] as it stores cap_2 register val for mx6sl */
+		if (is_imx6sl_usdhc(imx_data))
+			val &= 0xffff0000;
+
 		/* In FSL esdhc IC module, only bit20 is used to indicate the
 		 * ADMA2 capability of esdhc, but this bit is messed up on
 		 * some SOCs (e.g. on MX25, MX35 this bit is set, but they
-- 
1.7.2.rc3


