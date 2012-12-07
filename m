From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v9 00/10] mmc: sdhci: fixes and enhancements
Date: Fri,  7 Dec 2012 10:36:20 +0800
Message-ID: <1354847790-18690-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:56726 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423968Ab2LGCeQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Dec 2012 21:34:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com


This patchset aim to fix bugs and do some code enhancement for sdhci.c Most patches are quite small.
I will highly appreciate if you can pay a few minutes to review them.
Any comments are welcome.

[PATCH v9 01/10] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
[PATCH v9 02/10] mmc: sdhci: refine code for clock disable/enable in set ios
[PATCH v9 03/10] mmc: sdhci: keep the saved clock var up to date
[PATCH v9 04/10] mmc: sdhci: enhance preset value function
[PATCH v9 05/10] mmc: sdhci: introduce signal_voltage_switch callback function
[PATCH v9 06/10] mmc: sdhci: fix the bug that DDR50 can't work for emmc in default code
[PATCH v9 07/10] mmc: sdhci: remove set_uhs_signaling function
[PATCH v9 08/10] mmc: sdhci: add function to get retunig timer count
[PATCH v9 09/10] mmc: sdhci: correct voltage support caps setting
[PATCH v9 10/10] mmc: sdhci: clean code for SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK selected

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

Kevin Liu (10)

[PATCH v9 01/10] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
[PATCH v9 02/10] mmc: sdhci: refine code for clock disable/enable in set ios
[PATCH v9 03/10] mmc: sdhci: keep the saved clock var up to date
[PATCH v9 04/10] mmc: sdhci: enhance preset value function
[PATCH v9 05/10] mmc: sdhci: introduce signal_voltage_switch callback function
[PATCH v9 06/10] mmc: sdhci: fix the bug that DDR50 can't work for emmc in default code
[PATCH v9 07/10] mmc: sdhci: remove set_uhs_signaling function
[PATCH v9 08/10] mmc: sdhci: add function to get retunig timer count
[PATCH v9 09/10] mmc: sdhci: correct voltage support caps setting
[PATCH v9 10/10] mmc: sdhci: clean code for SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK selected

 drivers/mmc/core/sd.c          |   17 ---
 drivers/mmc/host/sdhci-pxav3.c |   39 ------
 drivers/mmc/host/sdhci.c       |  289 +++++++++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h       |   15 ++-
 include/linux/mmc/host.h       |    1 -
 include/linux/mmc/sdhci.h      |    1 +
 6 files changed, 197 insertions(+), 165 deletions(-)

