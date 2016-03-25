From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: allow the use of controller card
 detect as wake up
Date: Sat, 26 Mar 2016 01:11:10 +0800
Message-ID: <201603260102.emd05hRC%fengguang.wu@intel.com>
References: <1458921903-11133-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31655 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753820AbcCYRLh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Mar 2016 13:11:37 -0400
Content-Disposition: inline
In-Reply-To: <1458921903-11133-3-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: kbuild-all@01.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Hi Ludovic,

[auto build test WARNING on ulf.hansson-mmc/next]
[also build test WARNING on next-20160324]
[cannot apply to v4.5]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Ludovic-Desroches/mmc-sdhci-of-at91-allow-the-use-of-controller-card-detect-as-wake-up/20160326-001143
base:   https://git.linaro.org/people/ulf.hansson/mmc next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/mmc/host/sdhci-of-at91.c:94:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
