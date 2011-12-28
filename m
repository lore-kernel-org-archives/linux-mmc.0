From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH 0/2] mmc: sdhci: Fix for sdhci suspend function
Date: Wed, 28 Dec 2011 11:11:11 +0800
Message-ID: <1325041873-1320-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:39181
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753101Ab1L1DLe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Dec 2011 22:11:34 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Aaron Lu <aaron.lu@amd.com>

Fixed a bug in sdhci_suspend_host, the tuning timer should be
deactivated instead of reactivated when suspending.

Handle failure case in sdhci_suspend_host, so that calling function
does not need to take care of the error recovery.

mmc: sdhci: Fix tuning timer incorrect setting when suspending host
mmc: sdhci: Deal with failure case in sdhci_suspend_host

 drivers/mmc/host/sdhci-pci.c |    9 ++-------
 drivers/mmc/host/sdhci.c     |   30 ++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 15 deletions(-)

-- 
1.7.7.4


