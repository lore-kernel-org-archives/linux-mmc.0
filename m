From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH v2 1/2] pxamci: remove the ifdef CONFIG_REGULATOR
Date: Wed, 11 May 2011 12:19:05 +0200
Message-ID: <1305109145-16567-1-git-send-email-ospite@studenti.unina.it>
References: <20110510203629.GB8726@opensource.wolfsonmicro.com>
Return-path: <openezx-devel-bounces@lists.openezx.org>
In-Reply-To: <20110510203629.GB8726@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.openezx.org/mailman/options/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=unsubscribe>
List-Archive: <http://lists.openezx.org/pipermail/openezx-devel>
List-Post: <mailto:openezx-devel@lists.openezx.org>
List-Help: <mailto:openezx-devel-request@lists.openezx.org?subject=help>
List-Subscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=subscribe>
Sender: openezx-devel-bounces@lists.openezx.org
Errors-To: openezx-devel-bounces@lists.openezx.org
To: linux-mmc@vger.kernel.org
Cc: openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, Antonio Ospite <ospite@studenti.unina.it>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

Don't wrap regulator_get() inside an ifdef CONFIG_REGULATOR anymore, as
now it degenerates and returns NULL when the regulator framework is
disabled (since commit be1a50d: regulator: Let drivers know when they
use the stub API); and use IS_ERR_OR_NULL() to handle the stub function 
correctly.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Changes since v1:
  - Use IS_ERR_OR_NULL() to correctly handle the stub regulator_get()
  - Put the short commit message of be1a50d so it is easier to see what it is 
    about, for the long commit and the actual code changes the git history can 
    be queried.

Thanks,
   Antonio Ospite
   http://ao2.it

 drivers/mmc/host/pxamci.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 7257738..3a89fb2 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -79,10 +79,9 @@ struct pxamci_host {
 
 static inline void pxamci_init_ocr(struct pxamci_host *host)
 {
-#ifdef CONFIG_REGULATOR
 	host->vcc = regulator_get(mmc_dev(host->mmc), "vmmc");
 
-	if (IS_ERR(host->vcc))
+	if (IS_ERR_OR_NULL(host->vcc))
 		host->vcc = NULL;
 	else {
 		host->mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vcc);
@@ -90,7 +89,7 @@ static inline void pxamci_init_ocr(struct pxamci_host *host)
 			dev_warn(mmc_dev(host->mmc),
 				"ocr_mask/setpower will not be used\n");
 	}
-#endif
+
 	if (host->vcc == NULL) {
 		/* fall-back to platform data */
 		host->mmc->ocr_avail = host->pdata ?
-- 
1.7.5.1
