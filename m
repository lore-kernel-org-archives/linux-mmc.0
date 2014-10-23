From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] mmc: silence a shift wrapping warning
Date: Thu, 23 Oct 2014 14:37:00 +0300
Message-ID: <20141023113700.GB13250@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Aaron Lu <aaron.lu@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Presumably ->slotno is normally fairly small and the shift doesn't wrap
but static checkers will complain about it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 6da97b1..9a98cc7 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -295,7 +295,7 @@ struct sdio_func *sdio_alloc_func(struct mmc_card *card)
 static void sdio_acpi_set_handle(struct sdio_func *func)
 {
 	struct mmc_host *host = func->card->host;
-	u64 addr = (host->slotno << 16) | func->num;
+	u64 addr = ((u64)host->slotno << 16) | func->num;
 
 	acpi_preset_companion(&func->dev, ACPI_COMPANION(host->parent), addr);
 }
