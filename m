From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH] mmc: sdhci: use goto rather than return directly
Date: Tue, 16 Oct 2018 16:19:42 +0800
Message-ID: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The driver should clean resources requested in the function before
unnormal return.

CC: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buffer")
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1b3fbd9..f6b57e1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3991,7 +3991,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		/* This may alter mmc->*_blk_* parameters */
 		ret = sdhci_allocate_bounce_buffer(host);
 		if (ret)
-			return ret;
+			goto unreg;
 	}
 
 	return 0;
-- 
2.7.4
