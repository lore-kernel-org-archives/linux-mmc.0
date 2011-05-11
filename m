From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 11/15] mmc: sdhci: add support for retuning mode 1
Date: Tue, 10 May 2011 23:39:52 -0400
Message-ID: <m3ipth52if.fsf@pullcord.laptop.org>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-12-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43600 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883Ab1EKDhY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 23:37:24 -0400
In-Reply-To: <1304578151-1775-12-git-send-email-arindam.nath@amd.com> (Arindam
	Nath's message of "Thu, 5 May 2011 12:19:07 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

Hi,

On Thu, May 05 2011, Arindam Nath wrote:
> Host Controller v3.00 can support retuning modes 1,2 or 3 depending on
> the bits 46-47 of the Capabilities register. Also, the timer count for
> retuning is indicated by bits 40-43 of the same register. We initialize
> timer_list for retuning the first time we execute tuning procedure. This
> condition is indicated by SDHCI_NEEDS_RETUNING not being set. Since
> retuning mode 1 sets a limit of 4MB on the maximum data length, we set
> max_blk_count appropriately. Once the tuning timer expires, we set
> SDHCI_NEEDS_RETUNING flag, and if the flag is set, we execute tuning
> procedure before sending the next command. We need to restore mmc_request
> structure after executing retuning procedure since host->mrq is used
> inside the procedure to send CMD19. We also disable and re-enable this
> flag during suspend and resume respectively, as per the spec v3.00.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Thanks, pushed to mmc-next for .40 with the trivial changes below:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d90c300..e00c759 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1218,8 +1218,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		 * tuning procedure before sending command.
 		 */
 		if ((host->flags & SDHCI_NEEDS_RETUNING) &&
-		    !(present_state & (SDHCI_DOING_WRITE |
-		     SDHCI_DOING_READ))) {
+		    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ))) {
 			spin_unlock_irqrestore(&host->lock, flags);
 			sdhci_execute_tuning(mmc);
 			spin_lock_irqsave(&host->lock, flags);
@@ -1703,8 +1702,8 @@ out:
 	 */
 	if (!(host->flags & SDHCI_NEEDS_RETUNING) && host->tuning_count &&
 	    (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
-		mod_timer(&host->tuning_timer, jiffies + host->tuning_count *
-			HZ);
+		mod_timer(&host->tuning_timer, jiffies +
+			host->tuning_count * HZ);
 		/* Tuning mode 1 limits the maximum data length to 4MB */
 		mmc->max_blk_count = (4 * 1024 * 1024) / mmc->max_blk_size;
 	} else {
@@ -1831,7 +1830,6 @@ static void sdhci_tasklet_finish(unsigned long param)
 	if (host->version >= SDHCI_SPEC_300)
 		del_timer(&host->tuning_timer);
 
-
 	mrq = host->mrq;
 
 	/*
@@ -2194,8 +2192,7 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 	sdhci_disable_card_detection(host);
 
 	/* Disable tuning since we are suspending */
-	if ((host->version >= SDHCI_SPEC_300) &&
-	    host->tuning_count &&
+	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
 	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 		mod_timer(&host->tuning_timer, jiffies +
@@ -2244,8 +2241,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 	sdhci_enable_card_detection(host);
 
 	/* Set the re-tuning expiration flag */
-	if ((host->version >= SDHCI_SPEC_300) &&
-	    host->tuning_count &&
+	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
 	    host->tuning_mode == SDHCI_TUNING_MODE_1)
 		host->flags |= SDHCI_NEEDS_RETUNING;
 


- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
