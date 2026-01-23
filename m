Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4133EB09;
	Fri, 23 Jan 2026 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155184; cv=none; b=DJeX4f4FkkpNDEZioYuK4F1kIUypexyDUk4ZUIVB9kQbzmsXPKpOW50LqEDbLPByUyXqdMRWBCEMTsZ2umq0XigLQih18+3CmOaldTqbyXh52vAMia3jGbHCBHPUipMiOOvJluR2LARtKcL/A9cFyLcaIfTBqRbY4XWKvsDYpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155184; c=relaxed/simple;
	bh=c0K9UaO3St0IE2YkmiOL1BniYmWEc2RHIdZofm+Lw0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D34W506+dnva3Q/rvSR5xBh7Yg2VAeIVdPZ86Q8KPofCcb3JQSavsq5mcYwBzbYmDYhu9tRmnARro1RJi6Z+BRB/x9Bo/QGF4dMNRSaPk5UzEYhKJ7t8XMnErvgmL44DfviRbuTU+HB0FqJM8iEfFGMMyIoyMUnwSRAslQAo91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5+LAnDh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5+LAnDh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769155183; x=1800691183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c0K9UaO3St0IE2YkmiOL1BniYmWEc2RHIdZofm+Lw0I=;
  b=R5+LAnDh4z5as89p+QH2YaNYdPxdYZJ76etxdWtqKJAZC7RNqG7p2V5v
   lYURFCEjQz0q8f+QH3lJlBuS54jPk1sDZ7dcTbnuEFOzGt69zKAecA2ic
   QKZ55AYqIuppzFORwND8AJTBmps1Z9DaicLO+G+KcIiK1izN17/Q7RxaJ
   6MkmDVtzumvqdKu3o1pzefvJj2TpqVIu5aWe9nECRycm6XvuexWLVXFk9
   DtkTNZ4rmixc6HCAu4VbpvelPJ9Yp19okTmOuVPt2jVRckokPp+8aMPXV
   7RST4nEtFkCppaXFA/6zDsFysRdnh1cyCmbZEMmo94bzuo4jyt+OKd5YV
   g==;
X-CSE-ConnectionGUID: Tc1Q/8aaT12Pm79ZSq9lgg==
X-CSE-MsgGUID: lguAHgF3TESqlkt1wOFz+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="57977628"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="57977628"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 23:59:42 -0800
X-CSE-ConnectionGUID: seuhiDOlRdWkicNj+8cXKQ==
X-CSE-MsgGUID: 7/rxyr7iTmS51C3Yh0T0mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="238219086"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 22 Jan 2026 23:59:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjC4v-00000000TfC-1Lpd;
	Fri, 23 Jan 2026 07:59:37 +0000
