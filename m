From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 2/2] mmc: sdhci-of-at91: use SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST quirk
Date: Thu, 17 Sep 2015 10:16:20 +0200
Message-ID: <1442477780-30994-2-git-send-email-ludovic.desroches@atmel.com>
References: <1442477780-30994-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442477780-30994-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

The Atmel sdhci device needs the
SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST quirk. Without it, the
internal clock could never stabilised when changing the sd clock
frequency.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index d155664..a0f05de 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -43,6 +43,7 @@ static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
 
 static const struct sdhci_pltfm_data soc_data_sama5d2 = {
 	.ops = &sdhci_at91_sama5d2_ops,
+	.quirks2 = SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST,
 };
 
 static const struct of_device_id sdhci_at91_dt_match[] = {
-- 
2.5.0
