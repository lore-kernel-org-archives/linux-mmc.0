From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 09/15] mmc: sdhci: enable preset value after uhs initialization
Date: Tue, 10 May 2011 23:38:57 -0400
Message-ID: <m3liyd52jy.fsf@pullcord.laptop.org>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-10-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43587 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883Ab1EKDg3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 23:36:29 -0400
In-Reply-To: <1304578151-1775-10-git-send-email-arindam.nath@amd.com> (Arindam
	Nath's message of "Thu, 5 May 2011 12:19:05 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

Hi,

On Thu, May 05 2011, Arindam Nath wrote:
> According to the Host Controller spec v3.00, setting Preset Value Enable
> in the Host Control2 register lets SDCLK Frequency Select, Clock Generator
> Select and Driver Strength Select to be set automatically by the Host
> Controller based on the UHS-I mode set. This patch enables this feature.
> Since Preset Value Enable makes sense only for UHS-I cards, we enable this
> feature after successfull UHS-I initialization. We also reset Preset Value
> Enable next time before initialization.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Thanks, pushed to mmc-next for .40 with the changes below:
(Note that a function prototype is changed.)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 0577a9c..b461b29 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -931,7 +931,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		 * value registers for UHS-I cards.
 		 */
 		if (host->ops->enable_preset_value)
-			host->ops->enable_preset_value(host, 1);
+			host->ops->enable_preset_value(host, true);
 	} else {
 		/*
 		 * Attempt to change to high-speed (if supported)
@@ -1104,7 +1104,7 @@ int mmc_attach_sd(struct mmc_host *host)
 
 	/* Disable preset value enable if already set since last time */
 	if (host->ops->enable_preset_value)
-		host->ops->enable_preset_value(host, 0);
+		host->ops->enable_preset_value(host, false);
 
 	err = mmc_send_app_op_cond(host, 0, &ocr);
 	if (err)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ae10558..407eb99 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1649,7 +1649,7 @@ out:
 	return err;
 }
 
-static void sdhci_enable_preset_value(struct mmc_host *mmc, int enable)
+static void sdhci_enable_preset_value(struct mmc_host *mmc, bool enable)
 {
 	struct sdhci_host *host;
 	u16 ctrl;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 2209e01..6716bd1 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -137,7 +137,7 @@ struct mmc_host_ops {
 
 	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
 	int	(*execute_tuning)(struct mmc_host *host);
-	void	(*enable_preset_value)(struct mmc_host *host, int enable);
+	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
 };
 
 struct mmc_card;


- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
