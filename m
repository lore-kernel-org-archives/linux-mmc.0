From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 2/5] mmc: core: add mmc-hs400-enhanced-strobe support
Date: Tue, 10 May 2016 17:09:43 +0800
Message-ID: <1462871383-32443-1-git-send-email-shawn.lin@rock-chips.com>
References: <1462871343-32361-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1462871343-32361-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch introduce mmc-hs400-enhanced-strobe for platforms
which want to enable enhanced strobe function from DT if the
mmc host controller claims to support enhanced strobe.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v3:
- remove helper function and shorten cap2 to MMC_CAP2_HS400_ES
- rename callback to hs400_enhanced_strobe and make it return void
- add enhanced_strobe in mmc_ios and pass it to hs400_enhanced_strobe
- disable host's enhanced strobe in mmc_set_initial_state
- remove bus checking after switching hs400es
- add new function for hs400es timing selection
- fix wrong judgement of mmc_card_hs400es

Changes in v2:
- switch to HS400ES from Highspeed mode directly

 drivers/mmc/core/host.c  | 2 ++
 include/linux/mmc/host.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e0a3ee1..45773e4 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -289,6 +289,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
 	if (of_property_read_bool(np, "mmc-hs400-1_2v"))
 		host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
+	if (of_property_read_bool(np, "mmc-hs400-enhanced-strobe"))
+		host->caps2 |= MMC_CAP2_HS400_ES;
 
 	host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 85800b4..2a06fb0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -302,6 +302,7 @@ struct mmc_host {
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
 #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
 #define MMC_CAP2_NO_SDIO	(1 << 19)	/* Do not send SDIO commands during initialization */
+#define MMC_CAP2_HS400_ES	(1 << 20)	/* Host supports enhanced strobe */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
2.3.7
