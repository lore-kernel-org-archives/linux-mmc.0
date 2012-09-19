From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH 0/6] mmc: sdhci: fixes and enhancements
Date: Wed, 19 Sep 2012 10:12:36 +0800
Message-ID: <1348020762-12932-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:49107 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751650Ab2ISCR7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Sep 2012 22:17:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com


This patchset does as follows:
[PATCH 1/6] mmc: sdhci-pxav3: fix build error
[PATCH 2/6] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
[PATCH 3/6] mmc: sdhci: set regulator min/max voltage according to spec
[PATCH 4/6] mmc: sdhci: refine code for sd clock disable/enable in set ios
[PATCH 5/6] mmc: sdhci: keep the saved clock var up to date
[PATCH 6/6] mmc: sdhci: fix null return check of regulator_get

Kevin Liu (6):
 mmc: sdhci-pxav3: fix build error
 mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
 mmc: sdhci: set regulator min/max voltage according to spec
 mmc: sdhci: refine code for sd clock disable/enable in set ios
 mmc: sdhci: keep the saved clock var up to date
 mmc: sdhci: fix null return check of regulator_get

 drivers/mmc/host/sdhci-pxav3.c |    2 +
 drivers/mmc/host/sdhci.c       |   79 ++++++++++++++++++++--------------------
 2 files changed, 41 insertions(+), 40 deletions(-)

