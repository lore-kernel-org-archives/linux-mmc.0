From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v4 00/15] mmc: sdhci: fixes and enhancements
Date: Wed, 26 Sep 2012 19:38:32 +0800
Message-ID: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:42545 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755853Ab2IZLoE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Sep 2012 07:44:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com


This patchset does as follows:
[PATCH v4 01/15] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
[PATCH v4 02/15] mmc: sdhci: set regulator min/max voltage according to spec
[PATCH v4 03/15] mmc: sdhci: refine code for sd clock disable/enable in set ios
[PATCH v4 04/15] mmc: sdhci: keep the saved clock var up to date
[PATCH v4 05/15] mmc: sdhci: fix null return check of regulator_get
[PATCH v4 06/15] mmc: sdhci-pxav3: controller can't get base clock
[PATCH v4 07/15] mmc: host: adjust uhs timing value
[PATCH v4 08/15] mmc: sdhci: enhance preset value function
[PATCH v4 09/15] mmc: sdhci-pxav3: add quirks2
[PATCH v4 10/15] mmc: sdhci: introduce signal_voltage_switch callback function
[PATCH v4 11/15] mmc: sdhci-pxav3: add signal_voltage_switch function
[PATCH v4 12/15] mmc: core: add new 1.8v flag for mmc
[PATCH v4 13/15] mmc: sdhci: add mmc 1.8v signal voltage switch function
[PATCH v4 14/15] mmc: sdhci: fix the bug that DDR50 can't work for emmc
[PATCH v4 15/15] mmc: sdhci-pxav3: remove set_uhs_signaling function

changelog v1->v2:
	- remove the patch "mmc: sdhci-pxav3: fix build error"
	- update the patch 05/15 by avoid warning with return null
	- add patches 06/15 ~ 08/15
changelog v2->v3:
	- update some comments
	- add patches 09/15 ~ 11/15
changelog v3->v4:
	- update the patch 01/15 with data null check
	- add patches 12/15 ~ 15/15

Kevin Liu (15):
 mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
 mmc: sdhci: set regulator min/max voltage according to spec
 mmc: sdhci: refine code for sd clock disable/enable in set ios
 mmc: sdhci: keep the saved clock var up to date
 mmc: sdhci: fix null return check of regulator_get
 mmc: sdhci-pxav3: controller can't get base clock
 mmc: host: adjust uhs timing value
 mmc: sdhci: enhance preset value function
 mmc: sdhci-pxav3: add quirks2
 mmc: sdhci: introduce signal_voltage_switch callback function
 mmc: sdhci-pxav3: add signal_voltage_switch function
 mmc: core: add new 1.8v flag for mmc
 mmc: sdhci: add mmc 1.8v signal voltage switch function
 mmc: sdhci: fix the bug that DDR50 can't work for emmc
 mmc: sdhci-pxav3: remove set_uhs_signaling function

 drivers/mmc/core/mmc.c                  |    3 +-
 drivers/mmc/core/sd.c                   |   17 --
 drivers/mmc/host/sdhci-pxav3.c          |   53 +++----
 drivers/mmc/host/sdhci.c                |  293 ++++++++++++++++++++++---------
 drivers/mmc/host/sdhci.h                |   13 ++
 include/linux/mmc/host.h                |   14 +-
 include/linux/mmc/sdhci.h               |    2 +-
 include/linux/platform_data/pxa_sdhci.h |    4 +
 8 files changed, 254 insertions(+), 145 deletions(-)
