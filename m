From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/3] mmc: core: expose MMC_CAP2_NO_* to dt
Date: Fri,  1 Jul 2016 15:45:29 +0800
Message-ID: <1467359130-11409-3-git-send-email-shawn.lin@rock-chips.com>
References: <1467359130-11409-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467359130-11409-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

The reason for why we expose these to dt is that
most of the controllers could support all card typs including
sd, sdio and MMC card, but for the specific boards, (e)MMC or
sdio are non-removable devices, so it's impossible that these slot
will be used for other card types. Also for a certain SD slot, it
seems reasonable that we couldn't solder MMC devices or SDIO
devices. So let's expose these caps to dt for the specific boards
to imporve the behaviour of initialization.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/host.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d7e86f9..98f25ff 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -315,6 +315,12 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
 	if (of_property_read_bool(np, "mmc-hs400-enhanced-strobe"))
 		host->caps2 |= MMC_CAP2_HS400_ES;
+	if (of_property_read_bool(np, "no-sdio"))
+		host->caps2 |= MMC_CAP2_NO_SDIO;
+	if (of_property_read_bool(np, "no-sd"))
+		host->caps2 |= MMC_CAP2_NO_SD;
+	if (of_property_read_bool(np, "no-mmc"))
+		host->caps2 |= MMC_CAP2_NO_MMC;
 
 	host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
-- 
2.3.7
