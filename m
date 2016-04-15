From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 23/23] mmc: sdhci-esdhc-imx: clear tuning bits during hwinit
Date: Sat, 16 Apr 2016 01:29:47 +0800
Message-ID: <1460741387-23815-24-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0062.outbound.protection.outlook.com ([157.56.110.62]:25952
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752646AbcDORiR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Apr 2016 13:38:17 -0400
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com, haibo.chen@nxp.com, dongas86@gmail.com

The tuning bits like FBCLK_SEL, SMP_CLK_SEL and DLY_CELL which affects
timing may have already been set by ROM if booting from SD3.0 mode like
SDR104. Let's clear it first during hw initialization before do the
new card enumeration.

For system resume case, it's safe to clear them too since the following
card re-initialization in mmc_xx_init_card() will do retuning and set
correct value again.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 98aa6b5..6a699d1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1018,6 +1018,11 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 			}
 			writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
 		}
+
+		/* clear tuning bits in case ROM has set it already */
+		writel(0x0, host->ioaddr + ESDHC_MIX_CTRL);
+		writel(0x0, host->ioaddr + SDHCI_ACMD12_ERR);
+		writel(0x0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 	}
 }
 
-- 
1.9.1

