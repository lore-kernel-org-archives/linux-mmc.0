From: NeilBrown <neilb@suse.de>
Subject: [PATCH 2/3] mmc: core: export functions for setting bus width.
Date: Wed, 28 Jan 2015 10:35:24 +1100
Message-ID: <20150127233524.32160.48364.stgit@notabene.brown>
References: <20150127233118.32160.11899.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150127233118.32160.11899.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

It is not safe for a host to turn off clocks while
expecting an SD card interrupt unless it first places
the bus in 1-bit mode.

To allow hosts to do this, export functions necessary for changing bus
width.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/core/core.c  |    1 +
 drivers/mmc/core/sdio.c  |    8 ++++----
 include/linux/mmc/host.h |    4 ++++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7162ada24a24..418dd8ec36f8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1099,6 +1099,7 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
 	mmc_set_ios(host);
 	mmc_host_clk_release(host);
 }
+EXPORT_SYMBOL(mmc_set_bus_width);
 
 /*
  * Set initial state after a power cycle or a hw_reset.
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index fd0750b5a634..128bbf10ae98 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -257,7 +257,7 @@ static int sdio_disable_cd(struct mmc_card *card)
  * Devices that remain active during a system suspend are
  * put back into 1-bit mode.
  */
-static int sdio_disable_wide(struct mmc_card *card)
+int sdio_disable_wide(struct mmc_card *card)
 {
 	int ret;
 	u8 ctrl;
@@ -286,9 +286,9 @@ static int sdio_disable_wide(struct mmc_card *card)
 
 	return 0;
 }
+EXPORT_SYMBOL(sdio_disable_wide);
 
-
-static int sdio_enable_4bit_bus(struct mmc_card *card)
+int sdio_enable_4bit_bus(struct mmc_card *card)
 {
 	int err;
 
@@ -309,7 +309,7 @@ static int sdio_enable_4bit_bus(struct mmc_card *card)
 
 	return err;
 }
-
+EXPORT_SYMBOL(sdio_enable_4bit_bus);
 
 /*
  * Test if the card supports high-speed mode and, if so, switch to it.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index b6bf718c3498..822a02528c91 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -517,4 +517,8 @@ static inline bool mmc_card_hs400(struct mmc_card *card)
 	return card->host->ios.timing == MMC_TIMING_MMC_HS400;
 }
 
+int sdio_disable_wide(struct mmc_card *card);
+int sdio_enable_4bit_bus(struct mmc_card *card);
+void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
+
 #endif /* LINUX_MMC_HOST_H */
