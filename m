Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BDC12CDA5;
	Thu, 30 Apr 2026 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510823; cv=none; b=Pe8JhVEmnnOWPgX/28PcpSHNhDHBPiSCXzxffIVvXlMyperfP8Je3c36oCWfq/HjbRktuwu7b/9S63jLVo40loem/wI2lc4IF73POpfQ4anOQ5dyvz7aBAk4XYu6FagbwcQ1NjTm0nZS9N2ylJ2anYp9m/V83675W2yu+ClFTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510823; c=relaxed/simple;
	bh=zfkmByrLFAHEKVJWVl0s1IDqCNxIr7Q7yGaKuyRTUag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT4Slrw4gcXhQw63hFOgKTGitP/PcNSJANS/XLeD75Ig/kPinWq/VVEOzKPx6W6fvHvJEZnwX/7OxmBRcu53Q3vhSeOVjh0+Inz5PkWIuCTDjmq2dI1cGTUGrnDDbYfwvjWGT/9WHQpFe27pMY/GCeA6FXt4z7X5tE0ESl6afHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IKiMY6hz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IKiMY6hz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777510822; x=1809046822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zfkmByrLFAHEKVJWVl0s1IDqCNxIr7Q7yGaKuyRTUag=;
  b=IKiMY6hzYvuGjJZ726TmJJMOUmRjX1PlTgeq5e327xWc91/515BycoWK
   bXQHiWIOWjn/Uf6jc9vZyTGDq6XqqwBa6uKZA93qZs71kPCzRyx4rVuwj
   ToqcIYZgbKzdv6H8qQzCCIAJ77bRCn+YNwkgCovQv4i910mUrkO/dt1fx
   uoDgqpy/MjfFtdEdbM7rtXSloK1ZL4E2GaV9/hY2eAy6/2z6AMKxqns/I
   Bs98kTsNwI1ECPl6PeZLEzpKvS9gSR5Ch5uVoKnB8FHuc+DXGn3i4l5UO
   SNSl40jj7QgjZmvjBf4QucoyCVVn0rvlMBUAsLts1Lu/psqbTmYHTZs7A
   Q==;
X-CSE-ConnectionGUID: IP11a3dsQsWlDy+ti5tVSA==
X-CSE-MsgGUID: nH5cbiWeQBu6OgTBD8dmEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88765228"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="88765228"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 18:00:22 -0700
X-CSE-ConnectionGUID: vGEOVgUIQtiCWTwJKfbZKQ==
X-CSE-MsgGUID: rWWdLMylRaWrqFLsB6Bs0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="239452397"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 29 Apr 2026 18:00:20 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIFlI-00000000BkG-3VXr;
	Thu, 30 Apr 2026 01:00:16 +0000
Date: Thu, 30 Apr 2026 08:59:54 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: core: Switch to use pm_ptr() for bus.c
Message-ID: <202604300815.ATCbIpPU-lkp@intel.com>
References: <1776739053-120472-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1776739053-120472-1-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on ulf-hansson-mmc-mirror/next v7.1-rc1 next-20260429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/mmc-core-Switch-to-use-pm_ptr-for-bus-c/20260424-085747
base:   linus/master
patch link:    https://lore.kernel.org/r/1776739053-120472-1-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH] mmc: core: Switch to use pm_ptr() for bus.c
config: arm64-randconfig-004-20260430 (https://download.01.org/0day-ci/archive/20260430/202604300815.ATCbIpPU-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300815.ATCbIpPU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300815.ATCbIpPU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/core/bus.c:169:26: error: called object type 'void *' is not a function or function pointer
     169 |         ret = pm_generic_suspend(dev);
         |               ~~~~~~~~~~~~~~~~~~^
   drivers/mmc/core/bus.c:175:20: error: called object type 'void *' is not a function or function pointer
     175 |                 pm_generic_resume(dev);
         |                 ~~~~~~~~~~~~~~~~~^
   drivers/mmc/core/bus.c:191:25: error: called object type 'void *' is not a function or function pointer
     191 |         ret = pm_generic_resume(dev);
         |               ~~~~~~~~~~~~~~~~~^
   3 errors generated.


vim +169 drivers/mmc/core/bus.c

7628774851751e Ulf Hansson     2013-06-10  162  
32d317c60e56c2 Chuanxiao Dong  2012-04-11  163  static int mmc_bus_suspend(struct device *dev)
4101c16a910b15 Pierre Ossman   2007-05-19  164  {
265cdc900ce93c Andy Shevchenko 2010-09-17  165  	struct mmc_card *card = mmc_dev_to_card(dev);
986892ca78eedd Ulf Hansson     2013-06-10  166  	struct mmc_host *host = card->host;
986892ca78eedd Ulf Hansson     2013-06-10  167  	int ret;
4101c16a910b15 Pierre Ossman   2007-05-19  168  
0967edc6ef5c3c Ulf Hansson     2014-10-06 @169  	ret = pm_generic_suspend(dev);
986892ca78eedd Ulf Hansson     2013-06-10  170  	if (ret)
986892ca78eedd Ulf Hansson     2013-06-10  171  		return ret;
986892ca78eedd Ulf Hansson     2013-06-10  172  
986892ca78eedd Ulf Hansson     2013-06-10  173  	ret = host->bus_ops->suspend(host);
ebe7dd45cf49e3 Adrian Hunter   2017-11-21  174  	if (ret)
ebe7dd45cf49e3 Adrian Hunter   2017-11-21  175  		pm_generic_resume(dev);
ebe7dd45cf49e3 Adrian Hunter   2017-11-21  176  
4101c16a910b15 Pierre Ossman   2007-05-19  177  	return ret;
4101c16a910b15 Pierre Ossman   2007-05-19  178  }
4101c16a910b15 Pierre Ossman   2007-05-19  179  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
