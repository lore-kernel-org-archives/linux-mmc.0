From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 0/2] mmc_test performance test fixes
Date: Thu, 23 Sep 2010 14:51:22 +0300
Message-ID: <20100923115122.18000.46750.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:57705 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab0IWLvc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 07:51:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>

Hi

Here are two fixes for mmc_test performance tests.  They apply to the mmc-next
branch of Chris Ball's mmc tree at:
	git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git


The following changes since commit 0bff5cae99dfc9f820cdbddcc4f2cf55627ccfac:
  Philip Rakity (1):
        mmc: sdhci: print out controller name for register debug

Adrian Hunter (2):
      mmc_test: fix memory allocation segment limits
      mmc_test: fix display of .5 KiB

 drivers/mmc/card/mmc_test.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


Regards
Adrian

