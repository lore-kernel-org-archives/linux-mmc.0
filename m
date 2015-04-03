From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH 2/3] mmc: dw_mmc: Add a return in an unexpected cmd11 timeout
Date: Fri,  3 Apr 2015 11:13:06 -0700
Message-ID: <1428084787-8710-2-git-send-email-dianders@chromium.org>
References: <1428084787-8710-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428084787-8710-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, linux-rockchip@lists.infradead.org, Doug Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

If we get an unexpected cmd11 timeout we shouldn't actually treat it
as a timeout (not that we really expect to get an unexpected cmd11
timeout, but still).

Fixes: 5c935165da79 ("mmc: dw_mmc: Add a timeout for sending CMD11")
Reported-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 339a929..357ef04 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2589,8 +2589,10 @@ static void dw_mci_cmd11_timer(unsigned long arg)
 {
 	struct dw_mci *host = (struct dw_mci *)arg;
 
-	if (host->state != STATE_SENDING_CMD11)
-		dev_info(host->dev, "Unexpected CMD11 timeout\n");
+	if (host->state != STATE_SENDING_CMD11) {
+		dev_warn(host->dev, "Unexpected CMD11 timeout\n");
+		return;
+	}
 
 	host->cmd_status = SDMMC_INT_RTO;
 	set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
-- 
2.2.0.rc0.207.ga3a616c
