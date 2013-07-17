From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH fix for v3.11 (repost)] dmaengine: shdma: fix a build failure
 on platforms with no DMA support
Date: Thu, 18 Jul 2013 08:50:58 +0900
Message-ID: <20130717235058.GA10683@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Olof Johansson <olof@lixom.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kevin Hilman <khilman@linaro.org>, Dan Murphy <dmurphy@ti.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnusdamm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On platforms with no support for the shdma dmaengine driver build is
currently failing with

drivers/built-in.o: In function `sh_mobile_sdhi_probe':
drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to`shdma_chan_filter'

Fix the breakage by defining shdma_chan_filter to NULL in such
configurations.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
[horms+renesas@verge.net.au: Apply change to shdma-base.h instead of sh_dma.h]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/linux/shdma-base.h | 4 ++++
 1 file changed, 4 insertions(+)

Hi Vinod,

please consider this fix from Guennadi for v3.11 which I have rebased on top of
next-20130709. It fixes a build problem on a number of shmobile defconfigs
including bockw.

Alternatively, I would be happy to take this through the renesas tree.

I posted this patch last week but I'm wondering if you missed it somehow.
This patch resolves a regression in v3.11-rc1.

diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index 382cf71..5b1c984 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -124,6 +124,10 @@ void shdma_chan_remove(struct shdma_chan *schan);
 int shdma_init(struct device *dev, struct shdma_dev *sdev,
 		    int chan_num);
 void shdma_cleanup(struct shdma_dev *sdev);
+#if IS_ENABLED(CONFIG_SH_DMAE_BASE)
 bool shdma_chan_filter(struct dma_chan *chan, void *arg);
+#else
+#define shdma_chan_filter NULL
+#endif
 
 #endif
-- 
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

