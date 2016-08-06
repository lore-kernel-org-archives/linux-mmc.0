From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 2/3] mmc: core: add new cap for 3.3V only DDR MMCs
Date: Sat,  6 Aug 2016 12:55:39 +0000
Message-ID: <1470488140-10104-3-git-send-email-stefan.wahren@i2se.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <fabio.estevam@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Marek Vasut <marex@denx.de>, Otavio Salvador <otavio@ossystems.com.br>, devicetree@vger.kernel.org, Holger Schurig <holgerschurig@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>, linux-mmc@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This patch based on the work of Fabio Estevam:
"[PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
'no-1-8-v' is present"

It adds the support for 3.3V only DDR MMC hosts.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/core/host.c  |    2 ++
 drivers/mmc/core/mmc.c   |    6 ++++++
 include/linux/mmc/host.h |    1 +
 3 files changed, 9 insertions(+)

Changes to Fabio's patch:
- rebase to current linux-next
- rename DT property to mmc-ddr-3_3v
- use EXT_CSD_CARD_TYPE_DDR_52 instead of new define

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 98f25ff..4c971de 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -301,6 +301,8 @@ int mmc_of_parse(struct mmc_host *host)
 	if (of_property_read_bool(np, "wakeup-source") ||
 	    of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	if (of_property_read_bool(np, "mmc-ddr-3_3v"))
+		host->caps2 |= MMC_CAP2_3_3V_ONLY_DDR;
 	if (of_property_read_bool(np, "mmc-ddr-1_8v"))
 		host->caps |= MMC_CAP_1_8V_DDR;
 	if (of_property_read_bool(np, "mmc-ddr-1_2v"))
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f2d185c..8a933d5 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -210,6 +210,12 @@ static void mmc_select_card_type(struct mmc_card *card)
 		avail_type |= EXT_CSD_CARD_TYPE_HS_52;
 	}
 
+	if (caps2 & MMC_CAP2_3_3V_ONLY_DDR &&
+	    card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
+		hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
+		avail_type |= EXT_CSD_CARD_TYPE_DDR_52;
+	}
+
 	if (caps & MMC_CAP_1_8V_DDR &&
 	    card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
 		hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index aa4bfbf..db0775d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -311,6 +311,7 @@ struct mmc_host {
 #define MMC_CAP2_HS400_ES	(1 << 20)	/* Host supports enhanced strobe */
 #define MMC_CAP2_NO_SD		(1 << 21)	/* Do not send SD commands during initialization */
 #define MMC_CAP2_NO_MMC		(1 << 22)	/* Do not send (e)MMC commands during initialization */
+#define MMC_CAP2_3_3V_ONLY_DDR	(1 << 23)	/* Only supports 3.3V DDR */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
1.7.9.5
