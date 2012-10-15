From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/2] mmc: mmci: Make use of new DT capability parsing function
Date: Mon, 15 Oct 2012 14:15:59 +0100
Message-ID: <1350306959-5843-2-git-send-email-lee.jones@linaro.org>
References: <1350306959-5843-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350306959-5843-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linus.walleij@stericsson.com, Lee Jones <lee.jones@linaro.org>, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Instead of rolling our own parsers for each new capability we
wish to support, we can make use of a call-once function which
parses all known capability strings and populates the
necessary properties for us. All we have to do is remove our
own cruft and invoke the call.

Cc: Chris Ball <cjb@laptop.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/mmci.c |   20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..bc02f05 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1227,25 +1227,7 @@ static void mmci_dt_populate_generic_pdata(struct device_node *np,
 	if (!pdata->f_max)
 		pr_warn("%s has no 'max-frequency' property\n", np->full_name);
 
-	if (of_get_property(np, "mmc-cap-mmc-highspeed", NULL))
-		pdata->capabilities |= MMC_CAP_MMC_HIGHSPEED;
-	if (of_get_property(np, "mmc-cap-sd-highspeed", NULL))
-		pdata->capabilities |= MMC_CAP_SD_HIGHSPEED;
-
-	of_property_read_u32(np, "bus-width", &bus_width);
-	switch (bus_width) {
-	case 0 :
-		/* No bus-width supplied. */
-		break;
-	case 4 :
-		pdata->capabilities |= MMC_CAP_4_BIT_DATA;
-		break;
-	case 8 :
-		pdata->capabilities |= MMC_CAP_8_BIT_DATA;
-		break;
-	default :
-		pr_warn("%s: Unsupported bus width\n", np->full_name);
-	}
+	mmc_of_populate_caps(np, &pdata->capabilities, &pdata->capabilities2);
 }
 #else
 static void mmci_dt_populate_generic_pdata(struct device_node *np,
-- 
1.7.9.5
