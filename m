From: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: [PATCH] mmc: esdhi: Add SDHCI_QUIRK_QORIQ_CIRCUIT_SUPPORT_VS33 quirk
 support
Date: Thu, 22 Nov 2012 16:14:44 +0800
Message-ID: <1353572084-3196-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: linux-mmc@vger.kernel.org
Cc: kumar.gala@freescale.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: linux-mmc@vger.kernel.org

On the some platforms of Freescale, sdhci controller can only
support 1.8V voltage, but the peripheral hardware circuit has
capability to support 3.3V voltage.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 drivers/mmc/host/sdhci.c  |    3 +++
 include/linux/mmc/sdhci.h |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4fe2de8..e4a537d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2682,6 +2682,9 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->caps1 :
 			sdhci_readl(host, SDHCI_CAPABILITIES_1);
 
+	if (host->quirks & SDHCI_QUIRK_QORIQ_CIRCUIT_SUPPORT_VS33)
+		caps[0] = caps[0] | SDHCI_CAN_VDD_330;
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1edcb4d..78eced5 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -87,6 +87,10 @@ struct sdhci_host {
 #define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC		(1<<30)
 /* The read-only detection via SDHCI_PRESENT_STATE register is unstable */
 #define SDHCI_QUIRK_UNSTABLE_RO_DETECT			(1<<31)
+/* Controller can only supports 1.8V, but the peripheral hardware
+ * circuit has capability to support 3.3V
+ */
+#define SDHCI_QUIRK_QORIQ_CIRCUIT_SUPPORT_VS33		(1U<<32)
 
 	unsigned int quirks2;	/* More deviations from spec. */
 
-- 
1.7.6.5
