From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci: Build o2micro support in the same
 module
Date: Tue, 6 Oct 2015 04:01:04 +0800
Message-ID: <201510060335.Yp1RsHmL%fengguang.wu@intel.com>
References: <1444073478.2730.308.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6365 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253AbbJEUCi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Oct 2015 16:02:38 -0400
Content-Disposition: inline
In-Reply-To: <1444073478.2730.308.camel@decadent.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, Peter Guo <peter.guo@bayhubtech.com>, linux-mmc@vger.kernel.org

Hi Ben,

[auto build test WARNING on v4.3-rc4 -- if it's inappropriate base, please ignore]


coccinelle warnings: (new ones prefixed by >>)

>> drivers/mmc/host/sdhci-pci-core.c:447:1-4: WARNING: end returns can be simpified

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
