From: kbuild test robot <fengguang.wu@intel.com>
Subject: [ulf.hansson-mmc:next 27/28] drivers/mmc/core/block.c:2106:9-10:
 WARNING: return of 0/1 in function 'mmc_blk_status_error' with return type
 bool
Date: Thu, 30 Nov 2017 05:54:24 +0800
Message-ID: <201711300522.IoizUSEn%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11625 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751828AbdK2Vz7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 29 Nov 2017 16:55:59 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: kbuild-all@01.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
head:   98f67755cf2dc07fc0d79c534deb28634b58e391
commit: 89eb3e6b5f77fe3d5579adc13f75d610487e03c3 [27/28] mmc: block: blk-mq: Stop using legacy recovery


coccinelle warnings: (new ones prefixed by >>)

>> drivers/mmc/core/block.c:2106:9-10: WARNING: return of 0/1 in function 'mmc_blk_status_error' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
