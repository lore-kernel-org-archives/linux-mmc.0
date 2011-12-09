From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/4] MMC/SD: Add callback function to detect card
Date: Fri, 09 Dec 2011 12:03:23 +0200
Message-ID: <4EE1DCEB.5030102@intel.com>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com> <1323077026-12071-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19724 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879Ab1LIKD0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Dec 2011 05:03:26 -0500
In-Reply-To: <1323077026-12071-2-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

On 05/12/11 11:23, r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> In order to check whether the card has been removed, the function
> mmc_send_status() will send command CMD13 to card and ask the card
> to send its status register to sdhc driver, which will generate
> many interrupts repeatedly and make the system performance bad.

That should not be true.  sdhci.c will not send a command to the
card if the card is not present i.e. see this excerpt from
sdhci_request():


	/* If polling, assume that the card is always present. */
	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
		present = true;
	else
		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
				SDHCI_CARD_PRESENT;

	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
		host->mrq->cmd->error = -ENOMEDIUM;
		tasklet_schedule(&host->finish_tasklet);
