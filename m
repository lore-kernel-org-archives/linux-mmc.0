From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V3 03/12] dmaengine: Pass dma_slave_config .device_fc = NULL
 for all existing users
Date: Wed, 1 Feb 2012 16:12:19 +0530
Message-ID: <c973ec53b05899701cd09def1bf872862a1df67d.1328091915.git.viresh.kumar@st.com>
References: <cover.1328091915.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1328091915.git.viresh.kumar@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: rajeev-dlh.kumar@st.com, bhupesh.sharma@st.com, linus.walleij@linaro.org, mirko.gardi@st.com, perex@perex.cz, vipin.kumar@st.com, vipulkumar.samar@st.com, egtvedt@samfundet.no, pratyush.anand@st.com, deepak.sikri@st.com, rmk+kernel@arm.linux.org.uk, cjb@laptop.org, hskinnemoen@gmail.com, bhavna.yadav@st.com, armando.visconti@st.com, shiraz.hashim@st.com, amit.virdi@st.com, vincenzo.frascino@st.com, ulf.hansson@stericsson.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.linux@gmail.com, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

.device_fc is added in struct dma_slave_config recently. All user drivers, which
want DMA to be the flow controller must pass this field as false. As earlier
driver don't look to use this feature, mark it false for now.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c         |    2 ++
 drivers/mmc/host/mxcmmc.c       |    2 ++
 drivers/spi/spi-dw-mid.c        |    3 +++
 drivers/spi/spi-pl022.c         |    2 ++
 drivers/tty/serial/amba-pl011.c |    3 +++
 drivers/usb/musb/ux500_dma.c    |    1 +
 sound/soc/imx/imx-pcm-dma-mx2.c |    3 +++
 7 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0b44d6b..a6b7068 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -30,6 +30,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/amba/mmci.h>
 #include <linux/pm_runtime.h>
+#include <linux/types.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -370,6 +371,7 @@ static int mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
 		.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
 		.src_maxburst = variant->fifohalfsize >> 2, /* # of words */
 		.dst_maxburst = variant->fifohalfsize >> 2, /* # of words */
+		.device_fc = false,
 	};
 	struct dma_chan *chan;
 	struct dma_device *device;
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index a17bc12..231c75a 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -33,6 +33,7 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/dmaengine.h>
+#include <linux/types.h>
 
 #include <asm/dma.h>
 #include <asm/irq.h>
@@ -710,6 +711,7 @@ static int mxcmci_setup_dma(struct mmc_host *mmc)
 	config->src_addr_width = 4;
 	config->dst_maxburst = host->burstlen;
 	config->src_maxburst = host->burstlen;
+	config->device_fc = false;
 
 	return dmaengine_slave_config(host->dma, config);
 }
diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 8418eb0..04d6c1b 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 
 #include "spi-dw.h"
 
@@ -136,6 +137,7 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	txconf.dst_maxburst = LNW_DMA_MSIZE_16;
 	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	txconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	txconf.device_fc = false;
 
 	txchan->device->device_control(txchan, DMA_SLAVE_CONFIG,
 				       (unsigned long) &txconf);
@@ -158,6 +160,7 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, int cs_change)
 	rxconf.src_maxburst = LNW_DMA_MSIZE_16;
 	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	rxconf.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	rxconf.device_fc = false;
 
 	rxchan->device->device_control(rxchan, DMA_SLAVE_CONFIG,
 				       (unsigned long) &rxconf);
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 95400fa..5125c0c 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -905,10 +905,12 @@ static int configure_dma(struct pl022 *pl022)
 	struct dma_slave_config rx_conf = {
 		.src_addr = SSP_DR(pl022->phybase),
 		.direction = DMA_DEV_TO_MEM,
+		.device_fc = false,
 	};
 	struct dma_slave_config tx_conf = {
 		.dst_addr = SSP_DR(pl022->phybase),
 		.direction = DMA_MEM_TO_DEV,
+		.device_fc = false,
 	};
 	unsigned int pages;
 	int ret;
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e4d5a21..44d050d 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -51,6 +51,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
 #include <linux/delay.h>
+#include <linux/types.h>
 
 #include <asm/io.h>
 #include <asm/sizes.h>
@@ -270,6 +271,7 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 		.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
 		.direction = DMA_MEM_TO_DEV,
 		.dst_maxburst = uap->fifosize >> 1,
+		.device_fc = false,
 	};
 	struct dma_chan *chan;
 	dma_cap_mask_t mask;
@@ -303,6 +305,7 @@ static void pl011_dma_probe_initcall(struct uart_amba_port *uap)
 			.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
 			.direction = DMA_DEV_TO_MEM,
 			.src_maxburst = uap->fifosize >> 1,
+			.device_fc = false,
 		};
 
 		chan = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
diff --git a/drivers/usb/musb/ux500_dma.c b/drivers/usb/musb/ux500_dma.c
index f8fd0dd..7694392 100644
--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -143,6 +143,7 @@ static bool ux500_configure_channel(struct dma_channel *channel,
 	slave_conf.dst_addr = usb_fifo_addr;
 	slave_conf.dst_addr_width = addr_width;
 	slave_conf.dst_maxburst = 16;
+	slave_conf.device_fc = false;
 
 	dma_chan->device->device_control(dma_chan, DMA_SLAVE_CONFIG,
 					     (unsigned long) &slave_conf);
diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index 7d28de9..9a0946c 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/dmaengine.h>
+#include <linux/types.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -106,6 +107,8 @@ static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
+	slave_config.device_fc = false;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		slave_config.direction = DMA_MEM_TO_DEV;
 		slave_config.dst_addr = dma_params->dma_addr;
-- 
1.7.8.110.g4cb5d
