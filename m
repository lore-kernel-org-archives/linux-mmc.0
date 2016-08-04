From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] mmc: core: need retune if error value is -EIO
Date: Thu,  4 Aug 2016 16:30:59 +0800
Message-ID: <1470299459-8478-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

We need to do retune if receiving -EIO, otherwise we
could see debug dump like:

[ 89.057226] bcmsdh_sdmmc: Failed to Read byte F1:@0x1001f=ff, Err: -5
[ 89.058811] bcmsdh_sdmmc: Failed to Read byte F1:@0x1001f=ff, Err: -5
[ 89.059415] bcmsdh_sdmmc: Failed to Read byte F1:@0x1000e=ff, Err: -84
[ 89.254248] dwmmc_rockchip fe310000.dwmmc: Successfully tuned phase to 199
[ 89.273912] dhd_set_suspend: Remove extra suspend setting
[ 89.274478] dhd_enable_packet_filter: enter, value = 0
64 bytes from 112.90.83.112: icmp_seq=24 ttl=53 time=1321 ms
64 bytes from 112.90.83.112: icmp_seq=25 ttl=53 time=319 ms
64 bytes from 112.90.83.112: icmp_seq=26 ttl=53 time=69.8 ms
64 bytes from 112.90.83.112: icmp_seq=27 ttl=53 time=37.5 ms
...

In this case we see dw_mmc finally enter retune process, but
if this patch is applied, we could save more time to make it
work. Also many host drivers will generate -EIO, so this patch
can also prevent them from failing to enter retune process.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/mmc/core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e55cde6..18d0af5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -133,7 +133,8 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	/* Flag re-tuning needed on CRC errors */
 	if ((cmd->opcode != MMC_SEND_TUNING_BLOCK &&
 	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
-	    (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
+	    (err == -EILSEQ || err == -EIO ||
+	    (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
 	    (mrq->data && mrq->data->error == -EILSEQ) ||
 	    (mrq->stop && mrq->stop->error == -EILSEQ)))
 		mmc_retune_needed(host);
-- 
2.3.7
