From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] mmc: sdhci-s3c: use S3C_SDHCI_CONTROL2 instead of hardcoded
 offeset value
Date: Wed, 14 Dec 2011 13:25:46 +0900
Message-ID: <003801ccba18$736ebb80$5a4c3280$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:14261 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091Ab1LNEZq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 23:25:46 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LW600GG3EXLYZ90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 14 Dec 2011 13:25:45 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.153])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LW6002VGEYWLV50@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Wed, 14 Dec 2011 13:25:45 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Ben Dooks' <ben-linux@fluff.org>, 'Jingoo Han' <jg1.han@samsung.com>

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index cb60c41..62ff6b4 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -80,7 +80,7 @@ static void sdhci_s3c_check_sclk(struct sdhci_host *host)
 
 		tmp &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
 		tmp |= ourhost->cur_clk << S3C_SDHCI_CTRL2_SELBASECLK_SHIFT;
-		writel(tmp, host->ioaddr + 0x80);
+		writel(tmp, host->ioaddr + S3C_SDHCI_CONTROL2);
 	}
 }
 
-- 
1.7.1


