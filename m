Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AC234973
	for <linux-mmc@vger.kernel.org>; Fri, 30 May 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617593; cv=none; b=LXl6wBHzgQVDo6uDaOQx5c+V8eT4lMzZyd7NVfxOXQ91OREGuI8AIL/4u+WL3p46UaSznDXHGEDPM1tRJvlkv1lA4hq6K1MD9878CUjO/qzWuQWxoww5Rc9h9fmrvOjYNh47ogdwF+uylru+bWuKoXQw2HrE3XQSRmGziHwyT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617593; c=relaxed/simple;
	bh=ZCvmrxN0r+pSdIzQoEagLM/oBx7scbk+wpbnyKhTWFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on+iuDEIgVFHr6Tn979g3b1snNfa5vUoBDf8tBC4V4lyOT+w7hrSqKtzxbOkMycfP17bWPBerc7VeChipMC26hWenvMn6KzUozA5K9xeYQlVdhMHSnCttguiT2Bkf3s/hSDCrIGdK9967rIjvLHYsIv/KwGdyJ+SMdIH4YgmsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeCLZUuh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeCLZUuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748617592; x=1780153592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZCvmrxN0r+pSdIzQoEagLM/oBx7scbk+wpbnyKhTWFI=;
  b=DeCLZUuhHLsQHZtJK5owsr+yp/w6c44EjQ5PTzkh5XEnlLNtRaea3COe
   5uuouwj+q/9/YkT3uwBrirI07Y7Mf7bxW2JgAIwcJLHJ4cNT+S/SHgrj8
   rm3qTDtapUDFXhQ2HJL9k0GgWXH8RpQkViAFfJpJDSYfFEUDiRhw5Zzz0
   VhqMqw6Rp3wb1zXVE4B02Gr8qzPsId0NQKyIQ2M1wp0BglYKz1GH9opNL
   v1ji/KnsTZnq2obNkKjPmsDpU8qRtFk3rxwSIM2O+MCkJvCQsJ/gTf8Ge
   NMvdcLE77uDriLv2iwJXlfHF4MC+7QeQND46cq5vwlmMMdkdmv3AQluea
   w==;
X-CSE-ConnectionGUID: JpeL4xyuQsG7Qdqs6oja4Q==
X-CSE-MsgGUID: lSa0rTP0TJ61ytlwi3TDkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="54511358"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="54511358"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 08:06:32 -0700
X-CSE-ConnectionGUID: hsejwFi4S9+9nDb9Y6uGBw==
X-CSE-MsgGUID: Qd5osiNhSbaf69bqLl4g8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="143735986"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 30 May 2025 08:06:27 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uL1JR-000Xic-0p;
	Fri, 30 May 2025 15:06:25 +0000
Date: Fri, 30 May 2025 23:06:24 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Haibo Chen <haibo.chen@nxp.com>,
	Aubin Constans <aubin.constans@microchip.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Karel Balej <balejk@matfyz.cz>, Ben Dooks <ben-linux@fluff.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Hu Ziji <huziji@marvell.com>, Judith Mendez <jm@ti.com>,
	Andrew Davis <afd@ti.com>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci: Return void from
 sdhci_runtime_suspend_host() and sdhci_runtime_resume_host()
Message-ID: <202505302212.ZprBxoVy-lkp@intel.com>
References: <20250530122018.37250-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530122018.37250-1-adrian.hunter@intel.com>

