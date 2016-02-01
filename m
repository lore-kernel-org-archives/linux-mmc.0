From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 0/21] Totally remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
 quirk
Date: Mon, 1 Feb 2016 14:32:49 +0200
Message-ID: <56AF5071.9050103@intel.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
 <56A8BF22.8010509@intel.com> <20160127132348.GY10826@n2100.arm.linux.org.uk>
 <CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
 <56AA03AA.5010706@intel.com>
 <CAPDyKFoBdJ-5sXyJpTNxDJVJSUA+Gsjc+0+uLedNZCHYcF+rvQ@mail.gmail.com>
 <56AB5635.9030007@intel.com> <20160129172817.GR10826@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:58843 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671AbcBAMgS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Feb 2016 07:36:18 -0500
In-Reply-To: <20160129172817.GR10826@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>, Wan Zongshun <vincent.wan@amd.com>, Jisheng Zhang <jszhang@marvell.com>

On 29/01/16 19:28, Russell King - ARM Linux wrote:
> On Fri, Jan 29, 2016 at 02:08:21PM +0200, Adrian Hunter wrote:
>> I might make a tree because I want to try to separate Russell's bug fixes
>> from the clean-ups, and then cc stable on the bug fixes.
> 
> It would be good if you could ask for that, I'll look at rearranging
> (and re-testing) the patches to achieve that.  Had I known that, I
> could've done it before posting the latest set of patches.

If you don't mind doing that, that would be great!

So far the fixes, I have identified:

1. mmc: sdhci: command response CRC error handling

Could have "fix" in the subject i.e. "fix command response CRC error handling".

Could change to be dependent only on "mmc: sdhci: move initialisation of
command error member".  Also I would treat end-bit and index errors the same
as CRC errors i.e. probably end up with:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d622435d1bcc..6cae93a89eba 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2325,8 +2325,23 @@ static void sdhci_cmd_irq(struct sdhci_host *host,
u32 intmask, u32 *mask)
 	if (intmask & SDHCI_INT_TIMEOUT)
 		host->cmd->error = -ETIMEDOUT;
 	else if (intmask & (SDHCI_INT_CRC | SDHCI_INT_END_BIT |
-			SDHCI_INT_INDEX))
+			SDHCI_INT_INDEX)) {
 		host->cmd->error = -EILSEQ;
+		/*
+		 * If this command initiates a data phase and a response
+		 * CRC error is signalled, the card can start transferring
+		 * data - the card may have received the command without
+		 * error.  We must not terminate the mmc_request early.
+		 *
+		 * If the card did not receive the command or returned an
+		 * error which prevented it sending data, the data phase
+		 * will time out.
+		 */
+		if (host->cmd->data) {
+			host->cmd = NULL;
+			return;
+		}
+	}

 	if (host->cmd->error) {
 		tasklet_schedule(&host->finish_tasklet);

2. mmc: sdhci: avoid unnecessary mapping/unmapping of align buffer

This looks like a bug fix because the mapping can be leaked on the error
path i.e. similar problem to the one fixed by "mmc: sdhci: plug DMA mapping
leak on error"

3. mmc: sdhci: plug DMA mapping leak on error

It looks like the 2nd chunk could be taken as a separate fix without
dependence on other patches.

4. mmc: sdhci-pxav3: fix higher speed mode capabilities

I can't test this so please indicate if you want it for stable.

5. mmc: sdhci: further fix for DMA unmapping in sdhci_post_req()

Could be made independent of other patches.

6. mmc: sdhci: fix data timeout (part 1)
mmc: sdhci: fix data timeout (part 2)

Could be just 1 patch.


