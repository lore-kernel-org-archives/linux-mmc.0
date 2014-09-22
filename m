From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 4/8] mmc: sdhci: do not enable card detect interrupt for
 gpio cd type
Date: Mon, 22 Sep 2014 17:12:07 +0800
Message-ID: <1411377131-19741-5-git-send-email-b29396@freescale.com>
References: <1411377131-19741-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411377131-19741-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.guo@linaro.org, b29396@freescale.com, chris@printf.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Except SDHCI_QUIRK_BROKEN_CARD_DETECTION and MMC_CAP_NONREMOVABLE,
we also do not need to handle controller native card detect interrupt
for gpio as card detect case.
If we wrong enabled the card detect interrupt for gpio case,
it will cause a lot of unexpected card detect interrupts during data transfer
which should not happen.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7481bd8..85cbf45 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -136,9 +136,10 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
 	u32 present;
+	int gpio_cd = mmc_gpio_get_cd(host->mmc);
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
-	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
+	    (host->mmc->caps & MMC_CAP_NONREMOVABLE) || !IS_ERR_VALUE(gpio_cd))
 		return;
 
 	if (enable) {
-- 
1.7.8
