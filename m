From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] mmc: sdhci: Add HS400 support to SDHCI driver
Date: Fri, 31 Oct 2014 14:22:47 +0200
Message-ID: <1414758171-1244-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64398 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759419AbaJaMYh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 31 Oct 2014 08:24:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are some patches for SDHCI to support HS400 mode.  These
patches are based on top of my 64-bit ADMA patchset.


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
