From: Matt Porter <mporter@ti.com>
Subject: [PATCH v6 07/10] dmaengine: add dma_request_slave_channel_compat()
Date: Wed, 30 Jan 2013 02:00:26 -0500
Message-ID: <1359529229-22207-8-git-send-email-mporter@ti.com>
References: <1359529229-22207-1-git-send-email-mporter@ti.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1359529229-22207-1-git-send-email-mporter@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>
Cc: Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

Adds a dma_request_slave_channel_compat() wrapper which accepts
both the arguments from dma_request_channel() and
dma_request_slave_channel(). Based on whether the driver is
instantiated via DT, the appropriate channel request call will be
made.

This allows for a much cleaner migration of drivers to the
dmaengine DT API as platforms continue to be mixed between those
that boot using DT and those that do not.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Matt Porter <mporter@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 include/linux/dmaengine.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index bfcdecb..17d8ffd 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1001,6 +1001,22 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
 struct dma_chan *net_dma_find_channel(void);
 #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
+#define dma_request_slave_channel_compat(mask, x, y, dev, name) \
+	__dma_request_slave_channel_compat(&(mask), x, y, dev, name)
+
+static inline struct dma_chan
+*__dma_request_slave_channel_compat(dma_cap_mask_t *mask, dma_filter_fn fn,
+				  void *fn_param, struct device *dev,
+				  char *name)
+{
+	struct dma_chan *chan;
+
+	chan = dma_request_slave_channel(dev, name);
+	if (chan)
+		return chan;
+
+	return __dma_request_channel(mask, fn, fn_param);
+}
 
 /* --- Helper iov-locking functions --- */
 
-- 
1.7.9.5

