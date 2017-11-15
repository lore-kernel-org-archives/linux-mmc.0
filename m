From: <yinbo.zhu@nxp.com>
Subject: [PATCH v1] mmc: sdhci-of-esdhc: Workaround for reducing the maximum speed on ls1021atwr
Date: Wed, 15 Nov 2017 17:01:03 +0800
Message-ID: <20171115090103.25366-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:43741
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757260AbdKOJT2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Nov 2017 04:19:28 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com
Cc: yangbo.lu@nxp.com, yinbo.zhu@nxp.com, linux-mmc@vger.kernel.org

From: "yinbo.zhu" <yinbo.zhu@nxp.com>

In SDHC high speed AC timing, the tshivkh parameter
is defined as input setup times:SDHC_CMD, SDHC_DATx,
to SDHC_CLK. The value of the tshivkh should be 2.5 ns
considering the round trip delay, board/data skew.
However, because of this erratum, it needs
at least 4.1 ns.

eSDHC cannot run at the maximum clock speed for the
high speed mode, or there is a limit on the length
of the trace on the board for data, command, and
clock lines of the SDHC.

Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 023c24bd0d94..2744dd58a573 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -498,6 +498,12 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 			clock -= 5000000;
 	}
 
+	/* Workaround to reduce the clock frequency for ls1021a esdhc */
+	if (of_find_compatible_node(NULL, NULL, "fsl,ls1021a-esdhc")) {
+		if (clock == 50000000)
+			clock = 46500000;
+	}
+
 	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
 	temp &= ~(ESDHC_CLOCK_SDCLKEN | ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN |
 		  ESDHC_CLOCK_PEREN | ESDHC_CLOCK_MASK);
-- 
2.14.1

