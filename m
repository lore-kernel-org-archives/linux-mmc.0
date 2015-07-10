From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] mmc: sunxi: Don't start commands while the card
 is busy
Date: Fri, 10 Jul 2015 17:07:55 +0200
Message-ID: <1436540875-11570-1-git-send-email-hdegoede@redhat.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDRZXY4CYYORBUF776WAKGQEAYHT4BI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Some sdio wifi modules have not been working reliable with the sunxi-mmc
host code. This turns out to be caused by it starting new commands while
the card signals that it is still busy processing a previous command.

This commit fixes this, thereby fixing the wifi reliability issues on
the Cubietruck and other sunxi boards using sdio wifi.

Cc: Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sunxi-mmc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 4d3e1ff..daa90b7 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -289,6 +289,24 @@ static int sunxi_mmc_init_host(struct mmc_host *mmc)
 	return 0;
 }
 
+/* Wait for card to report ready before starting a new cmd */
+static int sunxi_mmc_wait_card_ready(struct sunxi_mmc_host *host)
+{
+	unsigned long expire = jiffies + msecs_to_jiffies(500);
+	u32 rval;
+
+	do {
+		rval = mmc_readl(host, REG_STAS);
+	} while (time_before(jiffies, expire) && (rval & SDXC_CARD_DATA_BUSY));
+
+	if (rval & SDXC_CARD_DATA_BUSY) {
+		dev_err(mmc_dev(host->mmc), "Error R1 ready timeout\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
 				    struct mmc_data *data)
 {
@@ -383,6 +401,8 @@ static void sunxi_mmc_send_manual_stop(struct sunxi_mmc_host *host,
 	u32 arg, cmd_val, ri;
 	unsigned long expire = jiffies + msecs_to_jiffies(1000);
 
+	sunxi_mmc_wait_card_ready(host);
+
 	cmd_val = SDXC_START | SDXC_RESP_EXPIRE |
 		  SDXC_STOP_ABORT_CMD | SDXC_CHECK_RESPONSE_CRC;
 
@@ -597,6 +617,11 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 {
 	unsigned long expire = jiffies + msecs_to_jiffies(250);
 	u32 rval;
+	int ret;
+
+	ret = sunxi_mmc_wait_card_ready(host);
+	if (ret)
+		return ret;
 
 	rval = mmc_readl(host, REG_CLKCR);
 	rval &= ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON);
@@ -785,6 +810,13 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
+	ret = sunxi_mmc_wait_card_ready(host);
+	if (ret) {
+		mrq->cmd->error = ret;
+		mmc_request_done(mmc, mrq);
+		return;
+	}
+
 	if (data) {
 		ret = sunxi_mmc_map_dma(host, data);
 		if (ret < 0) {
-- 
2.4.3
