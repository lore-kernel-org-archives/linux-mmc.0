Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E28243964;
	Sat,  8 Aug 2026 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786186628; cv=none; b=eWnPUyxfxrGXToEoTUSvFkERq+Mpg67+8brQ+IUxzNTorde90LNWBH6q+PcQIqDDpvuNX/iDov4wkOUh4R3Sj7CyGVPhEZSfrSBR9jc7AnOmIOEhbJYiQQVd8JmowlHmrtYm4uJ9TtZQ2Bz3FMxWMSXC0jgRgSBwbXLSLWHSz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786186628; c=relaxed/simple;
	bh=G+LHWtW2IvYmsKvwY0Ba5W48GZ3FuzAjCoGAVG4w8/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDyDRMubvIvojyrhLZnL0/pXYs4eXmYd9TtHqfQKEiBiYF2wGvS1B6h6rrYNSq9XNYw8CZVyxzRLS51niG4g4UytngLHdMDhC6BwT6Fb/mrBhC9pt9+YUVjRcfKbHTo7hhQyWYtOO9I6JHYiYdHEV5OH3ncy8rfMDcYTNwcjKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbowAiEs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbowAiEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786186625; x=1817722625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G+LHWtW2IvYmsKvwY0Ba5W48GZ3FuzAjCoGAVG4w8/M=;
  b=IbowAiEsPgNUAgB2j1ysUCPbTM7POmXwhMYVkJ2V1TynA9J1P63RuNKn
   adeZfOzgDIyIc/sD9VMCMl5VsnWrddf+afmxoqfpkNah1IlxaMVSDeqYE
   lQxSAmIYjdKcUD+gK9T98GNVTHmDmfnvck/4qKtXrgJv+ZRGi+NHgKmqV
   UntJNt5i6W/tBSvXR1R9EoEt5k2Jhln1IUcieYqYY7bMXvgrt2tGh4mPN
   QkR5OUOtIi4n2TAqNTfwm3cLI+DY/uE/N5VI4mEbMLfjKmIWNkJhVrrnK
   vNU3P8iYJH5vBuCd73SbOgOms7/76ndIWA8Qa6ej6wen26y/Tmp5VH00X
   A==;
X-CSE-ConnectionGUID: Mip7lKb6Q2u4iYIpTRfGfA==
X-CSE-MsgGUID: AjUOvvnaRuiETbhkYKw4pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="89304501"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="89304501"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 03:57:04 -0700
X-CSE-ConnectionGUID: o6RY8TtSS9eRWT39MMgEqw==
X-CSE-MsgGUID: cSCpax2BS3ipmQvSJyTiNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="259296903"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 08 Aug 2026 03:57:02 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wsejc-00000000K6D-06DC;
	Sat, 08 Aug 2026 10:57:00 +0000
Date: Sat, 8 Aug 2026 18:56:36 +0800
From: kernel test robot <lkp@intel.com>
To: Mayur Kumar <kmayur809@gmail.com>, Ulf Hansson <ulfh@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mayur Kumar <kmayur809@gmail.com>
Subject: Re: [PATCH] mmc: core: add MMC_QUIRK_BROKEN_WRITE_ZEROES for ESMT
 eMMC
Message-ID: <202608081816.H4q7m1Wl-lkp@intel.com>
References: <20260725185129.43397-1-kmayur809@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725185129.43397-1-kmayur809@gmail.com>

Hi Mayur,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.2-rc6 next-20260807]
[cannot apply to ulf-hansson-mmc-mirror/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mayur-Kumar/mmc-core-add-MMC_QUIRK_BROKEN_WRITE_ZEROES-for-ESMT-eMMC/20260807-212705
base:   linus/master
patch link:    https://lore.kernel.org/r/20260725185129.43397-1-kmayur809%40gmail.com
patch subject: [PATCH] mmc: core: add MMC_QUIRK_BROKEN_WRITE_ZEROES for ESMT eMMC
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260808/202608081816.H4q7m1Wl-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 12df34b8469b8095359de8c249cb1b2753fadeea)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260808/202608081816.H4q7m1Wl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608081816.H4q7m1Wl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/core/queue.c:195:23: error: use of undeclared identifier 'MMC_QUIRK_BROKEN_WRITE_ZEROS'
     195 |             !(card->quirks & MMC_QUIRK_BROKEN_WRITE_ZEROS))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/MMC_QUIRK_BROKEN_WRITE_ZEROS +195 drivers/mmc/core/queue.c

   176	
   177	static void mmc_queue_setup_discard(struct mmc_card *card,
   178			struct queue_limits *lim)
   179	{
   180		unsigned max_discard;
   181	
   182		max_discard = mmc_calc_max_discard(card);
   183		if (!max_discard)
   184			return;
   185	
   186		lim->max_hw_discard_sectors = max_discard;
   187		if (mmc_card_can_secure_erase_trim(card)) {
   188			if (mmc_card_fixed_secure_erase_trim_time(card))
   189				lim->max_secure_erase_sectors = UINT_MAX >> card->erase_shift;
   190			else
   191				lim->max_secure_erase_sectors = max_discard;
   192		}
   193	
   194		if (mmc_card_can_trim(card) && card->erased_byte == 0 &&
 > 195		    !(card->quirks & MMC_QUIRK_BROKEN_WRITE_ZEROS))
   196			lim->max_write_zeroes_sectors = max_discard;
   197	
   198		/* granularity must not be greater than max. discard */
   199		if (card->pref_erase > max_discard)
   200			lim->discard_granularity = SECTOR_SIZE;
   201		else
   202			lim->discard_granularity = card->pref_erase << 9;
   203	}
   204	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
