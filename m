From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 0/3] mmc: pwrseq: convert to proper driver
Date: Wed, 20 Jan 2016 10:45:30 +0000
Message-ID: <1453286730-9616-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36625 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934569AbcATKqE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2016 05:46:04 -0500
Received: by mail-wm0-f51.google.com with SMTP id l65so173544838wmf.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2016 02:46:03 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Ulf, 

This patchset aims at converting the pwrseq devices to proper in built drivers,
The issue is that on Qualcomm based platforms, most of the gpios require
a pinctrl setup. Existing pwrseq code does not do any kind of pinctrl setup.
So this makes the pwrseq unusable on those platfroms.

Convert the pwrseq to proper drivers so that they can reuse
common driver setup like pinctrl from drivers/base/pinctrl.c
This solution works much better and would make pwrseq to reuse 
all the driver setup done in the common code.


Changes since RFC:
	- Fixed issues reported by kbuild test robot.
	- return EPROBE_DEFER from *_alloc() suggested by Ulf.

Thanks,
srini

Srinivas Kandagatla (3):
  mmc: pwrseq_simple: add to_pwrseq_simple() macro
  mmc: pwrseq_emmc: add to_pwrseq_emmc() macro
  mmc: pwrseq: convert to proper platform device

 drivers/mmc/core/pwrseq.c        | 112 +++++++++++++++++++++------------------
 drivers/mmc/core/pwrseq.h        |  13 +++--
 drivers/mmc/core/pwrseq_emmc.c   |  74 ++++++++++++++++----------
 drivers/mmc/core/pwrseq_simple.c |  86 ++++++++++++++++++------------
 4 files changed, 168 insertions(+), 117 deletions(-)

-- 
1.9.1

