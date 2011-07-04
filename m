From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH V3] MMC: PM: add suspend/resume in atmel-mci
Date: Mon,  4 Jul 2011 13:38:25 +0200
Message-ID: <1309779505-25509-1-git-send-email-nicolas.ferre@atmel.com>
References: <1309530754.4373.3.camel@hcegtvedt.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1309530754.4373.3.camel@hcegtvedt.norway.atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org, hans-christian.egtvedt@atmel.com
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, kernel@avr32linux.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

Take care of slots while going to suspend state.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
V3: take care of each slot SUSPENDED state
    (adding a status bit in the slot "flags")
V2: move to pm_ops

 drivers/mmc/host/atmel-mci.c |   60 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index aa8039f..ed63bcd 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -203,6 +203,7 @@ struct atmel_mci_slot {
 #define ATMCI_CARD_PRESENT	0
 #define ATMCI_CARD_NEED_INIT	1
 #define ATMCI_SHUTDOWN		2
+#define ATMCI_SUSPENDED		3
 
 	int			detect_pin;
 	int			wp_pin;
@@ -1878,10 +1879,69 @@ static int __exit atmci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int atmci_suspend(struct device *dev)
+{
+	struct atmel_mci *host = dev_get_drvdata(dev);
+	int i;
+
+	 for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+		struct atmel_mci_slot *slot = host->slot[i];
+		int ret;
+
+		if (!slot)
+			continue;
+		ret = mmc_suspend_host(slot->mmc);
+		if (ret < 0) {
+			while (--i >= 0) {
+				slot = host->slot[i];
+				if (slot
+				&& test_bit(ATMCI_SUSPENDED, &slot->flags)) {
+					mmc_resume_host(host->slot[i]->mmc);
+					clear_bit(ATMCI_SUSPENDED, &slot->flags);
+				}
+			}
+			return ret;
+		} else {
+			set_bit(ATMCI_SUSPENDED, &slot->flags);
+		}
+	}
+
+	return 0;
+}
+
+static int atmci_resume(struct device *dev)
+{
+	struct atmel_mci *host = dev_get_drvdata(dev);
+	int i;
+	int ret = 0;
+
+	for (i = 0; i < ATMEL_MCI_MAX_NR_SLOTS; i++) {
+		struct atmel_mci_slot *slot = host->slot[i];
+		int err;
+
+		slot = host->slot[i];
+		if (!slot)
+			continue;
+		if (!test_bit(ATMCI_SUSPENDED, &slot->flags))
+			continue;
+		err = mmc_resume_host(slot->mmc);
+		if (err < 0)
+			ret = err;
+		else
+			clear_bit(ATMCI_SUSPENDED, &slot->flags);
+	}
+
+	return ret;
+}
+#endif
+static SIMPLE_DEV_PM_OPS(atmci_pm, atmci_suspend, atmci_resume);
+
 static struct platform_driver atmci_driver = {
 	.remove		= __exit_p(atmci_remove),
 	.driver		= {
 		.name		= "atmel_mci",
+		.pm		= &atmci_pm,
 	},
 };
 
-- 
1.7.3
