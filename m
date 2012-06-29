From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH 0/2] Fixes for tuning stuffs
Date: Fri, 29 Jun 2012 13:59:52 +0800
Message-ID: <1340949594-27929-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [65.55.88.15] ([65.55.88.15]:48038 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750891Ab2F2GBx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jun 2012 02:01:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@amd.com>

The following 2 patches fixed a bug related the tuning stuffs and
refactored the code to make it simpler and easier to read and understand.

Aaron Lu (2):
  mmc: sdhci: restore host settings when card is removed
  mmc: sdhci: A new flag SDHCI_NEEDS_RETUNING_TIMER

 drivers/mmc/host/sdhci.c  | 39 +++++++++++++++++++++------------------
 include/linux/mmc/sdhci.h |  1 +
 2 files changed, 22 insertions(+), 18 deletions(-)

-- 
1.7.11.1.3.g4c8a9db


