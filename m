From: Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 2/4] mmc: sdhci: do not set AUTO_CMD12 for multi-block CMD53
Date: Mon, 9 Feb 2015 16:06:29 -0800
Message-ID: <1423526791-29453-3-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1423526791-29453-1-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1423526791-29453-1-git-send-email-sbranden@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcm-kernel-feedback-list@broadcom.com, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, Scott Branden <sbranden@broadcom.com>, Corneliu Doban <cdoban@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Richardson <jonathar@broadcom.com>, Anatol Pomazao <anatol@google.com>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dtor@google.com>
List-Id: linux-mmc@vger.kernel.org

From: Corneliu Doban <cdoban@broadcom.com>

For CMD53 in block mode, the host does not need to stop the transfer,
as it stops when the block count (present in CMD53) is reached.

Signed-off-by: Corneliu Doban <cdoban@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/mmc/host/sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fcf78ab..f35d413 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -28,6 +28,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/sdio.h>
 #include <linux/mmc/slot-gpio.h>
 
 #include "sdhci.h"
@@ -934,7 +935,8 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 		 * If we are sending CMD23, CMD12 never gets sent
 		 * on successful completion (so no Auto-CMD12).
 		 */
-		if (!host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD12))
+		if (!host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD12) &&
+		    (cmd->opcode != SD_IO_RW_EXTENDED))
 			mode |= SDHCI_TRNS_AUTO_CMD12;
 		else if (host->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
 			mode |= SDHCI_TRNS_AUTO_CMD23;
-- 
2.2.2
