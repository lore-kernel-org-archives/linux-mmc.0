From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] mmc: omap_hsmmc: fix typo around pr_info() call
Date: Thu,  3 Nov 2011 12:24:42 +0100
Message-ID: <1320319482-9809-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This was introduced by a3c76eb9 ("mmc: replace printk with appropriate
display macro").

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e8ff123..101cd31 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 		}
 	} else {
 		if (!host->protect_card) {
-			pr_info"%s: cover is open, "
+			pr_info("%s: cover is open, "
 					 "card is now inaccessible\n",
 					 mmc_hostname(host->mmc));
 			host->protect_card = 1;
-- 
1.7.6.4
