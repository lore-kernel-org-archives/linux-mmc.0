From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 2/5] mmc: sdhci-bcm-kona: constify sdhci_pltfm_data and sdhci_ops structures
Date: Mon,  7 Aug 2017 11:50:41 +0200
Message-ID: <1502099444-10473-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The sdhci_pltfm_data structure is only passed as the second argument
of sdhci_pltfm_init, which is const, while the sdhci_ops structure
is only stored in the ops field of a sdhci_pltfm_data structure,
which is also const.  Thus both kinds of structures can be const as
well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/sdhci-bcm-kona.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 51dd2fd..11ca95c 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -186,7 +186,7 @@ static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
 		udelay(740);
 }
 
-static struct sdhci_ops sdhci_bcm_kona_ops = {
+static const struct sdhci_ops sdhci_bcm_kona_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -197,7 +197,7 @@ static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
 	.card_event = sdhci_bcm_kona_card_event,
 };
 
-static struct sdhci_pltfm_data sdhci_pltfm_data_kona = {
+static const struct sdhci_pltfm_data sdhci_pltfm_data_kona = {
 	.ops    = &sdhci_bcm_kona_ops,
 	.quirks = SDHCI_QUIRK_NO_CARD_NO_RESET |
 		SDHCI_QUIRK_BROKEN_TIMEOUT_VAL | SDHCI_QUIRK_32BIT_DMA_ADDR |
