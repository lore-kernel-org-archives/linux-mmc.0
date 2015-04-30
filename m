From: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: [RFC PATCH 1/7] mmc: tmio: Add UHS-I mode support
Date: Thu, 30 Apr 2015 13:30:51 +0100
Message-ID: <1430397051.5802.40.camel@xylophone.i.decadent.org.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430396995.5802.39.camel-2NU49sBE5Aze9VDwLV8dzJPsBRI6B4nW9dF7HbQ/qKg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Molton <ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Based on work by Shinobu Uehara and Ben Dooks.  This adds the
voltage switch operation needed for all UHS-I modes, but not
the tuning needed for SDR-104 which will come later.

XXX The card_busy implementation is a bit of a guess.

Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---
 drivers/mmc/host/tmio_mmc.h     |    3 +++
 drivers/mmc/host/tmio_mmc_pio.c |   31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index fc3805ed69d1..a60380b94105 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -103,6 +103,9 @@ struct tmio_mmc_host {
 	void (*clk_disable)(struct platform_device *pdev);
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
+
+	int (*start_signal_voltage_switch)(struct tmio_mmc_host *host,
+					   unsigned char signal_voltage);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index e3dcf31a8bd6..3c1e0e53c0b1 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1011,12 +1011,43 @@ static int tmio_multi_io_quirk(struct mmc_card *card,
 	return blk_size;
 }
 
+static int tmio_mmc_start_signal_voltage_switch(struct mmc_host *mmc,
+	struct mmc_ios *ios)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	if (!host->start_signal_voltage_switch)
+		return 0;
+
+	return host->start_signal_voltage_switch(host, ios->signal_voltage);
+}
+
+static int tmio_mmc_card_busy(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	u32 status;
+
+	pm_runtime_get_sync(mmc_dev(mmc));
+	status = sd_ctrl_read32(host, CTL_STATUS);
+	pm_runtime_mark_last_busy(mmc_dev(mmc));
+	pm_runtime_put_autosuspend(mmc_dev(mmc));
+
+	/*
+	 * Card signals busy by pulling down all of DAT[3:0].  This status
+	 * flag appears to reflect DAT3.
+	 */
+	return !(status & TMIO_STAT_SIGSTATE_A);
+}
+
 static const struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
 	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
+	.start_signal_voltage_switch
+			= tmio_mmc_start_signal_voltage_switch,
+	.card_busy	= tmio_mmc_card_busy,
 	.multi_io_quirk	= tmio_multi_io_quirk,
 };
 
-- 
1.7.10.4




--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
