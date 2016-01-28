From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/3] mmc: pwrseq: convert to proper driver
Date: Thu, 28 Jan 2016 10:01:55 +0000
Message-ID: <1453975315-13424-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38443 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966454AbcA1KDE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 05:03:04 -0500
Received: by mail-wm0-f50.google.com with SMTP id p63so16878445wmp.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Jan 2016 02:03:02 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mfuzzey@parkeon.com, linux-arm-kernel@lists.infradead.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Ulf, 

This patchset aims at converting the pwrseq devices to proper in drivers,
The issue is that on Qualcomm based platforms, most of the gpios require
a pinctrl setup. Existing pwrseq code does not do any kind of pinctrl setup.
So this makes the pwrseq unusable on those platfroms.

Convert the pwrseq to proper drivers so that they can reuse
common driver setup like pinctrl from drivers/base/pinctrl.c and clocks.
This solution works much better and would make pwrseq to reuse 
all the driver setup done in the common code.


Changes sinc v1:
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

 drivers/mmc/Kconfig              |   2 +
 drivers/mmc/core/Kconfig         |   7 +++
 drivers/mmc/core/Makefile        |   4 +-
 drivers/mmc/core/pwrseq.c        | 115 +++++++++++++++++++++------------------
 drivers/mmc/core/pwrseq.h        |  19 +++++--
 drivers/mmc/core/pwrseq_emmc.c   |  89 +++++++++++++++++++++---------
 drivers/mmc/core/pwrseq_simple.c |  99 ++++++++++++++++++++++-----------
 7 files changed, 217 insertions(+), 118 deletions(-)

-- 
1.9.1

