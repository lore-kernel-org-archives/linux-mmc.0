From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] mmc: host: tighten some of the dependencies on SoC
 drivers
Date: Thu, 25 May 2017 08:20:22 +0800
Message-ID: <201705250829.ZkURSD6Z%fengguang.wu@intel.com>
References: <20170524121556.27819-1-pbrobinson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:48478 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932158AbdEYAVY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 May 2017 20:21:24 -0400
Content-Disposition: inline
In-Reply-To: <20170524121556.27819-1-pbrobinson@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Wahren <stefan.wahren@i2se.com>, linux-mmc@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>

Hi Peter,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.12-rc2]
[cannot apply to next-20170524]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Robinson/mmc-host-tighten-some-of-the-dependencies-on-SoC-drivers/20170525-042816
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/mmc/host/tmio_mmc.h:276:9: sparse: undefined identifier 'readsl'
   drivers/mmc/host/tmio_mmc.h:304:9: sparse: undefined identifier 'writesl'
>> drivers/mmc/host/tmio_mmc.h:276:15: sparse: not a function <noident>
   drivers/mmc/host/tmio_mmc.h:304:16: sparse: not a function <noident>
   drivers/mmc/host/tmio_mmc.h:264:9: sparse: undefined identifier 'readsw'
   drivers/mmc/host/tmio_mmc.h:292:9: sparse: undefined identifier 'writesw'
   In file included from drivers/mmc/host/tmio_mmc_pio.c:53:0:
   drivers/mmc/host/tmio_mmc.h: In function 'sd_ctrl_read16_rep':
   drivers/mmc/host/tmio_mmc.h:264:2: error: implicit declaration of function 'readsw' [-Werror=implicit-function-declaration]
     readsw(host->ctl + (addr << host->bus_shift), buf, count);
     ^~~~~~
   drivers/mmc/host/tmio_mmc.h: In function 'sd_ctrl_read32_rep':
   drivers/mmc/host/tmio_mmc.h:276:2: error: implicit declaration of function 'readsl' [-Werror=implicit-function-declaration]
     readsl(host->ctl + (addr << host->bus_shift), buf, count);
     ^~~~~~
   drivers/mmc/host/tmio_mmc.h: In function 'sd_ctrl_write16_rep':
   drivers/mmc/host/tmio_mmc.h:292:2: error: implicit declaration of function 'writesw' [-Werror=implicit-function-declaration]
     writesw(host->ctl + (addr << host->bus_shift), buf, count);
     ^~~~~~~
   drivers/mmc/host/tmio_mmc.h: In function 'sd_ctrl_write32_rep':
   drivers/mmc/host/tmio_mmc.h:304:2: error: implicit declaration of function 'writesl' [-Werror=implicit-function-declaration]
     writesl(host->ctl + (addr << host->bus_shift), buf, count);
     ^~~~~~~
   cc1: some warnings being treated as errors

vim +276 drivers/mmc/host/tmio_mmc.h

a11862d3 Simon Horman      2011-06-21  260  
a11862d3 Simon Horman      2011-06-21  261  static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
a11862d3 Simon Horman      2011-06-21  262  		u16 *buf, int count)
a11862d3 Simon Horman      2011-06-21  263  {
7445bf9e Kuninori Morimoto 2015-01-13  264  	readsw(host->ctl + (addr << host->bus_shift), buf, count);
a11862d3 Simon Horman      2011-06-21  265  }
a11862d3 Simon Horman      2011-06-21  266  
2c54506b Wolfram Sang      2016-04-27  267  static inline u32 sd_ctrl_read16_and_16_as_32(struct tmio_mmc_host *host, int addr)
a11862d3 Simon Horman      2011-06-21  268  {
7445bf9e Kuninori Morimoto 2015-01-13  269  	return readw(host->ctl + (addr << host->bus_shift)) |
7445bf9e Kuninori Morimoto 2015-01-13  270  	       readw(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
a11862d3 Simon Horman      2011-06-21  271  }
a11862d3 Simon Horman      2011-06-21  272  
8185e51f Chris Brandt      2016-09-12  273  static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr,
8185e51f Chris Brandt      2016-09-12  274  		u32 *buf, int count)
8185e51f Chris Brandt      2016-09-12  275  {
8185e51f Chris Brandt      2016-09-12 @276  	readsl(host->ctl + (addr << host->bus_shift), buf, count);
8185e51f Chris Brandt      2016-09-12  277  }
8185e51f Chris Brandt      2016-09-12  278  
a11862d3 Simon Horman      2011-06-21  279  static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val)
a11862d3 Simon Horman      2011-06-21  280  {
973ed3af Simon Horman      2011-06-21  281  	/* If there is a hook and it returns non-zero then there
973ed3af Simon Horman      2011-06-21  282  	 * is an error and the write should be skipped
973ed3af Simon Horman      2011-06-21  283  	 */
dfe9a229 Kuninori Morimoto 2015-01-13  284  	if (host->write16_hook && host->write16_hook(host, addr))

:::::: The code at line 276 was first introduced by commit
:::::: 8185e51f358a8dd4801b67e8c66f03eb9eeaba75 mmc: tmio-mmc: add support for 32bit data port

:::::: TO: Chris Brandt <chris.brandt@renesas.com>
:::::: CC: Ulf Hansson <ulf.hansson@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
