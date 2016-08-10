From: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] mmc: mediatek: Fix CMD6 timeout issue
Date: Wed, 10 Aug 2016 19:59:38 +0800
Message-ID: <1470830378-12155-1-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Minghsiu Tsai <Minghsiu.Tsai-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

When init EMMC, after switch to HS400, will issue
CMD6 to change ext_csd, if first CMD6 got CRC
error, the repeat CMD6 may get timeout, that's
because SDCBSY was cleared by msdc_reset_hw()

In this case, need check MSDC_PS to wait EMMC
changes to transfer state

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Yong Mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/mmc/host/mtk-sd.c | 78 +++++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 84e9afc..d52563d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -826,6 +826,15 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 	return true;
 }
 
+static int msdc_card_busy(struct mmc_host *mmc)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	u32 status = readl(host->base + MSDC_PS);
+
+	/* check if data0 is low */
+	return !(status & BIT(16));
+}
+
 /* It is the core layer's responsibility to ensure card status
  * is correct before issue a request. but host design do below
  * checks recommended.
@@ -835,10 +844,20 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 {
 	/* The max busy time we can endure is 20ms */
 	unsigned long tmo = jiffies + msecs_to_jiffies(20);
+	u32 count = 0;
+
+	if (in_interrupt()) {
+		while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
+		       (count < 1000)) {
+			udelay(1);
+			count++;
+		}
+	} else {
+		while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
+		       time_before(jiffies, tmo))
+			cpu_relax();
+	}
 
-	while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) &&
-			time_before(jiffies, tmo))
-		cpu_relax();
 	if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
 		dev_err(host->dev, "CMD bus busy detected\n");
 		host->error |= REQ_CMD_BUSY;
@@ -846,17 +865,36 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
 		return false;
 	}
 
-	if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
-		tmo = jiffies + msecs_to_jiffies(20);
-		/* R1B or with data, should check SDCBUSY */
-		while ((readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) &&
-				time_before(jiffies, tmo))
-			cpu_relax();
-		if (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY) {
-			dev_err(host->dev, "Controller busy detected\n");
-			host->error |= REQ_CMD_BUSY;
-			msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
-			return false;
+	if (cmd->opcode != MMC_SEND_STATUS) {
+		count = 0;
+		/* Consider that CMD6 crc error before card was init done,
+		 * mmc_retune() will return directly as host->card is null.
+		 * and CMD6 will retry 3 times, must ensure card is in transfer
+		 * state when retry.
+		 */
+		tmo = jiffies + msecs_to_jiffies(60 * 1000);
+		while (1) {
+			if (msdc_card_busy(host->mmc)) {
+				if (in_interrupt()) {
+					udelay(1);
+					count++;
+				} else {
+					msleep_interruptible(10);
+				}
+			} else {
+				break;
+			}
+			/* Timeout if the device never
+			 * leaves the program state.
+			 */
+			if (count > 1000 || time_after(jiffies, tmo)) {
+				pr_err("%s: Card stuck in
+					 programming state! %s\n",
+				       mmc_hostname(host->mmc), __func__);
+				host->error |= REQ_CMD_BUSY;
+				msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
+				return false;
+			}
 		}
 	}
 	return true;
@@ -1070,18 +1108,6 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
-static int msdc_card_busy(struct mmc_host *mmc)
-{
-	struct msdc_host *host = mmc_priv(mmc);
-	u32 status = readl(host->base + MSDC_PS);
-
-	/* check if any pin between dat[0:3] is low */
-	if (((status >> 16) & 0xf) != 0xf)
-		return 1;
-
-	return 0;
-}
-
 static void msdc_request_timeout(struct work_struct *work)
 {
 	struct msdc_host *host = container_of(work, struct msdc_host,
-- 
1.8.1.1.dirty
