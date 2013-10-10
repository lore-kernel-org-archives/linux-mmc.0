From: Thomas Otvald Jensen <thomas.otvald@gmail.com>
Subject: =?utf-8?b?bW1jX3Jlc2Nhbg==?= causes severe interrupt latency
Date: Thu, 10 Oct 2013 08:51:56 +0000 (UTC)
Message-ID: <loom.20131010T100432-754@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55256 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab3JJIzF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Oct 2013 04:55:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VUC1Q-0001hP-8j
	for linux-mmc@vger.kernel.org; Thu, 10 Oct 2013 10:55:04 +0200
Received: from 87.54.11.130 ([87.54.11.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2013 10:55:04 +0200
Received: from thomas.otvald by 87.54.11.130 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2013 10:55:04 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I am on an embedded system, and found that we had several ms interrupt delay
(causing UART overrun). The problem was identified as part of the mmc_rescan.

Our setup has enabled polling (MMC_CAP_NEEDS_POLL) to detect if an SD card
is present. This will cause a periodic rescheduling of mmc_rescan.

mmc_rescan -> mmc_rescan_try_freq -> mmc_power_up -> mmc_set_ios ->
host->ops->set_ios(host, ios);

We are using mmc/host/sdhci.c, so host->ops->set_ios(host, ios) -> sdhci_set_ios

And here is the problem:
The routine starts with 'spin_lock_irqsave'. This means I wont get any
interrupts until the lock is released. However this may take some time
(usually 3-5ms), but when looking at the code - in particular -
'sdhci_set_clock', then I see the comment: /* Wait max 20 ms */. We *still*
have interrupts disabled, so it could potentially add further to our delay.

(I know that e.g. sdhci_writew are platform specific, so FYI, I am on a
Freescale imx6 platform).

Q: Is this kind of interrupt delay expected (3-5ms)?
Q: Is it acceptable to have a loop with 20ms timeout with interrupts disabled?

Kind regards,
/Thomas

