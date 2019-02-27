From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 1/3] mmc: dw_mmc: Check busy state in dw_mci_request()
Date: Wed, 27 Feb 2019 11:36:41 +0800
Message-ID: <1551238603-82412-2-git-send-email-shawn.lin@rock-chips.com>
References: <1551238603-82412-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1551238603-82412-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Move it from dw_mci_start_command() to dw_mci_request().
Then dw_mci_wait_while_busy() isn't called with host's
lock hold.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

 drivers/mmc/host/dw_mmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 80dc2fd..703dedf 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -426,7 +426,6 @@ static void dw_mci_start_command(struct dw_mci *host,
 
 	mci_writel(host, CMDARG, cmd->arg);
 	wmb(); /* drain writebuffer */
-	dw_mci_wait_while_busy(host, cmd_flags);
 
 	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
 
@@ -1419,6 +1418,10 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
+	if ((mrq->cmd->opcode != MMC_SEND_STATUS && mrq->cmd->data) &&
+	    !(mrq->cmd->opcode == SD_SWITCH_VOLTAGE))
+		dw_mci_wait_while_busy(host, SDMMC_CMD_PRV_DAT_WAIT);
+
 	spin_lock_bh(&host->lock);
 
 	dw_mci_queue_request(host, slot, mrq);
-- 
1.9.1
