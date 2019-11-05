From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 2/3] mmc: host: Compress 'fixed-emmc-driver-type' handling
Date: Tue, 5 Nov 2019 06:50:14 +0100
Message-ID: <20191105055015.23656-2-erosca@de.adit-jv.com>
References: <20191105055015.23656-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105055015.23656-1-erosca@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Mathieu Malaterre <malat@debian.org>, Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Prepare for reading two additional OF properties (inspired from
"fixed-emmc-driver-type"):
 - fixed-emmc-driver-type-hs200
 - fixed-emmc-driver-type-hs400

The parsing mechanism is common too all three, thus factored out.
The only functional change is a tiny update in the error message.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 drivers/mmc/core/host.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 105b7a7c0251..54abfdfc69ba 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -161,6 +161,20 @@ static void mmc_retune_timer(struct timer_list *t)
 	mmc_retune_needed(host);
 }
 
+static void mmc_of_read_drv_type(struct mmc_host *host, char *prop, u32 *val)
+{
+	struct device *dev = host->parent;
+	u32 drv_type;
+
+	if (device_property_read_u32(dev, prop, &drv_type))
+		return;
+
+	if (host->caps & MMC_CAP_NONREMOVABLE)
+		*val = drv_type;
+	else
+		dev_err(dev, "can't use %s, media is removable\n", prop);
+}
+
 /**
  *	mmc_of_parse() - parse host's device-tree node
  *	@host: host whose node should be parsed.
@@ -173,7 +187,7 @@ static void mmc_retune_timer(struct timer_list *t)
 int mmc_of_parse(struct mmc_host *host)
 {
 	struct device *dev = host->parent;
-	u32 bus_width, drv_type, cd_debounce_delay_ms;
+	u32 bus_width, cd_debounce_delay_ms;
 	int ret;
 	bool cd_cap_invert, cd_gpio_invert = false;
 	bool ro_cap_invert, ro_gpio_invert = false;
@@ -321,13 +335,7 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_NO_MMC;
 
 	/* Must be after "non-removable" check */
-	if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
-		if (host->caps & MMC_CAP_NONREMOVABLE)
-			host->fixed_drv_type = drv_type;
-		else
-			dev_err(host->parent,
-				"can't use fixed driver type, media is removable\n");
-	}
+	mmc_of_read_drv_type(host, "fixed-emmc-driver-type", &host->fixed_drv_type);
 
 	host->dsr_req = !device_property_read_u32(dev, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
-- 
2.23.0
