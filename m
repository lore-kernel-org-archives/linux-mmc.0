From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v4 1/4] mmc: sdhci: fix interrupt storm from card
 detection
Date: Tue, 21 Jun 2011 09:05:25 -0700
Message-ID: <6E4917C1-3CE0-48AD-A2B2-761488F39A2A@marvell.com>
References: <1308667311-1855-1-git-send-email-shawn.guo@linaro.org>
 <1308667311-1855-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34845 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751554Ab1FUQFo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Jun 2011 12:05:44 -0400
In-Reply-To: <1308667311-1855-2-git-send-email-shawn.guo@linaro.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "patches@linaro.org" <patches@linaro.org>


On Jun 21, 2011, at 7:41 AM, Shawn Guo wrote:

> The issue was initially found by Eric Benard as below.
> 
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/108031
> 
> Not sure about other SDHCI based controller, but on Freescale eSDHC,
> the SDHCI_INT_CARD_INSERT bits will be immediately set again when it
> gets cleared, if a card is inserted. The driver need to mask the irq
> to prevent interrupt storm which will freeze the system.  And the
> SDHCI_INT_CARD_REMOVE gets the same situation.
> 
> The patch fixes the problem based on the initial idea from
> Eric Benard.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric Benard <eric@eukrea.com>
> Tested-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---
> drivers/mmc/host/sdhci.c |   29 +++++++++++++++++++++++++----
> 1 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 91d9892..790f959 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -127,11 +127,15 @@ static void sdhci_mask_irqs(struct sdhci_host *host, u32 irqs)
> 
> static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
> {
> -	u32 irqs = SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT;
> +	u32 present, irqs;
> 
> 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> 		return;
> 
> +	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> +			      SDHCI_CARD_PRESENT;
> +	irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;
> +
> 	if (enable)
> 		sdhci_unmask_irqs(host, irqs);
> 	else
> @@ -2154,13 +2158,30 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
> 		mmc_hostname(host->mmc), intmask);
> 
> 	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> +		u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> +			      SDHCI_CARD_PRESENT;
> +
> +		/*
> +		 * There is a observation on i.mx esdhc.  INSERT bit will be
> +		 * immediately set again when it gets cleared, if a card is
> +		 * inserted.  We have to mask the irq to prevent interrupt
> +		 * storm which will freeze the system.  And the REMOVE gets
> +		 * the same situation.
> +		 *
> +		 * More testing are needed here to ensure it works for other
> +		 * platforms though.
> +		 */
> +		sdhci_mask_irqs(host, present ? SDHCI_INT_CARD_INSERT :
> +						SDHCI_INT_CARD_REMOVE);
> +		sdhci_unmask_irqs(host, present ? SDHCI_INT_CARD_REMOVE :
> +						  SDHCI_INT_CARD_INSERT);
> +

====
> 		sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
> -			SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
> +			     SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);

====
Please keep the old formatting since code does not change anything.  Makes it easier to find
the real change

> +		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
> 		tasklet_schedule(&host->card_tasklet);
> 	}
> 
> -	intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
> -
> 	if (intmask & SDHCI_INT_CMD_MASK) {
> 		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK,
> 			SDHCI_INT_STATUS);
> -- 
> 1.7.4.1
> 


Reviewed-by: Philip Rakity <prakity@marvell.com>

