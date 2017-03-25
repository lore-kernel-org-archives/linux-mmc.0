From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 3/4] mmc: meson-gx: switch to dynamic timeout values
Date: Sat, 25 Mar 2017 11:26:18 +0100
Message-ID: <eb2341a4-b7f9-a3a4-b616-ff70d9da6538@gmail.com>
References: <aae9e7c7-d8a2-72b1-22f7-f0ad513d4667@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36279 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdCYK2j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Mar 2017 06:28:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so2332893wmf.3
        for <linux-mmc@vger.kernel.org>; Sat, 25 Mar 2017 03:28:38 -0700 (PDT)
In-Reply-To: <aae9e7c7-d8a2-72b1-22f7-f0ad513d4667@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Currently we use a fixed timeout of 4s for all data transfers. Switch
to dynamic timeout values by making use of data->timeout_ns.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- added _msecs suffix to function name
---
 drivers/mmc/host/meson-gx-mmc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 0a0f5008..810b68d5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -163,6 +163,18 @@ struct sd_emmc_desc {
 #define CMD_RESP_MASK GENMASK(31, 1)
 #define CMD_RESP_SRAM BIT(0)
 
+static unsigned int meson_mmc_get_timeout_msecs(struct mmc_data *data)
+{
+	unsigned int timeout = data->timeout_ns / NSEC_PER_MSEC;
+
+	if (!timeout)
+		return SD_EMMC_CMD_TIMEOUT_DATA;
+
+	timeout = roundup_pow_of_two(timeout);
+
+	return min(timeout, 32768U); /* max. 2^15 ms */
+}
+
 static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -441,7 +453,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 	if (data) {
 		cmd_cfg |= CMD_CFG_DATA_IO;
 		cmd_cfg |= FIELD_PREP(CMD_CFG_TIMEOUT_MASK,
-				      ilog2(SD_EMMC_CMD_TIMEOUT_DATA));
+				      ilog2(meson_mmc_get_timeout_msecs(data)));
 
 		if (data->blocks > 1) {
 			cmd_cfg |= CMD_CFG_BLOCK_MODE;
-- 
2.12.0


