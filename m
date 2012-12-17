From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 00/12] mmc: sdhci: fixes and enhancements
Date: Mon, 17 Dec 2012 19:21:56 +0800
Message-ID: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:55450 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752273Ab2LQLWc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 06:22:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com


This patchset aim to fix bugs and do some code enhancement for sdhci.c.
Most patches are quite small.
I will highly appreciate if you can pay a few minutes to review them.
Any comments are welcome.

[PATCH v10 01/12] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
[PATCH v10 02/12] mmc: sdhci: refine code for clock disable/enable in set ios
[PATCH v10 03/12] mmc: sdhci: add function to get retunig timer count
[PATCH v10 04/12] mmc: sdhci: correct voltage support caps setting
[PATCH v10 05/12] mmc: sdhci: clean code for SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK selected
[PATCH v10 06/12] mmc: sdhci: remove check for CONFIG_REGULATOR
[PATCH v10 07/12] mmc: sdhci: fix the bug that DDR50 can't work for emmc in default code
[PATCH v10 08/12] mmc: sdhci: remove set_uhs_signaling function
[PATCH v10 09/12] mmc: sdhci: enhance preset value function
[PATCH v10 10/12] mmc: sdhci: keep the saved clock var up to date
[PATCH v10 11/12] mmc: sdhci: add notifier for regulator vqmmc
[PATCH v10 12/12] mmc: sdhci-pxav3: add regulator notifier for vqmmc

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
changelog v6->v7:
	- remove the patch "mmc: sdhci: fix null return check of regulator_get" which has been merged
	- restore the patch "mmc: sdhci: use regulator min/max voltage range according to spec"
changelog v7->v8:
	- remove the merged patch "mmc: sdhci-pxav3: controller can't get base clock"
	- remove the merged patch "mmc: host: adjust uhs timing value"
	- remove the merged patch "mmc: sdhci: solve several vmmc/vqmmc regulator issues"
	- update the patch "mmc: sdhci-pxav3: remove set_uhs_signaling function"
changelog v8->v9:
	- remove the merged patch "mmc: sdhci-pxav3: add quirks2"
	- remove the merged patch "mmc: sdhci: use regulator min/max voltage range according to spec"
	- add patch 10/10
changelog v9->v10:
	- remove the patch "mmc: sdhci: introduce signal_voltage_switch callback function"
	- add patch 6/12, 11/12, 12/12

Kevin Liu (12):

 [PATCH v10 01/12] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
 [PATCH v10 02/12] mmc: sdhci: refine code for clock disable/enable in set ios
 [PATCH v10 03/12] mmc: sdhci: add function to get retunig timer count
 [PATCH v10 04/12] mmc: sdhci: correct voltage support caps setting
 [PATCH v10 05/12] mmc: sdhci: clean code for SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK selected
 [PATCH v10 06/12] mmc: sdhci: remove check for CONFIG_REGULATOR
 [PATCH v10 07/12] mmc: sdhci: fix the bug that DDR50 can't work for emmc in default code
 [PATCH v10 08/12] mmc: sdhci: remove set_uhs_signaling function
 [PATCH v10 09/12] mmc: sdhci: enhance preset value function
 [PATCH v10 10/12] mmc: sdhci: keep the saved clock var up to date
 [PATCH v10 11/12] mmc: sdhci: add notifier for regulator vqmmc
 [PATCH v10 12/12] mmc: sdhci-pxav3: add regulator notifier for vqmmc

 drivers/mmc/core/sd.c                   |   17 --
 drivers/mmc/host/sdhci-pxav3.c          |   41 +-----
 drivers/mmc/host/sdhci.c                |  276 +++++++++++++++++++------------
 drivers/mmc/host/sdhci.h                |   14 ++-
 include/linux/mmc/host.h                |    1 -
 include/linux/mmc/sdhci.h               |    2 +
 include/linux/platform_data/pxa_sdhci.h |    2 +
 7 files changed, 187 insertions(+), 166 deletions(-)
