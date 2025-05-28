Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900732206A7;
	Wed, 28 May 2025 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473026; cv=none; b=Q9TwfH9E2ti6ca6rnyhQ+8jrO+H+ZmE/aLaIvtwGLwEf56SUvTUE0XIgSVxM2NgZexIC3iBeA4A+nKOuhk96luR9nVlifVdPZv9rRbH0eD9l2N3UCEaBHKtV6jdVuO532bIpyiVriV3pCzvzRFrMGSr+tJfi0L5rEFTCvrSBPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473026; c=relaxed/simple;
	bh=5ZmfanPQmTtVk2YHRo7PTIkRByqp8zV7HgvMhOjuEaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOQpdntWwC7gpkjKMIykEI1yzb7aRUSE+k7xqR9wevlSn6xIYql3+kywtkUdQpGHeKtP5d/QRbGBzCzxjethjmfZNMvpatcHelNIq3ufxFy2P1cvwxrquNL8f+qXzD4fdX+rYJxszdSd1Zzy//WQCzQ6QGRGFgwpGC37vkgvD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYL7yYkS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYL7yYkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748473025; x=1780009025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ZmfanPQmTtVk2YHRo7PTIkRByqp8zV7HgvMhOjuEaE=;
  b=MYL7yYkSVwcjKDjrKcVF/yWDF9kF+kRn5l0vZmUvSGQ6ETwVChEGsy55
   /7ApZ1V7WUPOHHKtDRCM4FCV0K4EA/K11IhJ9qfDdwa0y1/iZ9Rm7IsIT
   4hwcvf8VV+hi+lVOZtmRWVCyuDLBGWO3FGbR7effhxo5Q5lbaJiDmw193
   ccr1CMfdkyKHsDoAz83vLj6/MF5AF/fuLeRf9J6+uUVv9bJt8TJyF+UNn
   KAvj1Md3T/6GFjUEDrpbiyZewGY/xsGwm72/jNZh7DIIQqlYOk+YDc/Vv
   PCexiJidjcR/GMahOSLbXLFK/FXfSJHWk/4j82xVpnXer9ngOgMZnvXS2
   Q==;
X-CSE-ConnectionGUID: VJbzP0U2RA2QAfmShlq6CQ==
X-CSE-MsgGUID: zd8gb344QR+LelUZjFzcfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61872050"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="61872050"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 15:57:04 -0700
X-CSE-ConnectionGUID: waQsBLFURWetypniVRmNwg==
X-CSE-MsgGUID: K18uDSK1REGKaNJx/2ZpZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="174259087"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 May 2025 15:56:59 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKPhh-000W8G-1z;
	Wed, 28 May 2025 22:56:57 +0000
Date: Thu, 29 May 2025 06:56:31 +0800
From: kernel test robot <lkp@intel.com>
To: Albert Yang <yangzh0906@thundersoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ge Gordon <gordon.ge@bst.ai>
Cc: oe-kbuild-all@lists.linux.dev,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Shan-Chun Hung <shanchun1218@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: Re: [PATCH v1 5/9] mmc: sdhci: add Black Sesame Technologies BST
 C1200 controller driver
Message-ID: <202505290615.GZzN5rNL-lkp@intel.com>
References: <20250528085453.481320-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528085453.481320-1-yangzh0906@thundersoft.com>

