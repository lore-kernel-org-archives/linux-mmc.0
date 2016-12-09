From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 08/12] mmc: sdhci-xenon: Add support to PHYs of
 Marvell Xenon SDHC.
Date: Sat, 10 Dec 2016 02:27:50 +0800
Message-ID: <201612100213.2R0DRXrE%fengguang.wu@intel.com>
References: <fd1e454d2d8c30c4b191ae78e911d481315352e0.1481279228.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61102 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751397AbcLIS2o (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Dec 2016 13:28:44 -0500
Content-Disposition: inline
In-Reply-To: <fd1e454d2d8c30c4b191ae78e911d481315352e0.1481279228.git-series.gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Hanna

Hi Hu,

[auto build test WARNING on ]

url:    https://github.com/0day-ci/linux/commits/Gregory-CLEMENT/mmc-Add-support-to-Marvell-Xenon-SD-Host-Controller/20161210-002602
base:    


coccinelle warnings: (new ones prefixed by >>)

>> drivers/mmc/host/sdhci-xenon-phy.c:469:9-10: WARNING: return of 0/1 in function 'emmc_phy_slow_mode' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
