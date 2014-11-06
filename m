From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 0/4] mmc: sdhci: Add HS400 support to SDHCI driver
Date: Thu,  6 Nov 2014 14:25:30 +0200
Message-ID: <1415276734-28286-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16542 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbaKFM1J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 6 Nov 2014 07:27:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here is version 2 of some patches for SDHCI to support HS400 mode.

Changes in V2:

	mmc: sdhci: Clear also HS400 1.2V capability if 1.2V is not supported
		Rename MMC_CAPS2_1_2V to MMC_CAPS2_HSX00_1_2V

	mmc: sdhci: Add HS400 support to SDHCI driver
		Re-base on Ulf's current tree which required moving
		SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 to the next free
		quirk2 bit

Adrian Hunter (4):
      mmc: sdhci: Remove unused SDHCI_CTRL_HS_SDR200
      mmc: sdhci: Fix vqmmc error setting
      mmc: sdhci: Clear also HS400 1.2V capability if 1.2V is not supported
      mmc: sdhci: Add HS400 support to SDHCI driver

 drivers/mmc/host/sdhci.c  | 28 ++++++++++++++++++++--------
 drivers/mmc/host/sdhci.h  |  4 +++-
 include/linux/mmc/host.h  |  1 +
 include/linux/mmc/sdhci.h |  2 ++
 4 files changed, 26 insertions(+), 9 deletions(-)


Regards
Adrian
