From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.4.y 11/25] mmc: core: fix using wrong io voltage if mmc_select_hs200 fails
Date: Fri, 22 Mar 2019 16:44:02 +0100
Message-ID: <20190322154425.3852517-12-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, hongjiefang <hongjiefang@asrmicro.com>, Simon Horman <horms+renesas@verge.net.au>, Kyle Roeschley <kyle.roeschley@ni.com>, Jennifer Dahm <jennifer.dahm@ni.com>, Yinbo Zhu <yinbo.zhu@nxp.com>, Avri Altman <avri.altman@wdc.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Arnd Bergmann <arnd@arndb.de>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Currently MMC core will keep going if HS200/HS timing switch failed
with -EBADMSG error by the assumption that the old timing is still valid.

However, for mmc_select_hs200 case, the signal voltage may have already
been switched. If the timing switch failed, we should fall back to
the old voltage in case the card is continue run with legacy timing.

If fall back signal voltage failed, we explicitly report an EIO error
to force retry during the next power cycle.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit e51534c806609c806d81bfb034f02737461f855c)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/mmc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7286d0d324e1..7844baecf306 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1251,10 +1251,11 @@ static int mmc_select_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	bool send_status = true;
-	unsigned int old_timing;
+	unsigned int old_timing, old_signal_voltage;
 	int err = -EINVAL;
 	u8 val;
 
+	old_signal_voltage = host->ios.signal_voltage;
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)
 		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
@@ -1263,7 +1264,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 	/* If fails try again during next card power cycle */
 	if (err)
-		goto err;
+		return err;
 
 	mmc_select_driver_type(card);
 
@@ -1297,9 +1298,14 @@ static int mmc_select_hs200(struct mmc_card *card)
 		}
 	}
 err:
-	if (err)
+	if (err) {
+		/* fall back to the old signal voltage, if fails report error */
+		if (__mmc_set_signal_voltage(host, old_signal_voltage))
+			err = -EIO;
+
 		pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
 		       __func__, err);
+	}
 	return err;
 }
 
-- 
2.20.0
