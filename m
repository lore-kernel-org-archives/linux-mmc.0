Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF87263A;
	Sat, 17 May 2025 01:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747447076; cv=none; b=nWkJCTviOfnhrk/76MihB9TO3g1F2fy6HZ4zhsZRipEe43hR/32eFHB0YcNZB6xX7dahBk5JDgyjMrsdx4FeSggR1qc323R3GdUvs76+PVaf2x0ntOS+yvoGWrRVqqhcS9zFfePCZf2+54sfwClm3sXEjETrE86FbUfZZU+5nPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747447076; c=relaxed/simple;
	bh=FmgRQ+EscTRmQQR8dfEbqgf1KgXjBGzBaLIEKQ/fD+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRqq5mnBNAM1bjaeNtUNzA1gm8LEq/Gt7ZoWMT323VF6af2NNM6bBh/NwUoPmhNhkS0GbjidtW6ObsLRPaYWb+25C/MF0rm0QJz48ZzOgmL8vHOxMI06LecT9BzJgcte592Uy1jFIIDKYytUZzpxqtQkCjGotFj/EsLZBfA6ZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2pxkC6Q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2pxkC6Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747447074; x=1778983074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FmgRQ+EscTRmQQR8dfEbqgf1KgXjBGzBaLIEKQ/fD+0=;
  b=Z2pxkC6QERHhRaRYOZZAKdkpNZg5Yneo4GXZejNjxbLA/N2noezjYQRG
   QZRzpkrluY50c9Q63i6+wbPtYQR2hXes8+TxgzVMTyUzOuTlHx/RYsSAg
   t2Y+Qbdpww1ZJoa/GuGBTwmcAJPkYH+PaTbHgsidpvgJ5oDrD209rd/1o
   Ty1UqkJsAIFwUHm9X0JuIHHAXAYRAX0UUkVfvPo259e6A9LiDGQVQa5pT
   g6/zkiTbLMoqjuiGjys8sOOWQn9i5UJVLeUiodrLtTP+fiLE8LYY3qdLP
   bi08kUvJ1bQP5Qwa2UyE+Ra+s1Q2HhkGupHGeg13jLzwLsWCgcZwUXfJa
   Q==;
X-CSE-ConnectionGUID: pBp9fDGKSQejR3av0iRa8w==
X-CSE-MsgGUID: vjM1RIC7TFOT6twXlkTRfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="66837685"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="66837685"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 18:57:53 -0700
X-CSE-ConnectionGUID: T1Ku9bK9RD6dtiQ2cV06CA==
X-CSE-MsgGUID: CF37wRNaRXGebK4IQ2l5Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="138771775"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 May 2025 18:57:50 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uG6o8-000Jrn-0Z;
	Sat, 17 May 2025 01:57:48 +0000
Date: Sat, 17 May 2025 09:57:43 +0800
From: kernel test robot <lkp@intel.com>
To: dongxuyang@eswincomputing.com, ulf.hansson@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	adrian.hunter@intel.com, p.zabel@pengutronix.de,
	shanchun1218@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, xuxiang@eswincomputing.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: Re: [PATCH v1 2/2] sdhci: eswin: Add eic7700 sdhci driver
Message-ID: <202505170947.NTFfubuO-lkp@intel.com>
References: <20250516091727.887-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516091727.887-1-dongxuyang@eswincomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master ulf-hansson-mmc-mirror/next v6.15-rc6 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/dongxuyang-eswincomputing-com/dt-bindings-sdhci-eswin-Documentation-for-eic7700-SoC/20250516-171918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250516091727.887-1-dongxuyang%40eswincomputing.com
patch subject: [PATCH v1 2/2] sdhci: eswin: Add eic7700 sdhci driver
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20250517/202505170947.NTFfubuO-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250517/202505170947.NTFfubuO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505170947.NTFfubuO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:25,
                    from include/linux/platform_device.h:13,
                    from drivers/mmc/host/sdhci-pltfm.h:12,
                    from drivers/mmc/host/sdhci-eic7700.h:14,
                    from drivers/mmc/host/sdhci-of-eic7700-sdio.c:13:
>> drivers/mmc/host/sdhci-of-eic7700-sdio.c:972:36: error: 'eswin_sdhci_sdio_runtime_suspend' undeclared here (not in a function); did you mean 'eswin_sdhci_sdio_reset'?
     972 |                 SET_RUNTIME_PM_OPS(eswin_sdhci_sdio_runtime_suspend,
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:337:28: note: in definition of macro 'RUNTIME_PM_OPS'
     337 |         .runtime_suspend = suspend_fn, \
         |                            ^~~~~~~~~~
   drivers/mmc/host/sdhci-of-eic7700-sdio.c:972:17: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     972 |                 SET_RUNTIME_PM_OPS(eswin_sdhci_sdio_runtime_suspend,
         |                 ^~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-of-eic7700-sdio.c:973:36: error: 'eswin_sdhci_sdio_runtime_resume' undeclared here (not in a function); did you mean 'eswin_sdhci_sdio_dumpregs'?
     973 |                                    eswin_sdhci_sdio_runtime_resume, NULL)};
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:338:27: note: in definition of macro 'RUNTIME_PM_OPS'
     338 |         .runtime_resume = resume_fn, \
         |                           ^~~~~~~~~
   drivers/mmc/host/sdhci-of-eic7700-sdio.c:972:17: note: in expansion of macro 'SET_RUNTIME_PM_OPS'
     972 |                 SET_RUNTIME_PM_OPS(eswin_sdhci_sdio_runtime_suspend,
         |                 ^~~~~~~~~~~~~~~~~~


vim +972 drivers/mmc/host/sdhci-of-eic7700-sdio.c

   968	
   969	static const struct dev_pm_ops eswin_sdhci_sdio_pmops = {
   970		SET_SYSTEM_SLEEP_PM_OPS(eswin_sdhci_sdio_suspend,
   971					eswin_sdhci_sdio_resume)
 > 972			SET_RUNTIME_PM_OPS(eswin_sdhci_sdio_runtime_suspend,
 > 973					   eswin_sdhci_sdio_runtime_resume, NULL)};
   974	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
