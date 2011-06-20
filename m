From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v3 1/4] mmc: sdhci: fix interrupt storm from card
 detection
Date: Mon, 20 Jun 2011 08:59:38 -0700
Message-ID: <AA2705EE-033E-4340-8CF1-774F444E143E@marvell.com>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
 <1308566325-11600-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43274 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751956Ab1FTQCT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jun 2011 12:02:19 -0400
In-Reply-To: <1308566325-11600-2-git-send-email-shawn.guo@linaro.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "patches@linaro.org" <patches@linaro.org>


On Jun 20, 2011, at 3:38 AM, Shawn Guo wrote:

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
> ---
> drivers/mmc/host/sdhci.c |   27 +++++++++++++++++++++++----
> 1 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 91d9892..d94e2b4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -127,7 +127,9 @@ static void sdhci_mask_irqs(struct sdhci_host *host, u32 irqs)
> 
> static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
> {
> -	u32 irqs = SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT;
> +	u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> +		      SDHCI_CARD_PRESENT;
> +	u32 irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;
> 
> 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> 		return;


Accessing off chip registers is slow.  It would be better to check for the quirk first
and then read the present state register.

eg
	
	u32 present;
	u32 irqs;	

> 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> 		return;

>  	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> 		      SDHCI_CARD_PRESENT;


> 	irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;


Philip

