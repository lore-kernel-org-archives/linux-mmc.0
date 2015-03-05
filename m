From: kbuild test robot <fengguang.wu@intel.com>
Subject: [ulf.hansson-mmc:next 1/17] drivers/mmc/host/dw_mmc-exynos.c:480:5:
 sparse: symbol 'dw_mci_exynos_prepare_hs400_tuning' was not declared. Should
 it be static?
Date: Thu, 5 Mar 2015 18:02:54 +0800
Message-ID: <201503051843.EsoMldBU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Kukjin Kim <kgene@kernel.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

tree:   https://git.linaro.org/people/ulf.hansson/mmc next
head:   cc92508d8a444000ec259debaf7603faf77540de
commit: 880e5e640a1f39802da76d9570bed2d8456f302a [1/17] mmc: dw_mmc: exynos: Support eMMC's HS400 mode
reproduce:
  # apt-get install sparse
  git checkout 880e5e640a1f39802da76d9570bed2d8456f302a
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/mmc/host/dw_mmc-exynos.c:480:5: sparse: symbol 'dw_mci_exynos_prepare_hs400_tuning' was not declared. Should it be static?
--
>> drivers/mmc/host/dw_mmc.c:1327:5: sparse: symbol 'dw_mci_prepare_hs400_tuning' was not declared. Should it be static?
   drivers/mmc/host/dw_mmc.c:2913:1: sparse: symbol '__UNIQUE_ID_author__COUNTER__' has multiple initializers (originally initialized at drivers/mmc/host/dw_mmc.c:2912)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
