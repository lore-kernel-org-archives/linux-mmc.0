Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682AFC05027
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 00:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjBMAnG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Feb 2023 19:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMAnF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Feb 2023 19:43:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD880F746
        for <linux-mmc@vger.kernel.org>; Sun, 12 Feb 2023 16:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676248983; x=1707784983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sBNj1QHYdBN33eLrS+RyBEj73uBhR6ouLIWK76qVhWg=;
  b=FvVcdfFM6gkQ+Lu934N8128Vz0e3CT/BUpyaX9IXdRiZT1OSP6u0+W/B
   zAfUA6B1JvZoMolVxkapIymIEgIDbuU0sNuEQsCJN0khR49yvtfo1YwOp
   2gHg8otUggg9ERlYpPyuaQXiYIq8/up8HCy+l/HHnpI/U+G8YsGCwAp7d
   GqUL2VWkVQQyExF+QEwPe17U+ySeOeTdk8U7CT+6sU5Cq535lDQIsZiG+
   3NvaxYfpgd/AjGCt4E7JGyqRnClxwMGfQ3ahr5bcxXBHL29rGRzL5PChf
   wUPXMDO2zVVtbK7tiuoCznSe1SBQVdSNdvYPOHj7Qa2/ceMOdwoFkGSuu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="358188882"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="358188882"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 16:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="646207242"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="646207242"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2023 16:43:00 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRMvr-0007Sv-0X;
        Mon, 13 Feb 2023 00:42:59 +0000
Date:   Mon, 13 Feb 2023 08:42:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: fix SDIO mode if cap_sdio_irq isn't set
Message-ID: <202302130854.oj1Vrs2F-lkp@intel.com>
References: <9e296859-0363-ecc4-2d99-fd0239efceff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e296859-0363-ecc4-2d99-fd0239efceff@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Heiner,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc8 next-20230210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiner-Kallweit/mmc-meson-gx-fix-SDIO-mode-if-cap_sdio_irq-isn-t-set/20230213-055650
patch link:    https://lore.kernel.org/r/9e296859-0363-ecc4-2d99-fd0239efceff%40gmail.com
patch subject: [PATCH] mmc: meson-gx: fix SDIO mode if cap_sdio_irq isn't set
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230213/202302130854.oj1Vrs2F-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6aca20b626a6d75b5d74fc4441cdd99ff3252b23
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Heiner-Kallweit/mmc-meson-gx-fix-SDIO-mode-if-cap_sdio_irq-isn-t-set/20230213-055650
        git checkout 6aca20b626a6d75b5d74fc4441cdd99ff3252b23
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302130854.oj1Vrs2F-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:566,
                    from include/linux/kernel.h:29,
                    from drivers/mmc/host/meson-gx-mmc.c:8:
   drivers/mmc/host/meson-gx-mmc.c: In function 'meson_mmc_irq':
