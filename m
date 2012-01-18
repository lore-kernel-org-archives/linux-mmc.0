From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 01/12] dmaengine/dw_dmac: Hibernation support in dw_dmac
Date: Wed, 18 Jan 2012 14:41:48 +0530
Message-ID: <91f435464b40009113ddc3d2287f10d81e498654.1326876464.git.viresh.kumar@st.com>
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

From: Rajeev KUMAR <rajeev-dlh.kumar@st.com>

The suspend and resume implementation is through dev_pm_ops in dmac. So
in order to support hibernation, freeze, thaw, restore and poweroff
features are required.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Acked-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 9b592b0..3a3d7ed 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1562,6 +1562,10 @@ static int dw_resume_noirq(struct device *dev)
 static const struct dev_pm_ops dw_dev_pm_ops = {
 	.suspend_noirq = dw_suspend_noirq,
 	.resume_noirq = dw_resume_noirq,
+	.freeze_noirq = dw_suspend_noirq,
+	.thaw_noirq = dw_resume_noirq,
+	.restore_noirq = dw_resume_noirq,
+	.poweroff_noirq = dw_suspend_noirq,
 };
 
 static struct platform_driver dw_driver = {
-- 
1.7.8.110.g4cb5d
