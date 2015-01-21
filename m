From: "Sun, Yi Y" <yi.y.sun@intel.com>
Subject: RE: [RFC 0/2] mmc: UHS-II implementation
Date: Wed, 21 Jan 2015 03:57:31 +0000
Message-ID: <525EAED47491124EB5123A51BD2FC79101A30EE2@SHSMSX101.ccr.corp.intel.com>
References: <1419672479-30852-1-git-send-email-yi.y.sun@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31937 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823AbbAUD5s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jan 2015 22:57:48 -0500
In-Reply-To: <1419672479-30852-1-git-send-email-yi.y.sun@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>

Hi, all,

This patch has been submitted for several weeks. I hope to get suggestions from community to solve potential issues as early as possible. Any comment would be very appreciated.

Thanks,
Sun Yi

-----Original Message-----
From: Sun, Yi Y 
Sent: Saturday, December 27, 2014 5:28 PM
To: linux-mmc@vger.kernel.org; ulf.hansson@linaro.org
Cc: Sun, Yi Y
Subject: [RFC 0/2] mmc: UHS-II implementation

Hello,

UHS-II spec has been published for some time but it seems community does not implement this feature. With this feature, read/write performance can be improved much.

So, I submit these two patches which implement main functions of UHS-II for community review. Hope to get suggestions from community.

As the UHS-II test environment is not available yet, some functions may be not completed. I add some "TODO" in codes for next steps and some concerns. In next steps, the codes will be finished completely and verified on board supporting UHS-II. Then, the formal patches will be submitted.

The implementation bases on below specs:
1. SD 4.2 PHY
2. UHS-II Addendum 1.02
3. SDHC Spec 4.1

Yi Sun (2):
  mmc: core: support UHS-II in core stack.
  mmc: sdhci: support UHS-II in SDHCI host.

 drivers/mmc/core/Makefile     |    3 +-
 drivers/mmc/core/bus.c        |    5 +-
 drivers/mmc/core/core.c       |   89 +++-
 drivers/mmc/core/sd.c         |   15 +
 drivers/mmc/core/sd_ops.c     |   12 +
 drivers/mmc/core/uhs2.c       |  908 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/uhs2.h       |   26 ++
 drivers/mmc/host/Makefile     |    2 +-
 drivers/mmc/host/sdhci-pci.c  |    6 +
 drivers/mmc/host/sdhci-uhs2.c |  703 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   36 ++
 drivers/mmc/host/sdhci.c      |  259 ++++++++++--
 drivers/mmc/host/sdhci.h      |  313 +++++++++++++-
 include/linux/mmc/core.h      |    6 +
 include/linux/mmc/host.h      |   27 ++
 include/linux/mmc/sdhci.h     |    2 +
 include/linux/mmc/uhs2.h      |  274 +++++++++++++
 17 files changed, 2625 insertions(+), 61 deletions(-)  create mode 100644 drivers/mmc/core/uhs2.c  create mode 100644 drivers/mmc/core/uhs2.h  create mode 100644 drivers/mmc/host/sdhci-uhs2.c  create mode 100644 drivers/mmc/host/sdhci-uhs2.h  create mode 100644 include/linux/mmc/uhs2.h

--
1.7.9.5

