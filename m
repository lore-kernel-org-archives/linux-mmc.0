From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/5] Some fixes for mmc core and sdhci/arasan
Date: Wed, 21 Sep 2016 09:43:48 +0800
Message-ID: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:35460 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754147AbcIUBna (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2016 21:43:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>


patch 1 is gonna fix the longstanding issues which may fail the
mmc_test. Per spec, block size is always 512 bytes for dual rate mode.
Any attempt to change it will be treated as illegal one.So we
need to check hs400(es) and DDR50 as well.

patch 2 and 3 actually fix my previous introduction for hs400es.
That happened to work for the controller and devices I was using
for test at that time. I believe Doug and Jaehoon didn't see failure
when testing it as well. After several numbers of compatibility test
and stability test for mass production, we are sure that patch 3 is
needed.

patch 4 also fix a longtanding issue of sdhci which try to switch
voltage without checking the cap. We found this issue as arasan,5.1
doesn't support VDD_330 but we still find sdhci try to switch to
3v3.

patch 5 will nak my patch[0]. It more or less looks like a hack from
Jaehoon's point. I think I find the root cause after numerous repro and
debug work with my ASIC team guys.

Thanks for Ziyuan Xu and Xiao Yao who help me test my massive hack patch
and finally we found what the problem is.

[0]: https://patchwork.kernel.org/patch/9238663



Shawn Lin (3):
  mmc: core: switch to 1V8 or 1V2 for hs400es mode
  mmc: core: changes frequency to hs_max_dtr when selecting hs400es
  mmc: sdhci-of-arasan: add sdhci_arasan_voltage_switch for arasan,5.1

Ziyuan Xu (2):
  mmc: core: don't try to switch block size for dual rate mode
  mmc: sdhci: Don't try to switch to unsupported voltage

 drivers/mmc/core/core.c            |  3 ++-
 drivers/mmc/core/mmc.c             | 12 ++++++++++++
 drivers/mmc/host/sdhci-of-arasan.c | 24 ++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c           |  6 ++++--
 4 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.3.7


