From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 3/4] mmc: mediatek: fix CMD21/CMD19 timeout issue
Date: Thu, 30 Jun 2016 10:01:00 +0800
Message-ID: <1467252061-3791-4-git-send-email-chaotian.jing@mediatek.com>
References: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1467252061-3791-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei-Ning Huang <wnhuang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

we did not deal with the read data of CMD21/CMD19 if there is
response CRC error of CMD21/CMD19, in this case, eMMC/SD may
still in send-data state. therefore, all of next commands cannot
get response as device is not in transfer state.

for resolving this issue, still need deal with the data receive
to make device back to transfer state.

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/mmc/host/mtk-sd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4b175a6..91277b9 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -801,7 +801,13 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 	}
 
 	if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
-		msdc_reset_hw(host);
+		if (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
+		    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
+			/*
+			 * should not clear fifo/interrupt as the tune data
+			 * may have alreay come.
+			 */
+			msdc_reset_hw(host);
 		if (events & MSDC_INT_RSPCRCERR) {
 			cmd->error = -EILSEQ;
 			host->error |= REQ_CMD_EIO;
@@ -885,7 +891,11 @@ static void msdc_start_command(struct msdc_host *host,
 static void msdc_cmd_next(struct msdc_host *host,
 		struct mmc_request *mrq, struct mmc_command *cmd)
 {
-	if (cmd->error || (mrq->sbc && mrq->sbc->error))
+	if ((cmd->error &&
+	    !(cmd->error == -EILSEQ &&
+	      (cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+	       cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200))) ||
+	    (mrq->sbc && mrq->sbc->error))
 		msdc_request_done(host, mrq);
 	else if (cmd == mrq->sbc)
 		msdc_start_command(host, mrq, mrq->cmd);
-- 
1.8.1.1.dirty