>> drivers/mmc/host/meson-gx-mmc.c:962:25: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u32' {aka 'unsigned int'} [-Wformat=]
     962 |                         "Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:223:29: note: in definition of macro '__dynamic_func_call_cls'
     223 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
     249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:272:9: note: in expansion of macro '_dynamic_func_call'
     272 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/mmc/host/meson-gx-mmc.c:961:17: note: in expansion of macro 'dev_dbg'
     961 |                 dev_dbg(host->dev,
         |                 ^~~~~~~
   drivers/mmc/host/meson-gx-mmc.c:962:55: note: format string is defined here
     962 |                         "Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
         |                                                   ~~~~^
         |                                                       |
         |                                                       long unsigned int
         |                                                   %08x


vim +962 drivers/mmc/host/meson-gx-mmc.c

066ecde6d826b4 Heiner Kallweit     2022-08-25   947  
51c5d8447bd71b Kevin Hilman        2016-10-19   948  static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
51c5d8447bd71b Kevin Hilman        2016-10-19   949  {
51c5d8447bd71b Kevin Hilman        2016-10-19   950  	struct meson_host *host = dev_id;
19a91dd4e39e75 Heinrich Schuchardt 2016-12-23   951  	struct mmc_command *cmd;
6aca20b626a6d7 Heiner Kallweit     2023-02-12   952  	u32 status, raw_status, irq_mask = IRQ_EN_MASK;
74858655cbff05 Jerome Brunet       2017-08-28   953  	irqreturn_t ret = IRQ_NONE;
51c5d8447bd71b Kevin Hilman        2016-10-19   954  
6aca20b626a6d7 Heiner Kallweit     2023-02-12   955  	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
6aca20b626a6d7 Heiner Kallweit     2023-02-12   956  		irq_mask |= IRQ_SDIO;
18f92bc02f1739 Jerome Brunet       2018-12-06   957  	raw_status = readl(host->regs + SD_EMMC_STATUS);
6aca20b626a6d7 Heiner Kallweit     2023-02-12   958  	status = raw_status & irq_mask;
18f92bc02f1739 Jerome Brunet       2018-12-06   959  
18f92bc02f1739 Jerome Brunet       2018-12-06   960  	if (!status) {
18f92bc02f1739 Jerome Brunet       2018-12-06   961  		dev_dbg(host->dev,
6f6fac8af6be0f Heiner Kallweit     2022-08-25  @962  			"Unexpected IRQ! irq_en 0x%08lx - status 0x%08x\n",
6aca20b626a6d7 Heiner Kallweit     2023-02-12   963  			 irq_mask, raw_status);
18f92bc02f1739 Jerome Brunet       2018-12-06   964  		return IRQ_NONE;
18f92bc02f1739 Jerome Brunet       2018-12-06   965  	}
18f92bc02f1739 Jerome Brunet       2018-12-06   966  
066ecde6d826b4 Heiner Kallweit     2022-08-25   967  	if (WARN_ON(!host))
51c5d8447bd71b Kevin Hilman        2016-10-19   968  		return IRQ_NONE;
51c5d8447bd71b Kevin Hilman        2016-10-19   969  
c2c1e63a80d6e9 Jerome Brunet       2019-05-23   970  	/* ack all raised interrupts */
c2c1e63a80d6e9 Jerome Brunet       2019-05-23   971  	writel(status, host->regs + SD_EMMC_STATUS);
c2c1e63a80d6e9 Jerome Brunet       2019-05-23   972  
74858655cbff05 Jerome Brunet       2017-08-28   973  	cmd = host->cmd;
066ecde6d826b4 Heiner Kallweit     2022-08-25   974  
066ecde6d826b4 Heiner Kallweit     2022-08-25   975  	if (status & IRQ_SDIO) {
066ecde6d826b4 Heiner Kallweit     2022-08-25   976  		spin_lock(&host->lock);
066ecde6d826b4 Heiner Kallweit     2022-08-25   977  		__meson_mmc_enable_sdio_irq(host->mmc, 0);
066ecde6d826b4 Heiner Kallweit     2022-08-25   978  		sdio_signal_irq(host->mmc);
066ecde6d826b4 Heiner Kallweit     2022-08-25   979  		spin_unlock(&host->lock);
066ecde6d826b4 Heiner Kallweit     2022-08-25   980  		status &= ~IRQ_SDIO;
066ecde6d826b4 Heiner Kallweit     2022-08-25   981  		if (!status)
066ecde6d826b4 Heiner Kallweit     2022-08-25   982  			return IRQ_HANDLED;
066ecde6d826b4 Heiner Kallweit     2022-08-25   983  	}
066ecde6d826b4 Heiner Kallweit     2022-08-25   984  
066ecde6d826b4 Heiner Kallweit     2022-08-25   985  	if (WARN_ON(!cmd))
066ecde6d826b4 Heiner Kallweit     2022-08-25   986  		return IRQ_NONE;
066ecde6d826b4 Heiner Kallweit     2022-08-25   987  
51c5d8447bd71b Kevin Hilman        2016-10-19   988  	cmd->error = 0;
74858655cbff05 Jerome Brunet       2017-08-28   989  	if (status & IRQ_CRC_ERR) {
74858655cbff05 Jerome Brunet       2017-08-28   990  		dev_dbg(host->dev, "CRC Error - status 0x%08x\n", status);
51c5d8447bd71b Kevin Hilman        2016-10-19   991  		cmd->error = -EILSEQ;
18f92bc02f1739 Jerome Brunet       2018-12-06   992  		ret = IRQ_WAKE_THREAD;
74858655cbff05 Jerome Brunet       2017-08-28   993  		goto out;
51c5d8447bd71b Kevin Hilman        2016-10-19   994  	}
74858655cbff05 Jerome Brunet       2017-08-28   995  
74858655cbff05 Jerome Brunet       2017-08-28   996  	if (status & IRQ_TIMEOUTS) {
74858655cbff05 Jerome Brunet       2017-08-28   997  		dev_dbg(host->dev, "Timeout - status 0x%08x\n", status);
51c5d8447bd71b Kevin Hilman        2016-10-19   998  		cmd->error = -ETIMEDOUT;
18f92bc02f1739 Jerome Brunet       2018-12-06   999  		ret = IRQ_WAKE_THREAD;
74858655cbff05 Jerome Brunet       2017-08-28  1000  		goto out;
51c5d8447bd71b Kevin Hilman        2016-10-19  1001  	}
74858655cbff05 Jerome Brunet       2017-08-28  1002  
74858655cbff05 Jerome Brunet       2017-08-28  1003  	meson_mmc_read_resp(host->mmc, cmd);
74858655cbff05 Jerome Brunet       2017-08-28  1004  
2c8d96a46dfd45 Heiner Kallweit     2017-03-22  1005  	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
066ecde6d826b4 Heiner Kallweit     2022-08-25  1006  		struct mmc_data *data = cmd->data;
066ecde6d826b4 Heiner Kallweit     2022-08-25  1007  
2c8d96a46dfd45 Heiner Kallweit     2017-03-22  1008  		if (data && !cmd->error)
2c8d96a46dfd45 Heiner Kallweit     2017-03-22  1009  			data->bytes_xfered = data->blksz * data->blocks;
79ed05e329c34c Heiner Kallweit     2017-04-07  1010  		if (meson_mmc_bounce_buf_read(data) ||
79ed05e329c34c Heiner Kallweit     2017-04-07  1011  		    meson_mmc_get_next_command(cmd))
51c5d8447bd71b Kevin Hilman        2016-10-19  1012  			ret = IRQ_WAKE_THREAD;
74858655cbff05 Jerome Brunet       2017-08-28  1013  		else
74858655cbff05 Jerome Brunet       2017-08-28  1014  			ret = IRQ_HANDLED;
51c5d8447bd71b Kevin Hilman        2016-10-19  1015  	}
51c5d8447bd71b Kevin Hilman        2016-10-19  1016  
51c5d8447bd71b Kevin Hilman        2016-10-19  1017  out:
18f92bc02f1739 Jerome Brunet       2018-12-06  1018  	if (cmd->error) {
18f92bc02f1739 Jerome Brunet       2018-12-06  1019  		/* Stop desc in case of errors */
18f92bc02f1739 Jerome Brunet       2018-12-06  1020  		u32 start = readl(host->regs + SD_EMMC_START);
18f92bc02f1739 Jerome Brunet       2018-12-06  1021  
18f92bc02f1739 Jerome Brunet       2018-12-06  1022  		start &= ~START_DESC_BUSY;
18f92bc02f1739 Jerome Brunet       2018-12-06  1023  		writel(start, host->regs + SD_EMMC_START);
18f92bc02f1739 Jerome Brunet       2018-12-06  1024  	}
18f92bc02f1739 Jerome Brunet       2018-12-06  1025  
1f8066d90739eb Heiner Kallweit     2017-03-22  1026  	if (ret == IRQ_HANDLED)
51c5d8447bd71b Kevin Hilman        2016-10-19  1027  		meson_mmc_request_done(host->mmc, cmd->mrq);
51c5d8447bd71b Kevin Hilman        2016-10-19  1028  
51c5d8447bd71b Kevin Hilman        2016-10-19  1029  	return ret;
51c5d8447bd71b Kevin Hilman        2016-10-19  1030  }
51c5d8447bd71b Kevin Hilman        2016-10-19  1031  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
