From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v6 4/5] mmc: debugfs: add HS400 enhanced strobe description
Date: Thu, 26 May 2016 09:56:30 +0800
Message-ID: <1464227790-31337-1-git-send-email-shawn.lin@rock-chips.com>
References: <1464227707-30616-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:36620 "EHLO
	vmpostfix.263.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753089AbcEZB4y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2016 21:56:54 -0400
In-Reply-To: <1464227707-30616-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

We introduce HS400 with enhanced strobe function, so we need
to add it for debug show.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
---

Changes in v6:
- add Doug's review-test-tag and Jaehoon's test-tag
- a minor string assignment

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mmc/core/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 9382a57..c8451ce 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -148,7 +148,8 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 		str = "mmc HS200";
 		break;
 	case MMC_TIMING_MMC_HS400:
-		str = "mmc HS400";
+		str = mmc_card_hs400es(host->card) ?
+			"mmc HS400 enhanced strobe" : "mmc HS400";
 		break;
 	default:
 		str = "invalid";
-- 
2.3.7