Hi Albert,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm64/for-next/core soc/for-next krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next linus/master v6.15 next-20250528]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Albert-Yang/dt-bindings-vendor-prefixes-Add-Black-Sesame-Technologies-Co-Ltd/20250528-190614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250528085453.481320-1-yangzh0906%40thundersoft.com
patch subject: [PATCH v1 5/9] mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
config: i386-randconfig-002-20250529 (https://download.01.org/0day-ci/archive/20250529/202505290615.GZzN5rNL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505290615.GZzN5rNL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505290615.GZzN5rNL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-of-bst-c1200.c:64:6: warning: no previous prototype for 'sdhci_bst_print_vendor' [-Wmissing-prototypes]
      64 | void sdhci_bst_print_vendor(struct sdhci_host *host)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-of-bst-c1200.c:153:6: warning: no previous prototype for 'sdhci_enable_bst_clk' [-Wmissing-prototypes]
     153 | void sdhci_enable_bst_clk(struct sdhci_host *host, unsigned int clk)
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-of-bst-c1200.c:245:6: warning: no previous prototype for 'sdhci_set_bst_clock' [-Wmissing-prototypes]
     245 | void sdhci_set_bst_clock(struct sdhci_host *host, unsigned int clock)
         |      ^~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-of-bst-c1200.c: In function 'bst_sdhci_execute_tuning':
>> drivers/mmc/host/sdhci-of-bst-c1200.c:323:13: warning: unused variable 'val' [-Wunused-variable]
     323 |         u32 val;
         |             ^~~
   drivers/mmc/host/sdhci-of-bst-c1200.c: At top level:
>> drivers/mmc/host/sdhci-of-bst-c1200.c:507:5: warning: no previous prototype for 'bst_sdhci_setup_host' [-Wmissing-prototypes]
     507 | int bst_sdhci_setup_host(struct sdhci_host *host)
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-of-bst-c1200.c: In function 'bst_sdhci_setup_host':
>> drivers/mmc/host/sdhci-of-bst-c1200.c:515:14: warning: variable 'enable_vqmmc' set but not used [-Wunused-but-set-variable]
     515 |         bool enable_vqmmc = false;
         |              ^~~~~~~~~~~~
>> drivers/mmc/host/sdhci-of-bst-c1200.c:513:13: warning: variable 'max_clk' set but not used [-Wunused-but-set-variable]
     513 |         u32 max_clk;
         |             ^~~~~~~


vim +/sdhci_bst_print_vendor +64 drivers/mmc/host/sdhci-of-bst-c1200.c

    63	
  > 64	void sdhci_bst_print_vendor(struct sdhci_host *host)
    65	{
    66		SDHCI_DUMP_BST("============ SDHCI VENDOR REGISTER DUMP ===========\n");
    67	
    68		SDHCI_DUMP_BST("VER_ID:  0x%08x | VER_TPYE:  0x%08x\n",
    69			       sdhci_readl(host, SDHC_MHSC_VER_ID_R),
    70			       sdhci_readl(host, SDHC_MHSC_VER_TPYE_R));
    71		SDHCI_DUMP_BST("MHSC_CTRL:  0x%08x | MBIU_CTRL:  0x%08x\n",
    72			       sdhci_readw(host, SDHC_MHSC_CTRL_R),
    73			       sdhci_readw(host, SDHC_MBIU_CTRL_R));
    74		SDHCI_DUMP_BST("EMMC_CTRL:  0x%08x | BOOT_CTRL: 0x%08x\n",
    75			       sdhci_readl(host, SDHC_EMMC_CTRL_R),
    76			       sdhci_readw(host, SDHC_BOOT_CTRL_R));
    77		SDHCI_DUMP_BST("GP_IN:   0x%08x | GP_OUT: 0x%08x\n",
    78			       sdhci_readl(host, SDHC_GP_IN_R),
    79			       sdhci_readb(host, SDHC_GP_OUT_R));
    80		SDHCI_DUMP_BST("AT_CTRL:     0x%08x | AT_STAT:  0x%08x\n",
    81			       sdhci_readb(host, SDHC_AT_CTRL_R),
    82			       sdhci_readb(host, SDHC_AT_STAT_R));
    83	}
    84	EXPORT_SYMBOL_GPL(sdhci_bst_print_vendor);
    85	
    86	static u32 bst_read_phys_bst(u32 phys_addr)
    87	{
    88		u32 phys_addr_page = phys_addr & 0xFFFFE000;
    89		u32 phys_offset = phys_addr & 0x00001FFF;
    90		u32 map_size = phys_offset + sizeof(u32);
    91		u32 ret = 0xDEADBEEF;
    92		void *mem_mapped = ioremap(phys_addr_page, map_size);
    93	
    94		if (mem_mapped) {
    95			ret = (u32)ioread32(((u8 *)mem_mapped) + phys_offset);
    96			iounmap(mem_mapped);
    97		}
    98	
    99		return ret;
   100	}
   101	
   102	static void bst_write_phys_bst(u32 phys_addr, u32 value)
   103	{
   104		u32 phys_addr_page = phys_addr & 0xFFFFE000;
   105		u32 phys_offset = phys_addr & 0x00001FFF;
   106		u32 map_size = phys_offset + sizeof(u32);
   107		void *mem_mapped = ioremap(phys_addr_page, map_size);
   108	
   109		if (mem_mapped) {
   110			iowrite32(value, ((u8 *)mem_mapped) + phys_offset);
   111			iounmap(mem_mapped);
   112		}
   113	}
   114	
   115	static unsigned int bst_get_max_clock(struct sdhci_host *host)
   116	{
   117		return host->mmc->f_max;
   118	}
   119	
   120	static unsigned int bst_get_min_clock(struct sdhci_host *host)
   121	{
   122		return host->mmc->f_min;
   123	}
   124	
   125	struct rx_ctrl {
   126		struct {
   127			u32 rx_revert:1;
   128			u32 rx_clk_sel_sec:1;
   129			u32 rx_clk_div:4;
   130			u32 rx_clk_phase_inner:2;
   131			u32 rx_clk_sel_first:1;
   132			u32 rx_clk_phase_out:2;
   133			u32 rx_clk_en:1;
   134			u32 res0:20;
   135		} bit;
   136		u32 reg;
   137	};
   138	
   139	struct sdmmc_iocfg {
   140		struct {
   141			u32 res0:16;
   142			u32 SC_SDMMC0_PVDD18POCSD0:2;
   143			u32 SC_SDMMC0_PVDD18POCSD1:2;
   144			u32 SC_SDMMC0_PVDD18POCSD2:2;
   145			u32 SC_SDMMC1_PVDD18POCSD0:2;
   146			u32 SC_SDMMC1_PVDD18POCSD1:2;
   147			u32 SC_SDMMC1_PVDD18POCSD2:2;
   148			u32 res1:4;
   149		} bit;
   150		u32 reg;
   151	};
   152	
 > 153	void sdhci_enable_bst_clk(struct sdhci_host *host, unsigned int clk)
   154	{
   155		struct sdhci_pltfm_host *pltfm_host;
   156		struct dwcmshc_priv *priv;
   157		unsigned int div;
   158		u32 val;
   159		struct rx_ctrl rx_reg;
   160	
   161		pltfm_host = sdhci_priv(host);
   162		priv = sdhci_pltfm_priv(pltfm_host);
   163		if (clk == 0) {
   164			div = clk;
   165		} else if (clk > default_max_freq) {
   166			div = clk / 1000;
   167			div = default_max_freq / div;
   168		} else if (clk < 1500) {
   169			div = clk;
   170		} else {
   171			div = default_max_freq * 100;
   172			div = div / clk;
   173			div /= 100;
   174		}
   175	
   176		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
   177		clk &= ~SDHCI_CLOCK_CARD_EN;
   178		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
   179	
   180		clk &= ~SDHCI_CLOCK_PLL_EN;
   181		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
   182	
   183		val = bst_read_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL);
   184		val &= ~(1 << 8);
   185		bst_write_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL, val);
   186	
   187		val = bst_read_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL);
   188		val &= ~(0xff);
   189		val |= 0x20;
   190		bst_write_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL, val);
   191	
   192		val = bst_read_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL);
   193		val |= 1 << 8;
   194		bst_write_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_TIMER_DIV_CTRL, val);
   195	
   196		val = bst_read_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL);
   197		val &= ~(1 << 11);
   198		bst_write_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL, val);
   199	
   200		rx_reg.reg = bst_read_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL);
   201	
   202		rx_reg.bit.rx_revert = 0;
   203		rx_reg.bit.rx_clk_sel_sec = 1;
   204		rx_reg.bit.rx_clk_div = 4;
   205		rx_reg.bit.rx_clk_phase_inner = 2;
   206		rx_reg.bit.rx_clk_sel_first = 0;
   207		rx_reg.bit.rx_clk_phase_out = 2;
   208	
   209		bst_write_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL, rx_reg.reg);
   210	
   211		val = bst_read_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL);
   212		val |= 1 << 11;
   213		bst_write_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_RX_CLK_CTRL, val);
   214	
   215		/* Disable clock first */
   216		val = bst_read_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL);
   217		val &= ~0x0400;
   218		bst_write_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL, val);
   219	
   220		/* Setup clock divider */
   221		val = bst_read_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL);
   222		val &= ~0x03ff;
   223		val |= div;
   224		bst_write_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL, val);
   225	
   226		/* Enable clock */
   227		val = bst_read_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL);
   228		val |= 0x0400;
   229		bst_write_phys_bst(priv->phy_crm_reg_base + SDEMMC_CRM_BCLK_DIV_CTRL, val);
   230	
   231		sdhci_writew(host, (div & 0xff) << 8, SDHCI_CLOCK_CONTROL);
   232	
   233		sdhci_writew(host, (div & 0xff) << 8, SDHCI_CLOCK_CONTROL);
   234		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
   235		clk |= SDHCI_CLOCK_PLL_EN;
   236		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
   237	
   238		clk |= SDHCI_CLOCK_CARD_EN;
   239		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
   240	
   241		clk |= SDHCI_CLOCK_INT_EN;
   242		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
   243	}
   244	
 > 245	void sdhci_set_bst_clock(struct sdhci_host *host, unsigned int clock)
   246	{
   247		if (clock == 0)
   248			return;
   249		sdhci_enable_bst_clk(host, clock);
   250	}
   251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
