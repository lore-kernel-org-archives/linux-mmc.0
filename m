From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/1] mmc: sdhci-acpi: Reduce Baytrail eMMC/SD/SDIO hangs
Date: Fri, 15 Apr 2016 14:06:56 +0300
Message-ID: <1460718417-20920-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43494 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbcDOLLB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Apr 2016 07:11:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here is a patch to reduce BayTrail eMMC hangs.

I had previously sent patches relating to C-states:

	http://marc.info/?l=linux-mmc&m=142720456725463&w=2

but I have found so far that this patch gives better results.

I would encourage anyone using the C-State patches to try this one
instead.


Adrian Hunter (1):
      mmc: sdhci-acpi: Reduce Baytrail eMMC/SD/SDIO hangs

 drivers/mmc/host/Kconfig      |  1 +
 drivers/mmc/host/sdhci-acpi.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)


Regards
Adrian
