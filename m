From: Adam Lee <adam.lee@canonical.com>
Subject: [PATCH 0/2] add support of O2Mirco/BayHubTech SD hosts
Date: Wed, 18 Dec 2013 22:23:37 +0800
Message-ID: <1387376619-8050-1-git-send-email-adam.lee@canonical.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:60518 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab3LROXv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 09:23:51 -0500
Received: by mail-pd0-f171.google.com with SMTP id z10so8240117pdj.16
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2013 06:23:51 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Peter Guo <peter.guo@bayhubtech.com>

BugLink: http://bugs.launchpad.net/bugs/1239938

Card readers on Lenovo ThinkPad W540, Dell Latitude E5440 and Dell Latitude
E6540 don't work without this patch.

Thanks to Chris Ball's suggestion, I create new files but not add hundreds
lines of code into the main source file.

Adam Lee (2):
  mmc: sdhci-pci: break out definitions to header file
  mmc: sdhci-pci: add support of O2Mirco/BayHubTech SD hosts

 drivers/mmc/host/Makefile            |   1 +
 drivers/mmc/host/sdhci-pci-o2micro.c | 317 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci-o2micro.h |  72 ++++++++
 drivers/mmc/host/sdhci-pci.c         | 179 +++++---------------
 drivers/mmc/host/sdhci-pci.h         |  77 +++++++++
 5 files changed, 513 insertions(+), 133 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-o2micro.c
 create mode 100644 drivers/mmc/host/sdhci-pci-o2micro.h
 create mode 100644 drivers/mmc/host/sdhci-pci.h

-- 
1.8.5.2

