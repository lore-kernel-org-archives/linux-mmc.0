From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 6/9] omap: hsmmc: remove unused variable
Date: Wed, 11 Aug 2010 01:12:25 +0300
Message-ID: <1281478348-24833-7-git-send-email-ohad@wizery.com>
References: <1281478348-24833-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1281478348-24833-1-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Kalle Valo <kalle.valo@iki.fi>, Ohad Ben-Cohen <ohad@wizery.com>, Pandita Vikram <vikram.pandita@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Roger Quadros <roger.quadros@nokia.com>, San Mehat <san@google.com>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Make this go away:

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend':
drivers/mmc/host/omap_hsmmc.c:2328: warning: unused variable 'state'

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b032828..d50e917 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2272,7 +2272,6 @@ static int omap_hsmmc_suspend(struct device *dev)
 	int ret = 0;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
-	pm_message_t state = PMSG_SUSPEND; /* unused by MMC core */
 
 	if (host && host->suspended)
 		return 0;
-- 
1.7.0.4
