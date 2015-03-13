From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH] mmc: sdhci-iproc: fix oops in sdhci_iproc_writew
Date: Thu, 12 Mar 2015 18:11:01 -0700
Message-ID: <20150313011101.GA24853@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Corneliu Doban <cdoban@broadcom.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The driver co-allocates sdhci_iproc_host with sdhci_pltfm_host and so to
access it we need to use sdhci_pltfm_priv() and not pltfm_host->priv.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/mmc/host/sdhci-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 4139d34..3b423b0 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -97,7 +97,7 @@ static inline void sdhci_iproc_writel(struct sdhci_host *host, u32 val, int reg)
 static void sdhci_iproc_writew(struct sdhci_host *host, u16 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_iproc_host *iproc_host = pltfm_host->priv;
+	struct sdhci_iproc_host *iproc_host = sdhci_pltfm_priv(pltfm_host);
 	u32 word_shift = REG_OFFSET_IN_BITS(reg);
 	u32 mask = 0xffff << word_shift;
 	u32 oldval, newval;
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
