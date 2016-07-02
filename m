From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/2] mmc: sdhci-iproc: Use defines instead of magic numbers
Date: Sat,  2 Jul 2016 19:23:14 +0000
Message-ID: <1467487394-28682-3-git-send-email-stefan.wahren@i2se.com>
References: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The capabilities in iproc platform data are magic numbers. So
replace them with the proper capability defines to make it
readable.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/sdhci-iproc.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 1110f73..53abecc 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -164,8 +164,17 @@ static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
 
 static const struct sdhci_iproc_data iproc_data = {
 	.pdata = &sdhci_iproc_pltfm_data,
-	.caps = 0x05E90000,
-	.caps1 = 0x00000064,
+	.caps = ((0x1 << SDHCI_MAX_BLOCK_SHIFT)
+			& SDHCI_MAX_BLOCK_MASK) |
+		SDHCI_CAN_VDD_330 |
+		SDHCI_CAN_VDD_180 |
+		SDHCI_CAN_DO_SUSPEND |
+		SDHCI_CAN_DO_HISPD |
+		SDHCI_CAN_DO_ADMA2 |
+		SDHCI_CAN_DO_SDMA,
+	.caps1 = SDHCI_DRIVER_TYPE_C |
+		 SDHCI_DRIVER_TYPE_D |
+		 SDHCI_SUPPORT_DDR50,
 	.mmc_caps = MMC_CAP_1_8V_DDR,
 };
 
-- 
1.7.9.5
