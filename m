From: Behan Webster <behanw@converseincode.com>
Subject: [PATCH v3] mmc, sdhci, bcm-kona, LLVMLinux: Remove use of __initconst
Date: Thu, 25 Sep 2014 15:45:22 -0700
Message-ID: <1411685122-21867-1-git-send-email-behanw@converseincode.com>
References: <5774775.2EcFmuR4sV@wuerfel>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5774775.2EcFmuR4sV@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: bcm@fixthebug.org, chris@printf.net, mporter@linaro.org, ulf.hansson@linaro.org
Cc: behanw@converseincode.com, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The __initconst is in the wrong place, and when moved to the correct place
it uncovers an error where the variable is used by non-init data structures.

Instead merely make them const and put the const in the right spot.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Mark Charlebois <charlebm@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Matt Porter <mporter@linaro.org>
---
 drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index dd780c3..d085dfe 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -225,7 +225,7 @@ static struct sdhci_pltfm_data sdhci_pltfm_data_kona = {
 		SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 };
 
-static struct __initconst of_device_id sdhci_bcm_kona_of_match[] = {
+static const struct of_device_id sdhci_bcm_kona_of_match[] = {
 	{ .compatible = "brcm,kona-sdhci"},
 	{ .compatible = "bcm,kona-sdhci"}, /* deprecated name */
 	{}
-- 
1.9.1
