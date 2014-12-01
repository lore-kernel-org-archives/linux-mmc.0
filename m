From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/4] mmc: Add some flags for Intel host controllers
Date: Mon,  1 Dec 2014 15:51:15 +0200
Message-ID: <1417441879-28058-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35203 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585AbaLANw6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Dec 2014 08:52:58 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are some patches to add some flags for Intel
host controllers.


Adrian Hunter (4):
      mmc: sdhci-pci: Add SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC to BYT
      mmc: sdhci-acpi: Add SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
      mmc: sdhci-pci: Add two host capabilities for BYT
      mmc: sdhci-acpi: Add two host capabilities for Intel


Regards
Adrian
