From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.4.y 07/25] mmc: sanitize 'bus width' in debug output
Date: Fri, 22 Mar 2019 16:43:58 +0100
Message-ID: <20190322154425.3852517-8-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Avri Altman <avri.altman@wdc.com>, Shawn Lin <shawn.lin@rock-chips.com>, Martin Hicks <mort@bork.org>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ritesh Harjani <riteshh@codeaurora.org>, Simon Horman <horms+renesas@verge.net.au>, hongjiefang <hongjiefang@asrmicro.com>, Yinbo Zhu <yinbo.zhu@nxp.com>, Kyle Roeschley <kyle.roeschley@ni.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiong Wu <lohengrin1024@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The bus width is sometimes the actual bus width, and sometimes indices
to different arrays encoding the bus width. In my debugging case "2"
could mean 8-bit as well as 4-bit, which was extremly confusing. Let's
use the human-readable actual bus width in all places.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit ed9feec72fc1fa194ebfdb79e14561b35decce63)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/core.c | 2 +-
 drivers/mmc/core/mmc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 299a83f1ad38..e2e927d1f7e4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1039,7 +1039,7 @@ static inline void mmc_set_ios(struct mmc_host *host)
 		"width %u timing %u\n",
 		 mmc_hostname(host), ios->clock, ios->bus_mode,
 		 ios->power_mode, ios->chip_select, ios->vdd,
-		 ios->bus_width, ios->timing);
+		 1 << ios->bus_width, ios->timing);
 
 	host->ops->set_ios(host, ios);
 }
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index adc3291e9d6a..7286d0d324e1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -952,7 +952,7 @@ static int mmc_select_bus_width(struct mmc_card *card)
 			break;
 		} else {
 			pr_warn("%s: switch to bus width %d failed\n",
-				mmc_hostname(host), ext_csd_bits[idx]);
+				mmc_hostname(host), 1 << bus_width);
 		}
 	}
 
-- 
2.20.0
