From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 01/15] mmc: sd: add support for signal voltage switch procedure
Date: Tue, 10 May 2011 23:34:08 -0400
Message-ID: <m3wrhx52rz.fsf@pullcord.laptop.org>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-2-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38188 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145Ab1EKDbp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 23:31:45 -0400
In-Reply-To: <1304578151-1775-2-git-send-email-arindam.nath@amd.com> (Arindam
	Nath's message of "Thu, 5 May 2011 12:18:57 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

Hi,

On Thu, May 05 2011, Arindam Nath wrote:
> Host Controller v3.00 adds another Capabilities register. Apart
> from other things, this new register indicates whether the Host
> Controller supports SDR50, SDR104, and DDR50 UHS-I modes. The spec
> doesn't mention about explicit support for SDR12 and SDR25 UHS-I
> modes, so the Host Controller v3.00 should support them by default.
> Also if the controller supports SDR104 mode, it will also support
> SDR50 mode as well. So depending on the host support, we set the
> corresponding MMC_CAP_* flags. One more new register. Host Control2
> is added in v3.00, which is used during Signal Voltage Switch
> procedure described below.
>
> Since as per v3.00 spec, UHS-I supported hosts should set S18R
> to 1, we set S18R (bit 24) of OCR before sending ACMD41. We also
> need to set XPC (bit 28) of OCR in case the host can supply >150mA.
> This support is indicated by the Maximum Current Capabilities
> register of the Host Controller.
>
> If the response of ACMD41 has both CCS and S18A set, we start the
> signal voltage switch procedure, which if successfull, will switch
> the card from 3.3V signalling to 1.8V signalling. Signal voltage
> switch procedure adds support for a new command CMD11 in the
> Physical Layer Spec v3.01. As part of this procedure, we need to
> set 1.8V Signalling Enable (bit 3) of Host Control2 register, which
> if remains set after 5ms, means the switch to 1.8V signalling is
> successfull. Otherwise, we clear bit 24 of OCR and retry the
> initialization sequence. When we remove the card, and insert the
> same or another card, we need to make sure that we start with 3.3V
> signalling voltage. So we call mmc_set_signal_voltage() with
> MMC_SIGNAL_VOLTAGE_330 set so that we are back to 3.3V signalling
> voltage before we actually start initializing the card.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Thanks, pushed to mmc-next for .40 with the trivial changes below:

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ea5c28d..5005a63 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -944,7 +944,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 
 int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 {
-	struct mmc_command cmd;
+	struct mmc_command cmd = {0};
 	int err = 0;
 
 	BUG_ON(!host);
@@ -954,8 +954,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 	 * 1.8V signalling.
 	 */
 	if (signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
-		memset(&cmd, 0, sizeof(struct mmc_command));
-
 		cmd.opcode = SD_SWITCH_VOLTAGE;
 		cmd.arg = 0;
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 52faa50..7fffc5e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1400,9 +1400,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				present_state = sdhci_readl(host,
 							SDHCI_PRESENT_STATE);
 				if ((present_state & SDHCI_DATA_LVL_MASK) ==
-				     SDHCI_DATA_LVL_MASK) {
+				     SDHCI_DATA_LVL_MASK)
 					return 0;
-				}
 			}
 		}
 

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
