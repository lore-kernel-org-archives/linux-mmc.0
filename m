From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 0/3] Fix fixed regulators support
Date: Tue, 04 Dec 2012 15:01:00 +0100
Message-ID: <1354629663-29091-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:31788 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab2LDOB0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Dec 2012 09:01:26 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>, Kevin Liu <keyuan.liu@gmail.com>

Hello,

Commit f0f98b19e23d4426ca185e3d4ca80e6aff5ef51b revealed that the support for
fixed regulators in SDHCI driver was working only by pure luck. My previous
patch set for fixing this issue resulted in a discussion, which has been
concluded that this issue should by fixed by extending regulators core by
regualtor_can_change_voltage() function and using it in the mmc/sdhci drivers.

For more information, please refer to the following threads:
http://thread.gmane.org/gmane.linux.kernel.mmc/17643
https://patchwork.kernel.org/patch/1739061/

Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (3):
  regulators: add regulator_can_change_voltage() function
  mmc: use regulator_can_change_voltage() instead of
    regulator_count_voltages() hacks
  mmc: sdhci: check voltage range only on regulators aware of voltage
    value

 drivers/mmc/core/core.c            |    2 +-
 drivers/mmc/host/sdhci.c           |    6 +++++-
 drivers/regulator/core.c           |   22 ++++++++++++++++++++++
 include/linux/regulator/consumer.h |    1 +
 4 files changed, 29 insertions(+), 2 deletions(-)

-- 
1.7.9.5

