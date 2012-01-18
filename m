From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 02/12] dmaengine: Add flow controller information to
 dma_slave_config
Date: Wed, 18 Jan 2012 14:41:49 +0530
Message-ID: <5f9ec59562e86536c4123f61891b95590293030f.1326876464.git.viresh.kumar@st.com>
References: <cover.1326876464.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1326876464.git.viresh.kumar@st.com>
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

Flow controller is programmable for few controllers and there are few
intelligent peripherals like, Synopsys JPEG controller, that needs to be a flow
controller of DMA transfers on dest side.

For this, currently two drivers, pl08x and dw_dmac, support flow controller to
be passed from platform to these drivers.

Perhaps, this should be a part of struct dma_slave_config. This patch adds
another field device_fc to this structure. User drivers must pass this as true
if they want to be flow controller of certain transfers.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 include/linux/dmaengine.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 5532bb8..dd1915f 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -25,6 +25,7 @@
 #include <linux/uio.h>
 #include <linux/scatterlist.h>
 #include <linux/bitmap.h>
+#include <linux/types.h>
 #include <asm/page.h>
 
 /**
@@ -330,6 +331,9 @@ enum dma_slave_buswidth {
  * may or may not be applicable on memory sources.
  * @dst_maxburst: same as src_maxburst but for destination target
  * mutatis mutandis.
+ * @device_fc: Flow Controller Settings for ccfg register. Only valid for slave
+ * channels. Fill with 'true' if peripheral should be flow controller. Direction
+ * will be selected at Runtime.
  *
  * This struct is passed in as configuration data to a DMA engine
  * in order to set up a certain channel for DMA transport at runtime.
@@ -356,6 +360,7 @@ struct dma_slave_config {
 	enum dma_slave_buswidth dst_addr_width;
 	u32 src_maxburst;
 	u32 dst_maxburst;
+	bool device_fc;
 };
 
 static inline const char *dma_chan_name(struct dma_chan *chan)
-- 
1.7.8.110.g4cb5d
