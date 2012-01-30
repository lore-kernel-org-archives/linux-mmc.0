From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] mmc: sdhci-pci: fixes for Medfield SDIO suspend / resume
Date: Mon, 30 Jan 2012 14:27:17 +0200
Message-ID: <1327926439-23603-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38988 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567Ab2A3M1V (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Jan 2012 07:27:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here are a couple of fixes for Medfield SDIO suspend / resume.


Adrian Hunter (2):
      mmc: sdhci-pci: set Medfield SDIO as non-removable
      mmc: sdhci: always reset all during resume

 drivers/mmc/host/sdhci-pci.c |    2 +-
 drivers/mmc/host/sdhci.c     |   29 +++++++++++------------------
 2 files changed, 12 insertions(+), 19 deletions(-)


Regards
Adrian
