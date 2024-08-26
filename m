Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CF11482E3;
	Mon, 26 Aug 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672166; cv=none; b=EtlAgo33VArRfnECt/hfBuP8d8kdDhTcbZ10/MYQ+/xMj1kbP9P22vTv6yIblSQo6tR5ZlnzmBvUuJknzzr0xoFbaktef2MAY85U7ImNAXmpurw2cIaPw6N6ux7tfQqt4e2z6Cm7xS/Jd/hsW2ov6SIjCHy1t0mg+ZMM7e8XeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672166; c=relaxed/simple;
	bh=5sAkNko9+nQJZifSZ42etJ+PTBpZ7HtaPHbIKOOPcRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQthDEMmjAsEtNLc3W9taqOlpZ/VrcTkVi6pOYjD0GXNyPu9DWuBXEKJQ7B8DV/xvhlhPdDPrZLybJr20pozPcdy4AbybBHJ8CbdvMM1oURlNviUDE1BPZ7OBSCz5nRXu0fUyc6S0AsYQILHY3835/5IFVUC92uHjMLIv6K0f6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSDmglr9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSDmglr9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724672164; x=1756208164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5sAkNko9+nQJZifSZ42etJ+PTBpZ7HtaPHbIKOOPcRM=;
  b=RSDmglr9DHoGRMnuzdet9mQsUZVSbhPzsqGgbW1PqPjoCnQnk5vuS2EB
   2GXPL9wtgUdn4HGI7N2eDvBSqah6WbI2by1SFeB9RcwsUYvPYOPYJXlRm
   lOehfUQPExSOK15OtlI5uG0sXPDY11h04qmudkQR2TajQpn1nwLgjV1D5
   Rl+vmvm9FJT3KRZYEezqhmvxF8ktH26H8eMu2CWaDGo01uYurANpdwClY
   IwzC+sfowVEI+elwZwqPwuobOuvJi4R7Sq0dCpdoL/zZABKXo0Ft8MVoR
   FPANBm7uOE1BrUSrbvPJqvij7+Xs/sYKJG7LU5vzg1htI5ari1Ju0YhsV
   w==;
X-CSE-ConnectionGUID: dqnqcCeTSqClv0w2jhIiRA==
X-CSE-MsgGUID: zNFwDVa6R66WotyDnfNSnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22675392"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="22675392"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 04:36:03 -0700
X-CSE-ConnectionGUID: Q6C1UERGSW2Car//bibTDw==
X-CSE-MsgGUID: qzzorrm7ROqJiPtdBxyfsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="67297721"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 26 Aug 2024 04:36:00 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siY0r-000Gzp-28;
	Mon, 26 Aug 2024 11:35:57 +0000
Date: Mon, 26 Aug 2024 19:35:36 +0800
From: kernel test robot <lkp@intel.com>
To: Seunghwan Baek <sh8267.baek@samsung.com>, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
	ritesh.list@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, grant.jung@samsung.com,
	jt77.jang@samsung.com, junwoo80.lee@samsung.com,
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com,
	sh043.lee@samsung.com, cw9316.lee@samsung.com,
	sh8267.baek@samsung.com, wkon.kim@samsung.com
Subject: Re: [PATCH] mmc : fix for check cqe halt.
Message-ID: <202408261932.pcT0dqsD-lkp@intel.com>
References: <20240823071025.15410-1-sh8267.baek@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823071025.15410-1-sh8267.baek@samsung.com>

Hi Seunghwan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc5 next-20240823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Seunghwan-Baek/mmc-fix-for-check-cqe-halt/20240826-130042
base:   linus/master
patch link:    https://lore.kernel.org/r/20240823071025.15410-1-sh8267.baek%40samsung.com
patch subject: [PATCH] mmc : fix for check cqe halt.
config: arc-randconfig-001-20240826 (https://download.01.org/0day-ci/archive/20240826/202408261932.pcT0dqsD-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408261932.pcT0dqsD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408261932.pcT0dqsD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/div64.h:27,
                    from ./arch/arc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/delay.h:22,
                    from drivers/mmc/host/cqhci-core.c:5:
   drivers/mmc/host/cqhci-core.c: In function '__cqhci_enable':
>> drivers/mmc/host/cqhci-core.c:285:13: error: implicit declaration of function 'cqhci_halted'; did you mean 'cqhci_writel'? [-Werror=implicit-function-declaration]
     285 |         if (cqhci_halted(cq_host))
         |             ^~~~~~~~~~~~
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/mmc/host/cqhci-core.c:285:9: note: in expansion of macro 'if'
     285 |         if (cqhci_halted(cq_host))
         |         ^~
   drivers/mmc/host/cqhci-core.c: At top level:
>> drivers/mmc/host/cqhci-core.c:956:13: error: conflicting types for 'cqhci_halted'; have 'bool(struct cqhci_host *)' {aka '_Bool(struct cqhci_host *)'}
     956 | static bool cqhci_halted(struct cqhci_host *cq_host)
         |             ^~~~~~~~~~~~
   drivers/mmc/host/cqhci-core.c:285:13: note: previous implicit declaration of 'cqhci_halted' with type 'int()'
     285 |         if (cqhci_halted(cq_host))
         |             ^~~~~~~~~~~~
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/mmc/host/cqhci-core.c:285:9: note: in expansion of macro 'if'
     285 |         if (cqhci_halted(cq_host))
         |         ^~
   cc1: some warnings being treated as errors


vim +285 drivers/mmc/host/cqhci-core.c

   245	
   246	static void __cqhci_enable(struct cqhci_host *cq_host)
   247	{
   248		struct mmc_host *mmc = cq_host->mmc;
   249		u32 cqcfg;
   250	
   251		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
   252	
   253		/* Configuration must not be changed while enabled */
   254		if (cqcfg & CQHCI_ENABLE) {
   255			cqcfg &= ~CQHCI_ENABLE;
   256			cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
   257		}
   258	
   259		cqcfg &= ~(CQHCI_DCMD | CQHCI_TASK_DESC_SZ);
   260	
   261		if (mmc->caps2 & MMC_CAP2_CQE_DCMD)
   262			cqcfg |= CQHCI_DCMD;
   263	
   264		if (cq_host->caps & CQHCI_TASK_DESC_SZ_128)
   265			cqcfg |= CQHCI_TASK_DESC_SZ;
   266	
   267		if (mmc->caps2 & MMC_CAP2_CRYPTO)
   268			cqcfg |= CQHCI_CRYPTO_GENERAL_ENABLE;
   269	
   270		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
   271	
   272		cqhci_writel(cq_host, lower_32_bits(cq_host->desc_dma_base),
   273			     CQHCI_TDLBA);
   274		cqhci_writel(cq_host, upper_32_bits(cq_host->desc_dma_base),
   275			     CQHCI_TDLBAU);
   276	
   277		cqhci_writel(cq_host, cq_host->rca, CQHCI_SSC2);
   278	
   279		cqhci_set_irqs(cq_host, 0);
   280	
   281		cqcfg |= CQHCI_ENABLE;
   282	
   283		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
   284	
 > 285		if (cqhci_halted(cq_host))
   286			cqhci_writel(cq_host, 0, CQHCI_CTL);
   287	
   288		mmc->cqe_on = true;
   289	
   290		if (cq_host->ops->enable)
   291			cq_host->ops->enable(mmc);
   292	
   293		/* Ensure all writes are done before interrupts are enabled */
   294		wmb();
   295	
   296		cqhci_set_irqs(cq_host, CQHCI_IS_MASK);
   297	
   298		cq_host->activated = true;
   299	}
   300	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
