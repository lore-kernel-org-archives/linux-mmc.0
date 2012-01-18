From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 05/12] dmaengine/dw_dmac: Don't use magic number for total
 number of channels
Date: Wed, 18 Jan 2012 14:41:52 +0530
Message-ID: <0bd6490c26e9b4cb56ea585a76d31b8a34101220.1326876464.git.viresh.kumar@st.com>
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

Total number of channels is passed in pdata->nr_channels variable, thus we must
not use magic number '7' for total number of channels.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 3a3d7ed..1577394 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1432,7 +1432,7 @@ static int __init dw_probe(struct platform_device *pdev)
 
 		/* 7 is highest priority & 0 is lowest. */
 		if (pdata->chan_priority == CHAN_PRIORITY_ASCENDING)
-			dwc->priority = 7 - i;
+			dwc->priority = pdata->nr_channels - i - 1;
 		else
 			dwc->priority = i;
 
-- 
1.7.8.110.g4cb5d
