From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 3/4] mmc: core: add cap-no-sd and cap-no-mmc properties
Date: Wed,  8 Jun 2016 16:20:57 +0800
Message-ID: <1465374057-2608-1-git-send-email-shawn.lin@rock-chips.com>
References: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Introduce cap-no-sd and cap-no-mmc properties to skip
sending sd and mmc commands during initialization
respectively.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/host.c  | 4 ++++
 include/linux/mmc/host.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 933eeea..c760097 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -298,6 +298,10 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
 	if (of_property_read_bool(np, "cap-no-sdio"))
 		host->caps2 |= MMC_CAP2_NO_SDIO;
+	if (of_property_read_bool(np, "cap-no-sd"))
+		host->caps2 |= MMC_CAP2_NO_SD;
+	if (of_property_read_bool(np, "cap-no-mmc"))
+		host->caps2 |= MMC_CAP2_NO_MMC;
 	if (of_property_read_bool(np, "keep-power-in-suspend"))
 		host->pm_caps |= MMC_PM_KEEP_POWER;
 	if (of_property_read_bool(np, "wakeup-source") ||
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d72c0c3..1bd77c7 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -309,6 +309,8 @@ struct mmc_host {
 #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)	/* No physical write protect pin, assume that card is always read-write */
 #define MMC_CAP2_NO_SDIO	(1 << 19)	/* Do not send SDIO commands during initialization */
 #define MMC_CAP2_HS400_ES	(1 << 20)	/* Host supports enhanced strobe */
+#define MMC_CAP2_NO_SD		(1 << 21)	/* Do not send SD commands during initialization */
+#define MMC_CAP2_NO_MMC		(1 << 22)	/* Do not send MMC commands during initialization */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
2.3.7