Hi Adrian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v6.15 next-20250530]
[cannot apply to shawnguo/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Hunter/mmc-sdhci-Return-void-from-sdhci_runtime_suspend_host-and-sdhci_runtime_resume_host/20250530-202113
base:   linus/master
patch link:    https://lore.kernel.org/r/20250530122018.37250-1-adrian.hunter%40intel.com
patch subject: [PATCH] mmc: sdhci: Return void from sdhci_runtime_suspend_host() and sdhci_runtime_resume_host()
config: i386-buildonly-randconfig-002-20250530 (https://download.01.org/0day-ci/archive/20250530/202505302212.ZprBxoVy-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250530/202505302212.ZprBxoVy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505302212.ZprBxoVy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-esdhc-imx.c:2103:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    2103 |         if (host->mmc->caps2 & MMC_CAP2_CQE) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-esdhc-imx.c:2123:9: note: uninitialized use occurs here
    2123 |         return ret;
         |                ^~~
   drivers/mmc/host/sdhci-esdhc-imx.c:2103:2: note: remove the 'if' if its condition is always true
    2103 |         if (host->mmc->caps2 & MMC_CAP2_CQE) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-esdhc-imx.c:2101:9: note: initialize the variable 'ret' to silence this warning
    2101 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +2103 drivers/mmc/host/sdhci-esdhc-imx.c

04143fbaeb5799 Dong Aisheng      2016-07-12  2094  
2788ed42cdd755 Ulf Hansson       2016-07-27  2095  #ifdef CONFIG_PM
89d7e5c131228a Dong Aisheng      2013-11-04  2096  static int sdhci_esdhc_runtime_suspend(struct device *dev)
89d7e5c131228a Dong Aisheng      2013-11-04  2097  {
89d7e5c131228a Dong Aisheng      2013-11-04  2098  	struct sdhci_host *host = dev_get_drvdata(dev);
89d7e5c131228a Dong Aisheng      2013-11-04  2099  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
070e6d3ff5a696 Jisheng Zhang     2016-02-16  2100  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
89d7e5c131228a Dong Aisheng      2013-11-04  2101  	int ret;
89d7e5c131228a Dong Aisheng      2013-11-04  2102  
bb6e358169bf62 BOUGH CHEN        2019-01-07 @2103  	if (host->mmc->caps2 & MMC_CAP2_CQE) {
bb6e358169bf62 BOUGH CHEN        2019-01-07  2104  		ret = cqhci_suspend(host->mmc);
bb6e358169bf62 BOUGH CHEN        2019-01-07  2105  		if (ret)
bb6e358169bf62 BOUGH CHEN        2019-01-07  2106  			return ret;
bb6e358169bf62 BOUGH CHEN        2019-01-07  2107  	}
bb6e358169bf62 BOUGH CHEN        2019-01-07  2108  
5ef4a6a3b9ceac Adrian Hunter     2025-05-30  2109  	sdhci_runtime_suspend_host(host);
89d7e5c131228a Dong Aisheng      2013-11-04  2110  
d38dcad4e7b48f Adrian Hunter     2017-03-20  2111  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
d38dcad4e7b48f Adrian Hunter     2017-03-20  2112  		mmc_retune_needed(host->mmc);
d38dcad4e7b48f Adrian Hunter     2017-03-20  2113  
3602785b341a95 Michael Trimarchi 2018-01-04  2114  	imx_data->actual_clock = host->mmc->actual_clock;
3602785b341a95 Michael Trimarchi 2018-01-04  2115  	esdhc_pltfm_set_clock(host, 0);
89d7e5c131228a Dong Aisheng      2013-11-04  2116  	clk_disable_unprepare(imx_data->clk_per);
89d7e5c131228a Dong Aisheng      2013-11-04  2117  	clk_disable_unprepare(imx_data->clk_ipg);
89d7e5c131228a Dong Aisheng      2013-11-04  2118  	clk_disable_unprepare(imx_data->clk_ahb);
89d7e5c131228a Dong Aisheng      2013-11-04  2119  
1c4989b000aeac BOUGH CHEN        2019-04-29  2120  	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
d1b98305916bc0 Rafael J. Wysocki 2020-02-12  2121  		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
1c4989b000aeac BOUGH CHEN        2019-04-29  2122  
89d7e5c131228a Dong Aisheng      2013-11-04  2123  	return ret;
89d7e5c131228a Dong Aisheng      2013-11-04  2124  }
89d7e5c131228a Dong Aisheng      2013-11-04  2125  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
