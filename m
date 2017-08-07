From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 5/5] mmc: sdhci-brcmstb: constify sdhci_pltfm_data structures
Date: Mon,  7 Aug 2017 11:50:44 +0200
Message-ID: <1502099444-10473-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Al Cooper <alcooperx@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The sdhci_pltfm_data structure is only passed as the second argument
of sdhci_pltfm_init, which is const, so the sdhci_pltfm_data structure
can be const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/sdhci-brcmstb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index e2f6383..3a64c13 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -63,7 +63,7 @@ static SIMPLE_DEV_PM_OPS(sdhci_brcmstb_pmops, sdhci_brcmstb_suspend,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-static struct sdhci_pltfm_data sdhci_brcmstb_pdata = {
+static const struct sdhci_pltfm_data sdhci_brcmstb_pdata = {
 	.ops = &sdhci_brcmstb_ops,
 };
 
