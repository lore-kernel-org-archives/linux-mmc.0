From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 0/3] mmc: pwrseq: convert to proper driver
Date: Tue, 19 Jan 2016 10:57:32 +0000
Message-ID: <1453201052-2347-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf, 

This patchset aims at converting the pwrseq devices to proper in built drivers,
The issue is that on Qualcomm based platforms, most of the gpios require
a pinctrl setup. Existing pwrseq code does not do any kind of pinctrl setup.
So this makes the pwrseq unusable on those platfroms.

There are two possible solutions to this isssue.
1. Convert the pwrseq to proper drivers so that they can reuse
common driver setup like pinctrl from drivers/base/pinctrl.c

2. copy pinctrl_bind_pins() code and modify to fit pwrseq.

IMO, solution 1 works much better and would make pwrseq to reuse 
all the driver setup done in the common code.

Thanks,
srini

Srinivas Kandagatla (3):
  mmc: pwrseq_simple: add to_pwrseq_simple() macro
  mmc: pwrseq_emmc: add to_pwrseq_emmc() macro
  mmc: pwrseq: convert to proper platform device

 drivers/mmc/core/pwrseq.c        | 99 ++++++++++++++++++++--------------------
 drivers/mmc/core/pwrseq.h        | 13 ++++--
 drivers/mmc/core/pwrseq_emmc.c   | 73 ++++++++++++++++++-----------
 drivers/mmc/core/pwrseq_simple.c | 85 ++++++++++++++++++++--------------
 4 files changed, 155 insertions(+), 115 deletions(-)

-- 
1.9.1
