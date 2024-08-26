Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55115444D;
	Mon, 26 Aug 2024 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672825; cv=none; b=nkzY5JSJdqy6CkYaN20LqdXdB2OkuwvqGfJ0DRQuYzrb84B58olOjTZVPYie/cruBX96x7/2nUAk0CIpmhTq2J4gP9x5QDcIRi2hyA4FNf3eqXAbcSig+9QJSucLUbkyKUL9YKxtxzDNPaLLPQsdhee2iEVC4PdcXHnh/KFOMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672825; c=relaxed/simple;
	bh=m8gm4trIc5OF849HsBviFelskC5meruIa0Uk7SfyYhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMkr2xfjLtk/LPTNgdcrjW8noTDwpMdmfb4O5QE8075Yu5fziXmUAmQZdwuaK3//rLKMpoWiL2iZttjJZ3jWQT5+qgsKW+77Q2l3q1Zp9JEm1kLiXjAefmTxfiphlIFBEV6mZlqnvBUgo6MbTN1HsDFfonzaPr0n/GE0JyeASeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETJ5ENAM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETJ5ENAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724672824; x=1756208824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m8gm4trIc5OF849HsBviFelskC5meruIa0Uk7SfyYhs=;
  b=ETJ5ENAMPEDgGSLgkZX+z/pEogCOcfD5kRVq8apslTYL73Lq9nIv47M8
   bvZHjXl317FwfGPzeVM7Rk4y+tZ+pTcT5+sMo2y5VdOkvgWJ9wXKNGuLc
   J9U/+yhWnqv7nzOgiVo2zgjCWqXrPtHjHS5S7xKhwLj3Vf2OkBbWPQJ84
   3q5pXELgD7Q9eG/DrPSKOpH7XukCcZXRmMYTdCLKWzQboRW+VKa9H2MTB
   kPHTvUJar01XiIrscLHoe8KvOyelTVCX/S5pOEinb+QAnaF2LQM47I3np
   8KgHrr+76Sbp1cXKs8ry13F3Pxf3IBEPWcgT7N3WClKTCT2n7/J+K0ncD
   g==;
X-CSE-ConnectionGUID: MaFJMenhTa+u+OwIVRCXvg==
X-CSE-MsgGUID: AgDhQbRWQAK8R2uk3gf8Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="26880342"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="26880342"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 04:47:04 -0700
X-CSE-ConnectionGUID: oRQw2gM3RWGnUgmtBv6YTg==
X-CSE-MsgGUID: QBUyms3lQrOki8Y7LD8KsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62460070"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 26 Aug 2024 04:47:00 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siYBV-000H0H-31;
	Mon, 26 Aug 2024 11:46:57 +0000
Date: Mon, 26 Aug 2024 19:46:22 +0800
From: kernel test robot <lkp@intel.com>
To: Seunghwan Baek <sh8267.baek@samsung.com>, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
	ritesh.list@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	grant.jung@samsung.com, jt77.jang@samsung.com,
	junwoo80.lee@samsung.com, dh0421.hwang@samsung.com,
	jangsub.yi@samsung.com, sh043.lee@samsung.com,
	cw9316.lee@samsung.com, sh8267.baek@samsung.com,
	wkon.kim@samsung.com
Subject: Re: [PATCH] mmc : fix for check cqe halt.
Message-ID: <202408261926.P72BWMr0-lkp@intel.com>
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
[also build test ERROR on v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Seunghwan-Baek/mmc-fix-for-check-cqe-halt/20240826-130042
base:   linus/master
patch link:    https://lore.kernel.org/r/20240823071025.15410-1-sh8267.baek%40samsung.com
patch subject: [PATCH] mmc : fix for check cqe halt.
config: i386-buildonly-randconfig-003-20240826 (https://download.01.org/0day-ci/archive/20240826/202408261926.P72BWMr0-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408261926.P72BWMr0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408261926.P72BWMr0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/cqhci-core.c:285:6: error: call to undeclared function 'cqhci_halted'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     285 |         if (cqhci_halted(cq_host))
         |             ^
   drivers/mmc/host/cqhci-core.c:285:6: note: did you mean 'cqhci_writel'?
   drivers/mmc/host/cqhci.h:301:20: note: 'cqhci_writel' declared here
     301 | static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
         |                    ^
   drivers/mmc/host/cqhci-core.c:620:7: error: call to undeclared function 'cqhci_halted'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     620 |                 if (cqhci_halted(cq_host)) {
         |                     ^
>> drivers/mmc/host/cqhci-core.c:956:13: error: static declaration of 'cqhci_halted' follows non-static declaration
     956 | static bool cqhci_halted(struct cqhci_host *cq_host)
         |             ^
   drivers/mmc/host/cqhci-core.c:285:6: note: previous implicit declaration is here
     285 |         if (cqhci_halted(cq_host))
         |             ^
   3 errors generated.


vim +/cqhci_halted +285 drivers/mmc/host/cqhci-core.c

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
