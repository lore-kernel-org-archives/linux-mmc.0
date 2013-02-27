From: Chris Ball <cjb@laptop.org>
Subject: Re: [Question] What does SDHCI_QUIRK_BROKEN_CARD_DETECTION stands for?
Date: Wed, 27 Feb 2013 09:36:00 -0500
Message-ID: <87ip5d7rjj.fsf@octavius.laptop.org>
References: <CADz5_gKreSB9BvTgBBcjjOOEDMRc2q1s-9VNHfb_+x+9gdADLw@mail.gmail.com>
	<87r4k17toq.fsf@octavius.laptop.org>
	<CADz5_gKvGqSFsTiMVMG2jcsXmfESydGfTSzN=sG-WAGkpP6DYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46274 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760025Ab3B0OgF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Feb 2013 09:36:05 -0500
In-Reply-To: <CADz5_gKvGqSFsTiMVMG2jcsXmfESydGfTSzN=sG-WAGkpP6DYw@mail.gmail.com>
	(Kevin Liu's message of "Wed, 27 Feb 2013 22:33:15 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, Feb 27 2013, Kevin Liu wrote:
> Thanks for quick answer!
> Then if broken-cd/SDHCI_QUIRK_BROKEN_CARD_DETECTION is selected, can I
> use host controller Present State Register[18] (offset 0x24) to know
> card status (present or not)?

sdhci.c:

	present = mmc_gpio_get_cd(host->mmc);
	if (present < 0) {
		/* If polling, assume that the card is always present. */
		if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
			present = 1;
		else
			present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
					SDHCI_CARD_PRESENT;
	}

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
