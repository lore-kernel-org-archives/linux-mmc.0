From: kbuild test robot <fengguang.wu@intel.com>
Subject: [ulf.hansson-mmc:next 84/84] drivers/mmc/host/dw_mmc.c:1953:9:
 sparse: incompatible types in comparison expression (different type sizes)
Date: Thu, 2 Nov 2017 02:19:11 +0800
Message-ID: <201711020209.Ik9aC6Yo%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:47777 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbdKASTr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Nov 2017 14:19:47 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: kbuild-all@01.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
head:   80a2a5a7745b1f65198fb11da9a8d1d38c3003d5
commit: 80a2a5a7745b1f65198fb11da9a8d1d38c3003d5 [84/84] mmc: dw_mmc: Cleanup the DTO timer like the CTO one
reproduce:
        # apt-get install sparse
        git checkout 80a2a5a7745b1f65198fb11da9a8d1d38c3003d5
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +1953 drivers/mmc/host/dw_mmc.c

  1935	
  1936	static void dw_mci_set_drto(struct dw_mci *host)
  1937	{
  1938		unsigned int drto_clks;
  1939		unsigned int drto_div;
  1940		unsigned int drto_ms;
  1941		unsigned int irqflags;
  1942	
  1943		drto_clks = mci_readl(host, TMOUT) >> 8;
  1944		drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
  1945		if (drto_div == 0)
  1946			drto_div = 1;
  1947		drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
  1948				       host->bus_hz);
  1949	
  1950		/* add a bit spare time */
  1951		drto_ms += 10;
  1952	
> 1953		spin_lock_irqsave(&host->irq_lock, irqflags);
  1954		if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
  1955			mod_timer(&host->dto_timer,
  1956				  jiffies + msecs_to_jiffies(drto_ms));
  1957		spin_unlock_irqrestore(&host->irq_lock, irqflags);
  1958	}
  1959	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
