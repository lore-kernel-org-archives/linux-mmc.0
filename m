Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C91C57B7;
	Tue, 27 Aug 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771578; cv=none; b=EjSoGOKH54qn/1EojkvSe0EuhnalZHM3FfBe5AuWKg7AeUYiQ93+BrQzkNvWQ7XaSjk0OLIR8cs3IFdNExY6JSAqZDXTjzaN9hhKQ3qBGgNRRxPZjSFLr3Vnu+r9sLLNxyB3pvsv5s/hXVLYeLaYF2Sil9fCL3IT4WIcl8WolfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771578; c=relaxed/simple;
	bh=FEk+B3LW5G85h/aXD2cDtqY3+o7ZLu3lhovxEZ2IoBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpniZo6XLfNQccRpm+mhb2O3xZFwJIQ2T4QIWdpAp+jLI1uo9unACrpSp+xYSSAPoDUL/UR4PUsHGye253t0URTEQwIeo77Lo7K9i5MuFJ4V76sDflA4ulP1t0HvaZvhGhZZDARiAGSM6Ec1ZLC1mxjRqiuonojsTGLHc9RiQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBbPVbZA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBbPVbZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724771576; x=1756307576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FEk+B3LW5G85h/aXD2cDtqY3+o7ZLu3lhovxEZ2IoBI=;
  b=QBbPVbZAhyQGDIBBAV2LrKH0vg6epKrPDIo7J5LJZ00ySQjpMGgiuodC
   PELSzKsszTaC6fKtAFgQJj25FJNeOPmcdbrhjK2ZmSytiJuRvKfrmZKHX
   FALZ5MrRC+l8CbkCE1nv0KsxY/Tj/CCex2q9fBqoZzxJfOEg/Rsfa1whm
   50gQhy/KBJ8bRCJyEYuGmtqK7Cr+HMTaQS4I4ptK7O3sCKrCegaXtOJ27
   HKCVpTDWXCm6InGRyLWrGtzrv0oVl2LgOGCsopdXnQqqAFuXnr4Xw/DCD
   WmTBju2RcYMze6oRLGlb54C+99Kxw/t5jRJ0wAMLKHd655hZcmtmy+nHU
   w==;
X-CSE-ConnectionGUID: iLOWoGrsRT6rtJrXB8BnTA==
X-CSE-MsgGUID: T1+624vURwSPOEsUbUEL4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="40729092"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="40729092"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 08:12:42 -0700
X-CSE-ConnectionGUID: XVIDEVmfSfeobkgIKCkRHA==
X-CSE-MsgGUID: aoa9OdGxQRul5UVtZ423rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67598318"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Aug 2024 08:12:40 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sixs5-000JJC-2K;
	Tue, 27 Aug 2024 15:12:37 +0000
Date: Tue, 27 Aug 2024 23:11:44 +0800
From: kernel test robot <lkp@intel.com>
To: Liming Sun <limings@nvidia.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	David Thompson <davthompson@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, Liming Sun <limings@nvidia.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Add hw_reset() support for
 BlueField-3 SoC
Message-ID: <202408272252.lAVSmMBR-lkp@intel.com>
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
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240827/202408272252.lAVSmMBR-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408272252.lAVSmMBR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408272252.lAVSmMBR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-of-dwcmshc.c:919:31: warning: 'sdhci_dwcmshc_bf3_ops' defined but not used [-Wunused-const-variable=]
     919 | static const struct sdhci_ops sdhci_dwcmshc_bf3_ops = {
         |                               ^~~~~~~~~~~~~~~~~~~~~


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
