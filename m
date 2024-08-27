Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE381BC9FE;
	Tue, 27 Aug 2024 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773380; cv=none; b=K53hqwl/rmZBAZIUJY8E0v9qz6wuq2X2K98UkpUR/NB79yAus+KR+f7WwqgF9BG5+NtrI+H+IJIYkWox0xqvu400B8vtddYkcLHSnSqZT3tEWn91AaH0ueKgBmeXcUHeQ9ZWyqPQJzVeRZjSG52WOr1qgueZAKZ+LMfpw7oX6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773380; c=relaxed/simple;
	bh=lXCedQeonAV55TDDmc5vnK1OKuPMO7LuzMDVk2Kdgbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erej98KyGFV033iDV97jGo7T4eX/WGQ1SXgLQ7gnoHJSnRzwhImM3Lct8kzXMMCW9QdVVUaPuiqdy+/djNsx7blSzEneIAMfW4C5m64TbVbDsVElhAlFBVs6mJm3oTnEy2Oz7knTIGr+DHZWE+X3Q/1e49pRBdAucVQRL6kCI7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaVSKF5O; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaVSKF5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724773378; x=1756309378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lXCedQeonAV55TDDmc5vnK1OKuPMO7LuzMDVk2Kdgbk=;
  b=YaVSKF5OUgZUxwiFagK1W8Cr2ek+3S+gK8/apL/fsIMRZhDKMAOgAPnh
   X54y6sXAJzyvYhDNHUb/cKZ6OelndvEMiGpE32r9nDT8ryf4iuycx2lF0
   D2bxjFFNFYOcoUlXOcCE70dGkFlkdWs3C1aA/oDCZeK0cpVlHLFPmNKvj
   BF39MnByiP6O9XnTRditdHHuSlmSYJYLDtOox/gr8BadN3epeLWNGZBmS
   elnVDhq6DGL2T8fLqkdD8zqs//HOq8qLvXkHrJHN99qs+9XC9DNZMWHeK
   XJKgnzGp48qbh3ZAIyyvzhBcF9P4m8p9YblBbOHRAs/nnQkosuUjFiFjg
   A==;
X-CSE-ConnectionGUID: 8ARYH27iTn+3y3u3n0hN/A==
X-CSE-MsgGUID: WKjFP5OqSfW5mysTpAKyFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23411400"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23411400"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 08:42:58 -0700
X-CSE-ConnectionGUID: yLodD4IjRfWxap87X5kFmA==
X-CSE-MsgGUID: FMvoO2WnRRW6Dkw0m4K1CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67055166"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2024 08:42:56 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siyLN-000JkY-1j;
	Tue, 27 Aug 2024 15:42:53 +0000
Date: Tue, 27 Aug 2024 23:42:43 +0800
From: kernel test robot <lkp@intel.com>
To: Liming Sun <limings@nvidia.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	David Thompson <davthompson@nvidia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Liming Sun <limings@nvidia.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Add hw_reset() support for
 BlueField-3 SoC
Message-ID: <202408272323.10IOsTV8-lkp@intel.com>
References: <73703c853e36f3cd61114e4ac815926d94a1a802.1724695127.git.limings@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73703c853e36f3cd61114e4ac815926d94a1a802.1724695127.git.limings@nvidia.com>

Hi Liming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc5 next-20240827]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liming-Sun/mmc-sdhci-of-dwcmshc-Add-hw_reset-support-for-BlueField-3-SoC/20240827-052819
base:   linus/master
patch link:    https://lore.kernel.org/r/73703c853e36f3cd61114e4ac815926d94a1a802.1724695127.git.limings%40nvidia.com
patch subject: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Add hw_reset() support for BlueField-3 SoC
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240827/202408272323.10IOsTV8-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408272323.10IOsTV8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408272323.10IOsTV8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mmc/host/sdhci-of-dwcmshc.c:14:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/mmc/host/sdhci-of-dwcmshc.c:919:31: warning: unused variable 'sdhci_dwcmshc_bf3_ops' [-Wunused-const-variable]
     919 | static const struct sdhci_ops sdhci_dwcmshc_bf3_ops = {
         |                               ^~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +/sdhci_dwcmshc_bf3_ops +919 drivers/mmc/host/sdhci-of-dwcmshc.c

   918	
 > 919	static const struct sdhci_ops sdhci_dwcmshc_bf3_ops = {
   920		.set_clock		= sdhci_set_clock,
   921		.set_bus_width		= sdhci_set_bus_width,
   922		.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
   923		.get_max_clock		= dwcmshc_get_max_clock,
   924		.reset			= sdhci_reset,
   925		.adma_write_desc	= dwcmshc_adma_write_desc,
   926		.irq			= dwcmshc_cqe_irq_handler,
   927		.hw_reset		= dwcmshc_bf3_hw_reset,
   928	};
   929	#endif
   930	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
