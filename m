From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] mmc: sdhci-pci: add runtime pm support
Date: Mon,  3 Oct 2011 15:33:32 +0300
Message-ID: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11129 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754835Ab1JCMdk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Oct 2011 08:33:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here are 2 patches to add runtime pm to sdhci-pci.

Adrian Hunter (2):
      mmc: core: move ->request() call from atomic context
      mmc: sdhci-pci: add runtime pm support

 drivers/mmc/core/core.c      |   28 ++++-
 drivers/mmc/host/sdhci-pci.c |  182 ++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c     |  255 ++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/sdhci.h     |    5 +
 include/linux/mmc/sdhci.h    |    8 ++
 5 files changed, 426 insertions(+), 52 deletions(-)

Regards
Adrian Hunter
