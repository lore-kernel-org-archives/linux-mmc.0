From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH v4 3/6] ARM: edma: Add function to manually trigger an EDMA channel
Date: Thu, 29 Aug 2013 18:05:42 -0500
Message-ID: <1377817545-18015-4-git-send-email-joelf@ti.com>
References: <1377817545-18015-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377817545-18015-1-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Matt Porter <matt@ohporter.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Russell King <linux@arm.linux.org.uk>, Sricharan R <r.sricharan@ti.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, Franklin Cooper <fcooper@ti.com>, Joel Fernandes <joelf@ti.com>
List-Id: linux-mmc@vger.kernel.org

Manual trigger for events missed as a result of splitting a
scatter gather list and DMA'ing it in batches. Add a helper
function to trigger a channel incase any such events are missed.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/common/edma.c             | 17 +++++++++++++++++
 include/linux/platform_data/edma.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 3567ba1..67e8cf5 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1236,6 +1236,23 @@ void edma_resume(unsigned channel)
 }
 EXPORT_SYMBOL(edma_resume);
 
+int edma_trigger_channel(unsigned channel)
+{
+	unsigned ctlr;
+	unsigned int mask;
+
+	ctlr = EDMA_CTLR(channel);
+	channel = EDMA_CHAN_SLOT(channel);
+	mask = BIT(channel & 0x1f);
+
+	edma_shadow0_write_array(ctlr, SH_ESR, (channel >> 5), mask);
+
+	pr_debug("EDMA: ESR%d %08x\n", (channel >> 5),
+		 edma_shadow0_read_array(ctlr, SH_ESR, (channel >> 5)));
+	return 0;
+}
+EXPORT_SYMBOL(edma_trigger_channel);
+
 /**
  * edma_start - start dma on a channel
  * @channel: channel being activated
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index 57300fd..179fb91 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -180,4 +180,6 @@ struct edma_soc_info {
 	const s16	(*xbar_chans)[2];
 };
 
+int edma_trigger_channel(unsigned);
+
 #endif
-- 
1.8.1.2
