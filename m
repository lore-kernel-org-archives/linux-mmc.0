Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52D287514;
	Fri, 23 May 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747988554; cv=none; b=heuAI2Q85sc8H9w3OkmVmByf8eDJRnwrgZH1tOq5ZrfCi7Wz3c2gHCHK/ofgQKdYFk+//hnZt8UqRr7w9tCTkQGWSDe482I1635tPQ5qAVMINFjL9n9d8xR5mZpcpewZhZKl+Q5k8XhEO22EuOhrU03/2TRNvKGluPQ9J2sKo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747988554; c=relaxed/simple;
	bh=UktUFNhQpzGrRsFIwIpfLH+M+oX8xvKnPJijRRpkYXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6h2iaxDOoenDtqbOMO3nrJi40D/1cR4M/z6Py0o5oGAOgn56bBh9n9Cx86a+JyybXZ3ynVCqi8NAfD5TgklCbqr8irIotUd2HZuoZwt58dvze/jcH5LB+T1vdCvr9WgRqxDgmgbviEQYNBdvigp2NfeeroqREE4uccBfS+7m+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Stt5DONs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Stt5DONs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747988551; x=1779524551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UktUFNhQpzGrRsFIwIpfLH+M+oX8xvKnPJijRRpkYXw=;
  b=Stt5DONsvmIfK2WZG9FTPw2qyKadJxtgoahCGHecpBrD+z6xvmid6h0+
   Hj20Xqh9A3w8kYbM0W4AblzKN8Ro+ZNmAJQ61pTrBICrLJuKKdh8Xp/R/
   2oKFmBI1slTiuZHq9RFeCly40MX/v2myazl2MJy1YKC6BZa2bOmJ+QJSt
   UKjs/v01N/0SaPM8fyKJ35VqB+F+wIHLHWRKLvAIlL+PH1ROOBm0ckU4I
   63VdiXcRPbYG1phFh5hKBuRT7bKBHzkl5z+XlPnk5av4UuJEejWNgAe5e
   o+5zrmoPqtvl0OJyMZxxrqRpmZxIrO4Rfl9tFQ45sGPOwzHblRXWJN1tp
   Q==;
X-CSE-ConnectionGUID: 8vDrfgkuR567uKLSTNS3Ew==
X-CSE-MsgGUID: bn/XULBITO+ifnGZz3qerg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49958777"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49958777"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 01:22:31 -0700
X-CSE-ConnectionGUID: hbdtZnCZSp+nEANc3d6+Yw==
X-CSE-MsgGUID: aGhX6r3rRwu6bK0N6bagxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="146032463"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 May 2025 01:22:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uINfe-000QC8-0N;
	Fri, 23 May 2025 08:22:26 +0000
Date: Fri, 23 May 2025 16:21:55 +0800
From: kernel test robot <lkp@intel.com>
To: Paul Alvin <alvin.paulp@amd.com>, michal.simek@amd.com,
	adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, git@amd.com,
	alvin.paulp@amd.com, linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add shutdown callback
Message-ID: <202505231550.RaoPUrmq-lkp@intel.com>
References: <20250522094932.4187301-1-alvin.paulp@amd.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522094932.4187301-1-alvin.paulp@amd.com>

Hi Paul,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.15-rc7]
[also build test ERROR on linus/master next-20250522]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Alvin/mmc-sdhci-of-arasan-Add-shutdown-callback/20250522-175110
base:   v6.15-rc7
patch link:    https://lore.kernel.org/r/20250522094932.4187301-1-alvin.paulp%40amd.com
patch subject: [PATCH] mmc: sdhci-of-arasan: Add shutdown callback
config: arm64-randconfig-002-20250523 (https://download.01.org/0day-ci/archive/20250523/202505231550.RaoPUrmq-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250523/202505231550.RaoPUrmq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505231550.RaoPUrmq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-of-arasan.c:2063:2: error: call to undeclared function 'sdhci_arasan_suspend'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           sdhci_arasan_suspend(dev);
           ^
   1 error generated.


vim +/sdhci_arasan_suspend +2063 drivers/mmc/host/sdhci-of-arasan.c

  2058	
  2059	static void sdhci_arasan_shutdown(struct platform_device *pdev)
  2060	{
  2061		struct device *dev = &pdev->dev;
  2062	
> 2063		sdhci_arasan_suspend(dev);
  2064	}
  2065	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
