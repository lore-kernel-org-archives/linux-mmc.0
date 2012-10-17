From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v6 00/14] mmc: sdhci: mmc: sdhci: fixes and enhancements
Date: Wed, 17 Oct 2012 19:11:56 +0800
Message-ID: <1350472330-29835-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:37263 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753526Ab2JQLOE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Oct 2012 07:14:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com


This patchset does as follows:
[PATCH v6 01/14] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
[PATCH v6 02/14] mmc: sdhci: refine voltage support caps setting
[PATCH v6 03/14] mmc: sdhci: refine code for sd clock disable/enable in set ios
[PATCH v6 04/14] mmc: sdhci: keep the saved clock var up to date
[PATCH v6 05/14] mmc: sdhci: fix null return check of regulator_get
[PATCH v6 06/14] mmc: sdhci-pxav3: controller can't get base clock
[PATCH v6 07/14] mmc: host: adjust uhs timing value
[PATCH v6 08/14] mmc: sdhci: enhance preset value function
[PATCH v6 09/14] mmc: sdhci-pxav3: add quirks2
[PATCH v6 10/14] mmc: sdhci: introduce signal_voltage_switch callback function
[PATCH v6 11/14] mmc: sdhci: fix the bug that DDR50 can't work for emmc
[PATCH v6 12/14] mmc: sdhci-pxav3: remove set_uhs_signaling function
[PATCH v6 13/14] mmc: sdhci: solve several vmmc/vqmmc regulator issues
[PATCH v6 14/14] mmc: sdhci: add function to get retunig timer count

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
changelog v4->v5:
        - drop below two patches since Johan is updating voltage switch code:
        - drop the patch "mmc: core: add new 1.8v flag for mmc"
        - drop the patch "mmc: sdhci: add mmc 1.8v signal voltage switch function"
        - drop the patch "mmc: sdhci-pxav3: add signal_voltage_switch function" which calls plat callback function
        - update the patch 07/13 with adding function get_max_clock
        - update the patch 03/13 with voltage setting
        - add patch 02/13
changelog v5->v6:
	- drop the patch "mmc: sdhci: use regulator min/max voltage range according to spec"
	- add patch 13/14
	- add patch 14/14

Kevin Liu (14)
 mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
 mmc: sdhci: refine voltage support caps setting
 mmc: sdhci: refine code for sd clock disable/enable in set ios
 mmc: sdhci: keep the saved clock var up to date
 mmc: sdhci: fix null return check of regulator_get
 mmc: sdhci-pxav3: controller can't get base clock
 mmc: host: adjust uhs timing value
 mmc: sdhci: enhance preset value function
 mmc: sdhci-pxav3: add quirks2
 mmc: sdhci: introduce signal_voltage_switch callback function
 mmc: sdhci: fix the bug that DDR50 can't work for emmc
 mmc: sdhci-pxav3: remove set_uhs_signaling function
 mmc: sdhci: solve several vmmc/vqmmc regulator issues
 mmc: sdhci: add function to get retunig timer count

 drivers/mmc/core/sd.c                   |   17 --
 drivers/mmc/host/sdhci-pxav3.c          |   44 +-----
 drivers/mmc/host/sdhci.c                |  260 ++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h                |   14 ++
 include/linux/mmc/host.h                |   13 +-
 include/linux/mmc/sdhci.h               |    2 +-
 include/linux/platform_data/pxa_sdhci.h |    2 +
 7 files changed, 202 insertions(+), 150 deletions(-)
