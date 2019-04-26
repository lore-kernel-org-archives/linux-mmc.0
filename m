From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 3/5] mmc: mmci: fix clear of busy detect status
Date: Fri, 26 Apr 2019 09:46:36 +0200
Message-ID: <1556264798-18540-4-git-send-email-ludovic.Barre@st.com>
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org, Ludovic Barre <ludovic.barre@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

The "busy_detect_flag" is used to read/clear busy value of
mmci status. The "busy_detect_mask" is used to manage busy irq of
mmci mask.
For sdmmc variant, the 2 properties have not the same offset.
To clear the busyd0 status bit, we must add busy detect flag,
the mmci mask is not enough.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index a040f54..3cd52e8 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1517,7 +1517,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		 * to make sure that both start and end interrupts are always
 		 * cleared one after the other.
 		 */
-		status &= readl(host->base + MMCIMASK0);
+		status &= readl(host->base + MMCIMASK0) |
+			host->variant->busy_detect_flag;
 		if (host->variant->busy_detect)
 			writel(status & ~host->variant->busy_detect_mask,
 			       host->base + MMCICLEAR);
-- 
2.7.4
