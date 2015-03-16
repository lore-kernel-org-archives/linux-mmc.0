From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 33/35 linux-next] mmc: constify of_device_id array
Date: Mon, 16 Mar 2015 20:59:07 +0100
Message-ID: <1426535949-26107-2-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535949-26107-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426535949-26107-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Prisk <linux@prisktech.co.nz>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/mmc/host/mmc_spi.c   | 2 +-
 drivers/mmc/host/wmt-sdmmc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index e4a0754..ae19d83 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1507,7 +1507,7 @@ static int mmc_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
-static struct of_device_id mmc_spi_of_match_table[] = {
+static const struct of_device_id mmc_spi_of_match_table[] = {
 	{ .compatible = "mmc-spi-slot", },
 	{},
 };
diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index dd2e1aa..5af0055 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -744,7 +744,7 @@ static struct wmt_mci_caps wm8505_caps = {
 	.max_blk_size = 2048,
 };
 
-static struct of_device_id wmt_mci_dt_ids[] = {
+static const struct of_device_id wmt_mci_dt_ids[] = {
 	{ .compatible = "wm,wm8505-sdhc", .data = &wm8505_caps },
 	{ /* Sentinel */ },
 };
-- 
2.1.0
