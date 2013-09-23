From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/7] mtd: atmel_nand: fix deferred probe from __init
Date: Mon, 23 Sep 2013 16:27:28 +0200
Message-ID: <1379946452-25649-4-git-send-email-jhovold@gmail.com>
References: <20130923134028.GF21013@sirena.org.uk>
 <1379946452-25649-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379946452-25649-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pcmcia-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Josh Wu <josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Move probe out of __init section and don't use platform_driver_probe
which cannot be used with deferred probing.

Since commit e9354576 ("gpiolib: Defer failed gpio requests by default")
this driver might return -EPROBE_DEFER if a gpio_request fails.

Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Josh Wu <josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/nand/atmel_nand.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 060feea..bd1ce7d 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1139,7 +1139,7 @@ static int pmecc_choose_ecc(struct atmel_nand_host *host,
 	return 0;
 }
 
-static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
+static int atmel_pmecc_nand_init_params(struct platform_device *pdev,
 					 struct atmel_nand_host *host)
 {
 	struct mtd_info *mtd = &host->mtd;
@@ -1548,7 +1548,7 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 }
 #endif
 
-static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
+static int atmel_hw_nand_init_params(struct platform_device *pdev,
 					 struct atmel_nand_host *host)
 {
 	struct mtd_info *mtd = &host->mtd;
@@ -1987,7 +1987,7 @@ static struct platform_driver atmel_nand_nfc_driver;
 /*
  * Probe for the NAND device.
  */
-static int __init atmel_nand_probe(struct platform_device *pdev)
+static int atmel_nand_probe(struct platform_device *pdev)
 {
 	struct atmel_nand_host *host;
 	struct mtd_info *mtd;
@@ -2184,7 +2184,7 @@ err_nand_ioremap:
 /*
  * Remove a NAND device.
  */
-static int __exit atmel_nand_remove(struct platform_device *pdev)
+static int atmel_nand_remove(struct platform_device *pdev)
 {
 	struct atmel_nand_host *host = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = &host->mtd;
@@ -2270,7 +2270,8 @@ static struct platform_driver atmel_nand_nfc_driver = {
 };
 
 static struct platform_driver atmel_nand_driver = {
-	.remove		= __exit_p(atmel_nand_remove),
+	.probe		= atmel_nand_probe,
+	.remove		= atmel_nand_remove,
 	.driver		= {
 		.name	= "atmel_nand",
 		.owner	= THIS_MODULE,
@@ -2278,7 +2279,7 @@ static struct platform_driver atmel_nand_driver = {
 	},
 };
 
-module_platform_driver_probe(atmel_nand_driver, atmel_nand_probe);
+module_platform_driver(atmel_nand_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Rick Bronson");
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
