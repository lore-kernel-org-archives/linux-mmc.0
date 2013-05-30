From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] dmaengine: shdma: fix a build failure on platforms with no
 DMA support
Date: Thu, 30 May 2013 18:02:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305301650290.29171@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On platforms with no support for the shdma dmaengine driver build is
currently failing with

drivers/built-in.o: In function `sh_mobile_sdhi_probe':
drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to`shdma_chan_filter'

Fix the breakage by defining shdma_chan_filter to NULL in such
configurations.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

This is for "next." Compile-tested only. I'll test it on hardware next 
week, but I don't think it shall break anything.

 include/linux/sh_dma.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index b64d6be..1fd8a20 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -99,6 +99,10 @@ struct sh_dmae_pdata {
 #define CHCR_TE	0x00000002
 #define CHCR_IE	0x00000004
 
+#if IS_ENABLED(CONFIG_SH_DMAE)
 bool shdma_chan_filter(struct dma_chan *chan, void *arg);
+#else
+#define shdma_chan_filter NULL
+#endif
 
 #endif
-- 
1.7.2.5
