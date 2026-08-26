Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911514A619;
	Wed, 26 Aug 2026 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787710535; cv=none; b=Zf0Z/IGPkzHpa2nhhhqvTgWQfCrq84l+gb26MgBtV+wvKz7pfLhMMYsVIMWJnF2vruhWZ3A9un/GZF9WJb9eXlKg2qG6FZacF2NlCO8ijLy4InO7dihahkYqZ4/Zjf8NCBnpeF/Szev1rRrsM+rzfE6QneSpDdokbhWp8XXe7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787710535; c=relaxed/simple;
	bh=DPGdW8vUbSN9xgZTXkoLdBk/dMSWqFeEuNx7P5BVuuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU42ONbofxyz/P1mE9fyZdbG8220eMJT+BMxFhnL/P1Qjsv5BSf0mOzCsGcMZHu9PFx/oCtNdOkIO/b2Fgfa0jhDscalhwPIoa6NR+gndh5H4lfh2HxtAH4nHl8/FEGXyuBWWf2vseAulzfaMmf4U4HSPZNvEYRAiWJFGcorr6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brQzHqFr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brQzHqFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787710532; x=1819246532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DPGdW8vUbSN9xgZTXkoLdBk/dMSWqFeEuNx7P5BVuuY=;
  b=brQzHqFrYpXKXdghHqAwvbBtKNs3IKqpWNaNmgXhs1roQbZDNMk1wRaC
   w1yp+sYhVs5nW+1Jcas7SX2z1CJ5KGS8nW0/23Jqvu5NFXc2YSHb98NJm
   JgxEC9yBp2JFSH2dnWASJr9vv5M6h9L2wQIaegRKrLUrhqKvC/quY3+at
   azICkd+pEyXDIweNFUMD8zZralm0d+QIOqv7qOp3eKy0qyVioqOZDtBPE
   2MJH1mpAWndz/pyrY6ah0R7+Qn0jBzzCvfejofHDFzL4IdLVGjnYPamAh
   sSLDdUkcSP/oj36gFurXiB8mRqjnmxBXXLkKX5B5kP4Udjoie3EeavyWI
   w==;
X-CSE-ConnectionGUID: OmFqJu6wQNu/Ywqh0lYfgQ==
X-CSE-MsgGUID: VQZyIYfpR2STE5rxOGW9vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="105562458"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="105562458"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 19:15:32 -0700
X-CSE-ConnectionGUID: 7oGCUb9yQf+FXqydu6MHng==
X-CSE-MsgGUID: 1ornRr8URzOgURAC+GjA8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="263153696"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 25 Aug 2026 19:15:29 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wz3Al-000000006rL-0HOq;
	Wed, 26 Aug 2026 02:15:27 +0000
Date: Wed, 26 Aug 2026 10:14:27 +0800
From: kernel test robot <lkp@intel.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: Re: [PATCH] memstick: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <202608260945.vNkJPYxr-lkp@intel.com>
References: <20260825082718.244949-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825082718.244949-1-triet.hoang.dev@gmail.com>

Hi Triet,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.2 next-20260824]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Triet-Hoang/memstick-Convert-to-DEFINE_SIMPLE_DEV_PM_OPS/20260825-152717
base:   linus/master
patch link:    https://lore.kernel.org/r/20260825082718.244949-1-triet.hoang.dev%40gmail.com
patch subject: [PATCH] memstick: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
config: riscv-randconfig-002-20260826 (https://download.01.org/0day-ci/archive/20260826/202608260945.vNkJPYxr-lkp@intel.com/config)
compiler: clang version 21.1.8 (https://github.com/llvm/llvm-project 2078da43e25a4623cab2d0d60decddf709aaea28)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260826/202608260945.vNkJPYxr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608260945.vNkJPYxr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/memstick/host/r592.c:854:2: error: call to undeclared function 'r592_clear_interrupts'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     854 |         r592_clear_interrupts(dev);
         |         ^
   drivers/memstick/host/r592.c:864:2: error: call to undeclared function 'r592_clear_interrupts'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     864 |         r592_clear_interrupts(dev);
         |         ^
   2 errors generated.


vim +/r592_clear_interrupts +854 drivers/memstick/host/r592.c

9263412501022fe Maxim Levitsky  2011-03-25  849  
9263412501022fe Maxim Levitsky  2011-03-25  850  static int r592_suspend(struct device *core_dev)
9263412501022fe Maxim Levitsky  2011-03-25  851  {
deaa53989537c62 Chuhong Yuan    2019-07-23  852  	struct r592_device *dev = dev_get_drvdata(core_dev);
9263412501022fe Maxim Levitsky  2011-03-25  853  
9263412501022fe Maxim Levitsky  2011-03-25 @854  	r592_clear_interrupts(dev);
9263412501022fe Maxim Levitsky  2011-03-25  855  	memstick_suspend_host(dev->host);
8fa7292fee5c524 Thomas Gleixner 2025-04-05  856  	timer_delete_sync(&dev->detect_timer);
9263412501022fe Maxim Levitsky  2011-03-25  857  	return 0;
9263412501022fe Maxim Levitsky  2011-03-25  858  }
9263412501022fe Maxim Levitsky  2011-03-25  859  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
