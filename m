From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 2/7] mmc: mvsdio: fix deferred probe from __init
Date: Mon, 23 Sep 2013 16:27:27 +0200
Message-ID: <1379946452-25649-3-git-send-email-jhovold@gmail.com>
References: <20130923134028.GF21013@sirena.org.uk>
 <1379946452-25649-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379946452-25649-1-git-send-email-jhovold@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@linaro.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pcmcia@lists.infradead.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, Johan Hovold <jhovold@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Move probe out of __init section and don't use platform_driver_probe
which cannot be used with deferred probing.

Since commit e9354576 ("gpiolib: Defer failed gpio requests by default")
this driver might return -EPROBE_DEFER if the mmc_gpio_request_cd fails.

Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/mmc/host/mvsdio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 06c5b0b..deecee0 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -655,7 +655,7 @@ static const struct mmc_host_ops mvsd_ops = {
 	.enable_sdio_irq	= mvsd_enable_sdio_irq,
 };
 
-static void __init
+static void
 mv_conf_mbus_windows(struct mvsd_host *host,
 		     const struct mbus_dram_target_info *dram)
 {
@@ -677,7 +677,7 @@ mv_conf_mbus_windows(struct mvsd_host *host,
 	}
 }
 
-static int __init mvsd_probe(struct platform_device *pdev)
+static int mvsd_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mmc_host *mmc = NULL;
@@ -819,7 +819,7 @@ out:
 	return ret;
 }
 
-static int __exit mvsd_remove(struct platform_device *pdev)
+static int mvsd_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 
@@ -872,7 +872,8 @@ static const struct of_device_id mvsdio_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, mvsdio_dt_ids);
 
 static struct platform_driver mvsd_driver = {
-	.remove		= __exit_p(mvsd_remove),
+	.probe		= mvsd_probe,
+	.remove		= mvsd_remove,
 	.suspend	= mvsd_suspend,
 	.resume		= mvsd_resume,
 	.driver		= {
@@ -881,7 +882,7 @@ static struct platform_driver mvsd_driver = {
 	},
 };
 
-module_platform_driver_probe(mvsd_driver, mvsd_probe);
+module_platform_driver(mvsd_driver);
 
 /* maximum card clock frequency (default 50MHz) */
 module_param(maxfreq, int, 0);
-- 
1.8.3.2
