Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6449E37F300;
	Fri,  7 Aug 2026 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139323; cv=none; b=HrDBmRcgiIR3zCw+nAiWPK1J8P1T5fOh8Ge8gwDRUJZkvmUwXBmUcnJY5PEhwNIAbBkmM/b2ObieaIrSBqS2lLolvh0E+gpk3WawfADUAfvT4xnshIW71WwSPOOZZcodEzITf2Fm7v4af0mbO6FcD+nEuljiNE2uYg880//BcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139323; c=relaxed/simple;
	bh=mTXaWMUkp0dBHLyGD71UGs8JJqt+8LEcZCpN5x1Yz7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+sP16Oh5nz5Z1FE13vuluFQNrxUBgPlb6JNI7U+uEzTvad3zf0c3PNLQMz4ohGKZoVAljlh9PyN5LGU8mhcjPAu+RFS6fS0Z0xy0GZ0nt3buoz69W4R2ZUnaC61ntTeGFsUDt19kB+oxxlCY4M9bZpjTYBg527UoRlQ2PE3u1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2jaq7rs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2jaq7rs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786139321; x=1817675321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mTXaWMUkp0dBHLyGD71UGs8JJqt+8LEcZCpN5x1Yz7k=;
  b=P2jaq7rsAK34qQM8eH/1f25SEgd/urv7zeEapJXsZ45mXsUgcXUgBO+f
   ekyYnqA/xlCYhsVcMVxjrJRYqRBeWH1z/VPowFcw7tiSTlaUTeOPpQNL/
   EQNNs0RM9WUPoWuKmX69TYLvxf9iGM0KnYW3jGR8JUN/aC1TAzgQsU3v8
   JIeej0zitoHsPd/SAuKpJ51vT7PFYpE4LcZPqIboeuNu4gfWeCG5jEwiV
   RIHiDRwS8sU+YW3m+t9WsY0+4vBqdBDL+JmPbz7/ykxtBQOFm3PXcWFUe
   k2QwDa2VHviULF/1a7cg9RsHPQE/JMrWm56SnxwxIzLHFgPYUGdWPDpdn
   w==;
X-CSE-ConnectionGUID: s7M07yaFR2yMy8FYnD8xYQ==
X-CSE-MsgGUID: yNYvkwmmSnqnr/tbiAXUWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="85728898"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="85728898"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 14:48:41 -0700
X-CSE-ConnectionGUID: 3tkWBxqFQzSlgE6g20gERw==
X-CSE-MsgGUID: H2rvAy3kQGySe8n5fS96Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="261212881"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Aug 2026 14:48:37 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wsSQb-00000000JKf-11qQ;
	Fri, 07 Aug 2026 21:48:33 +0000
Date: Sat, 8 Aug 2026 05:47:55 +0800
From: kernel test robot <lkp@intel.com>
To: Mayur Kumar <kmayur809@gmail.com>, Ulf Hansson <ulfh@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mayur Kumar <kmayur809@gmail.com>
Subject: Re: [PATCH] mmc: core: add MMC_QUIRK_BROKEN_WRITE_ZEROES for ESMT
 eMMC
Message-ID: <202608080412.ueBVGtOw-lkp@intel.com>
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
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260808/202608080412.ueBVGtOw-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260808/202608080412.ueBVGtOw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608080412.ueBVGtOw-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/core/queue.c: In function 'mmc_queue_setup_discard':
>> drivers/mmc/core/queue.c:195:30: error: 'MMC_QUIRK_BROKEN_WRITE_ZEROS' undeclared (first use in this function); did you mean 'MMC_QUIRK_BROKEN_WRITE_ZEROES'?
     195 |             !(card->quirks & MMC_QUIRK_BROKEN_WRITE_ZEROS))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                              MMC_QUIRK_BROKEN_WRITE_ZEROES
   drivers/mmc/core/queue.c:195:30: note: each undeclared identifier is reported only once for each function it appears in


vim +195 drivers/mmc/core/queue.c

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
