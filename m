Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2A4B1E7A;
	Thu,  8 May 2025 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746699289; cv=none; b=IA1BbYAN4+keQ7Oou/mwaqGBbOLJXjumbfwfqPGIVVAwgX0A3oukwnDySRh3KZ2+7S6ZLGGxcQ2wR9m+f45FX/7QcPP0BEa0gaVi3mwMVsgfLJm3V4MAG8a80enykAIdL+qkkD9nIpELzIMxcuOkvtJKckQ3GbBNuNWhtXxFrfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746699289; c=relaxed/simple;
	bh=PMqBEi28bw1727cbSbRMVXRM1MWzZoOLPDAhbfMUrI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvSK1iyVbt4/GUAkjJgqYxMq2a4DkZeyvJHbFnIlk9VpM6ZEAf8xOUcILlqeEXcc0yKGYRMzUDishZ1xxCh4mbq9wadhGcCYCZo2uqCmDetv32qlhhO/1TGlhhCS25fdApZw4bAviFCOkT6T5iAJCHadrmr4aqbC9ilFIgtUoj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlnZTc4O; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlnZTc4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746699288; x=1778235288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PMqBEi28bw1727cbSbRMVXRM1MWzZoOLPDAhbfMUrI0=;
  b=TlnZTc4OlUoDenB1MMouFCVzL15aRRvH/OZxTKNvyCEwlDCjiH32R4H7
   kfNqAPSqG51WicqvXp2jT6YA08ZVAE07brxT0B13MAStx0rndgWIFytdF
   GZwz6XXmCpf8bwz2Ew9Q/wWtwPr/DSPtPn7AnHPiP34/pGx0sL3Quxy/y
   2kdLesR8PLSnxMNsX/LmNcf37btoiGSn+NWgBTaFsuLSFCJvuvTlIaf3l
   G/68ody9JTsVVIKIQAZtSjimOG8fXWIIRA7jBAwDubvhrguM8imsXd+R3
   c8CzaI2QjHXAzuJnCjfzSp75qD333P5yrFbP7rfXe7RDMiTGpReKOwQ3d
   A==;
X-CSE-ConnectionGUID: KqUnanDPRdWuA+V/qtZC/A==
X-CSE-MsgGUID: 5r93BRDrTC6IJTKqn7XX+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48180685"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48180685"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 03:14:47 -0700
X-CSE-ConnectionGUID: SRXa/LJyS4eksKzRF5G2TA==
X-CSE-MsgGUID: y5al3j0FSKmBtexD1DSqeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="141145247"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2025 03:14:44 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCyH3-000Ar9-2W;
	Thu, 08 May 2025 10:14:41 +0000
Date: Thu, 8 May 2025 18:13:47 +0800
From: kernel test robot <lkp@intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mmc: loongson2: Add Loongson-2K SD/SDIO
 controller driver
Message-ID: <202505081845.0NQYX2nS-lkp@intel.com>
References: <1308b6ca9ffc2674cc0f089cfd163da87e53a8cd.1746581751.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1308b6ca9ffc2674cc0f089cfd163da87e53a8cd.1746581751.git.zhoubinbin@loongson.cn>

Hi Binbin,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9e12816f9a6195f1f5b7c5dc2e388c2458411b97]

url:    https://github.com/intel-lab-lkp/linux/commits/Binbin-Zhou/dt-bindings-mmc-Add-Loongson-2K-SD-SDIO-eMMC-controller-binding/20250507-153435
base:   9e12816f9a6195f1f5b7c5dc2e388c2458411b97
patch link:    https://lore.kernel.org/r/1308b6ca9ffc2674cc0f089cfd163da87e53a8cd.1746581751.git.zhoubinbin%40loongson.cn
patch subject: [PATCH v2 2/4] mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20250508/202505081845.0NQYX2nS-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505081845.0NQYX2nS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505081845.0NQYX2nS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/loongson2-mmc.c:605:20: error: initializer element is not a compile-time constant
           .regmap_config          = ls2k1000_regmap_config,
                                     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/loongson2-mmc.c:637:20: error: initializer element is not a compile-time constant
           .regmap_config          = ls2k1000_regmap_config,
                                     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/loongson2-mmc.c:684:39: warning: shift count >= width of type [-Wshift-count-overflow]
           ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
                                                ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 2 errors generated.


vim +605 drivers/mmc/host/loongson2-mmc.c

   603	
   604	static struct loongson2_mmc_pdata ls2k0500_mmc_pdata = {
 > 605		.regmap_config		= ls2k1000_regmap_config,
   606		.reorder_cmd_data	= loongson2_mmc_reorder_cmd_data,
   607		.setting_dma		= ls2k0500_mmc_set_external_dma,
   608		.prepare_dma		= loongson2_mmc_prepare_external_dma,
   609		.release_dma		= loongson2_mmc_release_external_dma,
   610	};
   611	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
