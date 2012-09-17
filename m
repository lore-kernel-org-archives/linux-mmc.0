From: Chris Ball <cjb@laptop.org>
Subject: cd-gpio and SDHCI presence
Date: Mon, 17 Sep 2012 02:29:04 -0400
Message-ID: <m3y5k9yxfz.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53811 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab2IQG2u (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Sep 2012 02:28:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi Guennadi,

I'm having trouble using a cd-gpio.  After I request it, I get the
IRQ and mmc_rescan() triggers successfully, but mmc_attach_sd()
fails because every command returns -123 (ENOMEDIUM), due to:

sdhci.c:
	/* If polling, assume that the card is always present. */
	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
		present = true;
	else
		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
				SDHCI_CARD_PRESENT;

	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
		host->mrq->cmd->error = -ENOMEDIUM;
		tasklet_schedule(&host->finish_tasklet);
	} else { 
		...

"present" is false because SDHCI_PRESENT_STATE doesn't have the presence
bit sent (if it did, we wouldn't need a cd-gpio, right?) and the command
fails.

And we can't just set SDHCI_QUIRK_BROKEN_CARD_DETECTION, because that
would turn on polling, which we don't want.  How's this supposed to work?

Maybe your system was differently broken, and we need some new way to
communicate that neither the PRESENT bit nor polling should be used?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
