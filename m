From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] mmc: block: support no access to boot partitions
Date: Fri, 23 Sep 2011 12:48:19 +0300
Message-ID: <1316771301-12323-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42644 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728Ab1IWJsb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Sep 2011 05:48:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Hi

Here is a minor fix and a patch to support no access to boot partitions.

Adrian Hunter (2):
      mmc: block: fix boot partition switch error path
      mmc: block: support no access to boot partitions

 drivers/mmc/card/block.c     |   18 ++++++++++++++----
 drivers/mmc/host/sdhci-pci.c |    2 ++
 include/linux/mmc/host.h     |   10 ++++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

Regards
Adrian Hunter
