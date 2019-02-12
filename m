From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/14] mmc: remove the unused use_blk_mq field from struct mmc_host
Date: Tue, 12 Feb 2019 08:25:16 +0100
Message-ID: <20190212072528.13167-3-hch@lst.de>
References: <20190212072528.13167-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mmc/host.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4d35ff36ceff..4eadf01b4a93 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -397,7 +397,6 @@ struct mmc_host {
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
-	unsigned int		use_blk_mq:1;	/* use blk-mq */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
2.20.1