Date: Fri, 23 Jan 2026 15:59:31 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Wei Xu <xuwei5@hisilicon.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/3] mmc: dw_mmc-k3: Remove mshc alias support
Message-ID: <202601231543.IzsYNOzJ-lkp@intel.com>
References: <1769132482-177365-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1769132482-177365-2-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master ulf-hansson-mmc-mirror/next v6.19-rc6 next-20260122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/mmc-dw_mmc-k3-Remove-mshc-alias-support/20260123-095950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1769132482-177365-2-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH 1/3] mmc: dw_mmc-k3: Remove mshc alias support
config: arc-randconfig-002-20260123 (https://download.01.org/0day-ci/archive/20260123/202601231543.IzsYNOzJ-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601231543.IzsYNOzJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601231543.IzsYNOzJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mmc/host/dw_mmc-k3.c: In function 'dw_mci_hs_set_timing':
   drivers/mmc/host/dw_mmc-k3.c:220:16: error: 'struct dw_mci' has no member named 'mmc'
     ctrl_id = host->mmc->index;
                   ^~
>> drivers/mmc/host/dw_mmc-k3.c:217:18: warning: variable 'priv' set but not used [-Wunused-but-set-variable]
     struct k3_priv *priv;
                     ^~~~


vim +/priv +217 drivers/mmc/host/dw_mmc-k3.c

0293efddaddfcb Zhangfei Gao        2015-05-14  207  
d53e39b1131c08 Shawn Lin           2026-01-23  208  static int dw_mci_hs_set_timing(struct dw_mci *host, int timing,
361c7fe9b02eee liwei               2017-08-11  209  				     int smpl_phase)
361c7fe9b02eee liwei               2017-08-11  210  {
361c7fe9b02eee liwei               2017-08-11  211  	u32 drv_phase;
361c7fe9b02eee liwei               2017-08-11  212  	u32 smpl_dly;
361c7fe9b02eee liwei               2017-08-11  213  	u32 use_smpl_dly = 0;
361c7fe9b02eee liwei               2017-08-11  214  	u32 enable_shift = 0;
361c7fe9b02eee liwei               2017-08-11  215  	u32 reg_value;
361c7fe9b02eee liwei               2017-08-11  216  	int ctrl_id;
361c7fe9b02eee liwei               2017-08-11 @217  	struct k3_priv *priv;
361c7fe9b02eee liwei               2017-08-11  218  
361c7fe9b02eee liwei               2017-08-11  219  	priv = host->priv;
d53e39b1131c08 Shawn Lin           2026-01-23 @220  	ctrl_id = host->mmc->index;
d53e39b1131c08 Shawn Lin           2026-01-23  221  
d53e39b1131c08 Shawn Lin           2026-01-23  222  	if (ctrl_id >= TIMING_MODE)
d53e39b1131c08 Shawn Lin           2026-01-23  223  		return -EINVAL;
361c7fe9b02eee liwei               2017-08-11  224  
361c7fe9b02eee liwei               2017-08-11  225  	drv_phase = hs_timing_cfg[ctrl_id][timing].drv_phase;
361c7fe9b02eee liwei               2017-08-11  226  	smpl_dly   = hs_timing_cfg[ctrl_id][timing].smpl_dly;
361c7fe9b02eee liwei               2017-08-11  227  	if (smpl_phase == -1)
361c7fe9b02eee liwei               2017-08-11  228  		smpl_phase = (hs_timing_cfg[ctrl_id][timing].smpl_phase_max +
361c7fe9b02eee liwei               2017-08-11  229  			     hs_timing_cfg[ctrl_id][timing].smpl_phase_min) / 2;
361c7fe9b02eee liwei               2017-08-11  230  
361c7fe9b02eee liwei               2017-08-11  231  	switch (timing) {
361c7fe9b02eee liwei               2017-08-11  232  	case MMC_TIMING_UHS_SDR104:
361c7fe9b02eee liwei               2017-08-11  233  		if (smpl_phase >= USE_DLY_MIN_SMPL &&
361c7fe9b02eee liwei               2017-08-11  234  				smpl_phase <= USE_DLY_MAX_SMPL)
361c7fe9b02eee liwei               2017-08-11  235  			use_smpl_dly = 1;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  236  		fallthrough;
361c7fe9b02eee liwei               2017-08-11  237  	case MMC_TIMING_UHS_SDR50:
361c7fe9b02eee liwei               2017-08-11  238  		if (smpl_phase >= ENABLE_SHIFT_MIN_SMPL &&
361c7fe9b02eee liwei               2017-08-11  239  				smpl_phase <= ENABLE_SHIFT_MAX_SMPL)
361c7fe9b02eee liwei               2017-08-11  240  			enable_shift = 1;
361c7fe9b02eee liwei               2017-08-11  241  		break;
361c7fe9b02eee liwei               2017-08-11  242  	}
361c7fe9b02eee liwei               2017-08-11  243  
361c7fe9b02eee liwei               2017-08-11  244  	mci_writel(host, GPIO, 0x0);
361c7fe9b02eee liwei               2017-08-11  245  	usleep_range(5, 10);
361c7fe9b02eee liwei               2017-08-11  246  
361c7fe9b02eee liwei               2017-08-11  247  	reg_value = FIELD_PREP(UHS_REG_EXT_SAMPLE_PHASE_MASK, smpl_phase) |
361c7fe9b02eee liwei               2017-08-11  248  		    FIELD_PREP(UHS_REG_EXT_SAMPLE_DLY_MASK, smpl_dly) |
361c7fe9b02eee liwei               2017-08-11  249  		    FIELD_PREP(UHS_REG_EXT_SAMPLE_DRVPHASE_MASK, drv_phase);
361c7fe9b02eee liwei               2017-08-11  250  	mci_writel(host, UHS_REG_EXT, reg_value);
361c7fe9b02eee liwei               2017-08-11  251  
361c7fe9b02eee liwei               2017-08-11  252  	mci_writel(host, ENABLE_SHIFT, enable_shift);
361c7fe9b02eee liwei               2017-08-11  253  
361c7fe9b02eee liwei               2017-08-11  254  	reg_value = FIELD_PREP(GPIO_CLK_DIV_MASK, GENCLK_DIV) |
361c7fe9b02eee liwei               2017-08-11  255  			     FIELD_PREP(GPIO_USE_SAMPLE_DLY_MASK, use_smpl_dly);
361c7fe9b02eee liwei               2017-08-11  256  	mci_writel(host, GPIO, (unsigned int)reg_value | GPIO_CLK_ENABLE);
361c7fe9b02eee liwei               2017-08-11  257  
361c7fe9b02eee liwei               2017-08-11  258  	/* We should delay 1ms wait for timing setting finished. */
361c7fe9b02eee liwei               2017-08-11  259  	usleep_range(1000, 2000);
d53e39b1131c08 Shawn Lin           2026-01-23  260  
d53e39b1131c08 Shawn Lin           2026-01-23  261  	return 0;
361c7fe9b02eee liwei               2017-08-11  262  }
361c7fe9b02eee liwei               2017-08-11  263  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
