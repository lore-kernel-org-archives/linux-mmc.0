From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/3] mmc: pwrseq: convert to proper driver
Date: Wed,  2 Mar 2016 16:44:38 +0000
Message-ID: <1456937078-27241-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36515 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbcCBQo6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2016 11:44:58 -0500
Received: by mail-wm0-f47.google.com with SMTP id n186so94802818wmn.1
        for <linux-mmc@vger.kernel.org>; Wed, 02 Mar 2016 08:44:57 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mfuzzey@parkeon.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Ulf, 

Thanks for reviewing v2.

This patchset aims at converting the pwrseq devices to proper in drivers,
The issue is that on Qualcomm based platforms, most of the gpios require
a pinctrl setup. Existing pwrseq code does not do any kind of pinctrl setup.
So this makes the pwrseq unusable on those platfroms.

Convert the pwrseq to proper drivers so that they can reuse
common driver setup like pinctrl from drivers/base/pinctrl.c and clocks.
This solution works much better and would make pwrseq to reuse 
all the driver setup done in the common code.


Changes since v2: All changes suggested by Ulf
	- Moved all the allocations/gpio_get/clk_get to probe
	- Removed alloc and free callbacks
	- try_get_module inside a mutex
	- Fixed Kconfigs
	- renamed list to pwrseq_node
	- add mssing pdev_set_drvdata()

Changes since v1:
	- Fixed issue while building as module.

Changes since RFC:
	- Fixed issues reported by kbuild test robot.
	- return EPROBE_DEFER from *_alloc() suggested by Ulf.

Thanks,
srini

Srinivas Kandagatla (3):
  mmc: pwrseq_simple: add to_pwrseq_simple() macro
  mmc: pwrseq_emmc: add to_pwrseq_emmc() macro
  mmc: pwrseq: convert to proper platform device

 drivers/mmc/core/Kconfig         |  21 ++++++++
 drivers/mmc/core/Makefile        |   4 +-
 drivers/mmc/core/pwrseq.c        | 105 +++++++++++++++++----------------------
 drivers/mmc/core/pwrseq.h        |  19 ++++---
 drivers/mmc/core/pwrseq_emmc.c   |  81 ++++++++++++++++++------------
 drivers/mmc/core/pwrseq_simple.c |  91 +++++++++++++++++----------------
 6 files changed, 182 insertions(+), 139 deletions(-)

-- 
1.9.1

