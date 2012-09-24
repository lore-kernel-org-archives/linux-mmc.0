From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v2 0/8] mmc: sdhci: fixes and enhancements
Date: Mon, 24 Sep 2012 16:15:50 +0800
Message-ID: <1348474558-23088-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:50699 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755245Ab2IXIU7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Sep 2012 04:20:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com


This patchset does as follows:
[PATCH v2 1/8] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
[PATCH v2 2/8] mmc: sdhci: set regulator min/max voltage according to spec
[PATCH v2 3/8] mmc: sdhci: refine code for sd clock disable/enable in set ios
[PATCH v2 4/8] mmc: sdhci: keep the saved clock var up to date
[PATCH v2 5/8] mmc: sdhci: fix null return check of regulator_get
[PATCH v2 6/8] mmc: sdhci-pxav3: controller can't get base clock
[PATCH v2 7/8] mmc: host: adjust uhs timing value
[PATCH v2 8/8] mmc: sdhci: enhance preset value function

changelog v1->v2:
	- remove the patch "mmc: sdhci-pxav3: fix build error"
	- update the patch "mmc: sdhci: fix null return check of regulator_get"
	- add the patch "mmc: sdhci-pxav3: controller can't get base clock"
	- add the patch "mmc: host: adjust uhs timing value"
	- add the patch "mmc: sdhci: enhance preset value function"

Kevin Liu (8):
 mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
 mmc: sdhci: set regulator min/max voltage according to spec
 mmc: sdhci: refine code for sd clock disable/enable in set ios
 mmc: sdhci: keep the saved clock var up to date
 mmc: sdhci: fix null return check of regulator_get
 mmc: sdhci-pxav3: controller can't get base clock
 mmc: host: adjust uhs timing value
 mmc: sdhci: enhance preset value function

 drivers/mmc/core/sd.c          |   17 ---
 drivers/mmc/host/sdhci-pxav3.c |    3 +-
 drivers/mmc/host/sdhci.c       |  220 +++++++++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h       |   12 ++
 include/linux/mmc/host.h       |   13 +--
 include/linux/mmc/sdhci.h      |    2 +-
 6 files changed, 157 insertions(+), 110 deletions(-)

