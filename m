From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v3 01/11] mmc: sdhci: fixes and enhancements
Date: Tue, 25 Sep 2012 18:38:55 +0800
Message-ID: <1348569546-13242-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:51505 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755091Ab2IYKoX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 06:44:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com


This patchset does as follows:
[PATCH v3 01/11] mmc: sdhci: fix transfer mode setting bug for cmds w/o data transfer
[PATCH v3 02/11] mmc: sdhci: set regulator min/max voltage according to spec
[PATCH v3 03/11] mmc: sdhci: refine code for sd clock disable/enable in set ios
[PATCH v3 04/11] mmc: sdhci: keep the saved clock var up to date
[PATCH v3 05/11] mmc: sdhci: fix null return check of regulator_get
[PATCH v3 06/11] mmc: sdhci-pxav3: controller can't get base clock
[PATCH v3 07/11] mmc: host: adjust uhs timing value
[PATCH v3 08/11] mmc: sdhci: enhance preset value function
[PATCH v3 09/11] mmc: sdhci-pxav3: add quirks2
[PATCH v3 10/11] mmc: sdhci: introduce signal_voltage_switch callback function
[PATCH v3 11/11] mmc: sdhci-pxav3: add signal_voltage_switch function

changelog v1->v2:
	- remove the patch "mmc: sdhci-pxav3: fix build error"
	- update the patch "mmc: sdhci: fix null return check of regulator_get"
	- add the patch "mmc: sdhci-pxav3: controller can't get base clock"
	- add the patch "mmc: host: adjust uhs timing value"
	- add the patch "mmc: sdhci: enhance preset value function"
changelog v2->v3:
	- add the patch "mmc: sdhci-pxav3: add quirks2"
	- add the patch "mmc: sdhci: introduce signal_voltage_switch callback function"
	- add the patch "mmc: sdhci-pxav3: add signal_voltage_switch function"
	- update some comments

Kevin Liu (11):
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

 drivers/mmc/core/sd.c                   |   17 ---
 drivers/mmc/host/sdhci-pxav3.c          |   30 ++++-
 drivers/mmc/host/sdhci.c                |  238 ++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h                |   13 ++
 include/linux/mmc/host.h                |   13 +-
 include/linux/mmc/sdhci.h               |    2 +-
 include/linux/platform_data/pxa_sdhci.h |    4 +
 7 files changed, 206 insertions(+), 111 deletions(-)
