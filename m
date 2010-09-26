From: Philip Rakity <prakity@marvell.com>
Subject: [RFC] sdhci: SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Sun, 26 Sep 2010 09:45:00 -0700
Message-ID: <6382AE6A-137D-4F0E-AD59-3BB54E4ACE4A@marvell.com>
References: <E6553F30-7D88-476A-A8AF-3F7793FA4DE0@marvell.com>
 <A8DEF24B-343B-4ED8-B556-12E3550506A9@marvell.com>
 <06FF83D7-6C8A-47FE-934B-E1F21E7AB915@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:35316 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753743Ab0IZQpD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 Sep 2010 12:45:03 -0400
In-Reply-To: <06FF83D7-6C8A-47FE-934B-E1F21E7AB915@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


The quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION is not quite what may needed for embedded systems.

Sometimes the card is hard wired onto the board and is always present -- usually the signal into the controller
is not used by the board designed -- saves a pin

Sometimes the card is plugged into a slot and Card Detect REALLY is broken.  In this case we need to poll by 
setting MMC_CAP_NEEDS_POLL so mmc_detect_change() will find the card.

	if (host->caps & MMC_CAP_NEEDS_POLL)
		mmc_schedule_delayed_work(&host->detect, HZ);


Since the behavior is a board issue I think it makes more sense to define a new 
struct sdhci_ops {
}

that gets called and the adaption layer can decide to set or not set MMC_CAP_NEEDS_POLL.  if this is okay will
generate the patch.

Sample code snippets below

struct sdhci_ops {
	......
	void	(*card_detect)(struct sdhci_host *host);
}

====
replace 

	if (caps & SDHCI_CAN_DO_HISPD)
		mmc->caps |= MMC_CAP_SD_HIGHSPEED;

	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
		mmc->caps |= MMC_CAP_NEEDS_POLL;


with

	if (caps & SDHCI_CAN_DO_HISPD)
		mmc->caps |= MMC_CAP_SD_HIGHSPEED;

	if (host->ops->card_detect)
		host->ops->card_detect(host)
====

platform code 
void card_detect (struct sdhci_host *host)
{
	if (card_hard_wired || sd_slot_has_no_card_detect_signal) {
		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
		if (sd_slot_has_no_card_detect_signal)
			host->mmc->caps |= MMC_CAP_NEEDS_POLL
	}
}