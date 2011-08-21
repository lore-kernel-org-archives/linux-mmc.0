From: Alexander Tarasikov <alexander.tarasikov@gmail.com>
Subject: [PATCH 1/2] msm: Fix a typo in MSM SDCC driver gpio setup
Date: Sun, 21 Aug 2011 15:52:43 +0400
Message-ID: <1313927564-10355-2-git-send-email-alexander.tarasikov@gmail.com>
References: <1313927564-10355-1-git-send-email-alexander.tarasikov@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1313927564-10355-1-git-send-email-alexander.tarasikov@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, cjb@laptop.org
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, Alexander Tarasikov <alexander.tarasikov@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The use of && instead of || caused a NULL pointer dereference if
gpio setup was not passed via platform data

Signed-off-by: Alexander Tarasikov <alexander.tarasikov@gmail.com>
---
 drivers/mmc/host/msm_sdcc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index a4c865a..d06539d 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -939,7 +939,7 @@ static void msmsdcc_setup_gpio(struct msmsdcc_host *host, bool enable)
	struct msm_mmc_gpio_data *curr;
	int i, rc = 0;

-	if (!host->plat->gpio_data && host->gpio_config_status == enable)
+	if (!host->plat->gpio_data || host->gpio_config_status == enable)
		return;

	curr = host->plat->gpio_data;
--
1.7.5.4
