From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/9] mmc: sdio: Convert to dev_pm_domain_attach|detach()
Date: Tue, 26 Aug 2014 14:07:14 +0200
Message-ID: <1409054837-5667-7-git-send-email-ulf.hansson@linaro.org>
References: <1409054837-5667-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1409054837-5667-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Previously only the ACPI power domain was supported by the i2c bus.

Let's convert to the common attach/detach functions for power domains,
which currently means we are extending the support to include the
generic power domain as well.

Cc: linux-mmc@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 4fa8fef9..1df0fc6 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -315,7 +315,7 @@ int sdio_add_func(struct sdio_func *func)
 	ret = device_add(&func->dev);
 	if (ret == 0) {
 		sdio_func_set_present(func);
-		acpi_dev_pm_attach(&func->dev, false);
+		dev_pm_domain_attach(&func->dev, false);
 	}
 
 	return ret;
@@ -332,7 +332,7 @@ void sdio_remove_func(struct sdio_func *func)
 	if (!sdio_func_present(func))
 		return;
 
-	acpi_dev_pm_detach(&func->dev, false);
+	dev_pm_domain_detach(&func->dev, false);
 	device_del(&func->dev);
 	put_device(&func->dev);
 }
-- 
1.9.1

