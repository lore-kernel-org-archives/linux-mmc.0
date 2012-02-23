From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/6] mmc: omap_hsmmc: Use OMAP_HSMMC_SUPPORTS_DUAL_VOLT
	flag to remove host->id based hardcoding
Date: Thu, 23 Feb 2012 16:56:46 +0530
Message-ID: <1329996409-26861-4-git-send-email-rnayak@ti.com>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1329996409-26861-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>

Use OMAP_HSMMC_SUPPORTS_DUAL_VOLT flag instead of host->id
for identifying SD bus voltage capabilities.

Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Tested-by: Venkatraman S <svenkatr-l0cyMroinI0@public.gmane.org>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9955aee..91faf42 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -650,7 +650,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
 			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
 
-	if (host->id == OMAP_MMC1_DEVID) {
+	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
 		if (host->power_mode != MMC_POWER_OFF &&
 		    (1 << ios->vdd) <= MMC_VDD_23_24)
 			hctl = SDVS18;
-- 
1.7.1
