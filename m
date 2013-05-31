From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2] dmaengine: shdma: fix a build failure on platforms with
 no DMA support
Date: Fri, 31 May 2013 05:01:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305310423360.1470@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53645 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab3EaDCI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 23:02:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>

On platforms with no support for the shdma dmaengine driver build is
currently failing with

drivers/built-in.o: In function `sh_mobile_sdhi_probe':
drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to`shdma_chan_filter'

Fix the breakage by defining shdma_chan_filter to NULL in such
configurations.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2: in "next" shdma_chan_filter() is defined in shdma-base.c, which is 
built if CONFIG_SH_DMAE_BASE is defined. This version uses the correct 
symbol.

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
 
+#if IS_ENABLED(CONFIG_SH_DMAE_BASE)
 bool shdma_chan_filter(struct dma_chan *chan, void *arg);
+#else
+#define shdma_chan_filter NULL
+#endif
 
 #endif
-- 
1.7.2.5
