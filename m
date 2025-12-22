Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3A242D60
	for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766387967; cv=none; b=jlsVIJWpkrenXMw7a9ctv6yHC9StsN9B+mUFVDA5CMA8Eso6z+i5jmum4+TgUiDI3NzV6tdXDjub3JggtL41oahUOcRJJ2DOEfGs9jsDqQUg2kBULa5u5eXmJLKwi2w4Ff8nyKZtShpJgtTnvS5nNRN96xHd3bGiIxjsjmfExis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766387967; c=relaxed/simple;
	bh=Ad6XnwRPyxR4bFIY7uXIjFQxE6Jc/O4cx0gw4HJ2pSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+zNnIDXL1LaZ41IggsTHFO5jNOlMSI7wSwycXzkDctZfecs2ctATPyUC73Og76Mg03cwlY28rchI1LOjR1coAmxeQfQE3phY2mhJlqlaoSpoHWWXuL9B8kzOJl5J8tf0AgR9u3tLr/m6GpZxFmnJMyLk2GyFGdEC6twBlfHEzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmkKO9mN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmkKO9mN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766387965; x=1797923965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ad6XnwRPyxR4bFIY7uXIjFQxE6Jc/O4cx0gw4HJ2pSY=;
  b=ZmkKO9mNhJ+kD9yvKQvz8CXR1lDR9gjooMpNVEeCk96veYJ6bh/+kM5j
   7vVIvgqPpkvS4DHfv9/a5j4jynuWT5kAOSz4SU3KkBk3ufVnJtSHrZp2V
   tTYmZ4znqyy3oiKSAKdQdUxTKBDGJDgiuEt5/RFIMebWad7w5uCs69HDU
   Qhmx6JK/Xg4U0VK5p45o+rf299Ht5RJo8pZ4Lk3FnSGNI1DSlGi0xjy7L
   fI1vdbCUoLnyql1YMr54hLHvzzdl6k7lnEyNVTWWqEJ1abPdmb5YJ7/75
   rJIAF1ANSpcB9GgOd494ldrZ/RQ2n0oI8nVuPFYyCvJ39PJaf2qY8EASi
   w==;
X-CSE-ConnectionGUID: BiJrPi5QTcyaCMMZXYFgDw==
X-CSE-MsgGUID: v15VD9TtTSmNd9bqtuezuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68180630"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68180630"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 23:19:25 -0800
X-CSE-ConnectionGUID: /8G0JR6PRZutp4gqaZDMkA==
X-CSE-MsgGUID: RwGJ3enqQ4qP8nh/iCWiLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="199763184"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 21 Dec 2025 23:19:23 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXaBn-000000000CX-2cF1;
	Mon, 22 Dec 2025 07:18:46 +0000
Date: Mon, 22 Dec 2025 15:18:39 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 14/18] mmc: dw_mmc: Remove unused register access macros
Message-ID: <202512221531.iVzoDSiK-lkp@intel.com>
References: <1766066445-14144-15-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1766066445-14144-15-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251218]
[cannot apply to rockchip/for-next linus/master ulf-hansson-mmc-mirror/next v6.19-rc1 v6.18 v6.18-rc7 v6.19-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/mmc-dw_mmc-Check-return-value-of-dma_ops-init-in-resume/20251218-222945
base:   next-20251218
patch link:    https://lore.kernel.org/r/1766066445-14144-15-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH 14/18] mmc: dw_mmc: Remove unused register access macros
config: hexagon-randconfig-001-20251222 (https://download.01.org/0day-ci/archive/20251222/202512221531.iVzoDSiK-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251222/202512221531.iVzoDSiK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512221531.iVzoDSiK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/dw_mmc.c:2370:4: error: call to undeclared function '__raw_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2370 |                         mci_fifo_writeq(host->fifo_reg, host->part_buf);
         |                         ^
   drivers/mmc/host/dw_mmc.h:457:41: note: expanded from macro 'mci_fifo_writeq'
     457 | #define mci_fifo_writeq(__value, __reg) __raw_writeq(__reg, __value)
         |                                         ^
   drivers/mmc/host/dw_mmc.c:2387:5: error: call to undeclared function '__raw_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2387 |                                 mci_fifo_writeq(host->fifo_reg, aligned_buf[i]);
         |                                 ^
   drivers/mmc/host/dw_mmc.h:457:41: note: expanded from macro 'mci_fifo_writeq'
     457 | #define mci_fifo_writeq(__value, __reg) __raw_writeq(__reg, __value)
         |                                         ^
   drivers/mmc/host/dw_mmc.c:2395:4: error: call to undeclared function '__raw_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2395 |                         mci_fifo_writeq(host->fifo_reg, *pdata++);
         |                         ^
   drivers/mmc/host/dw_mmc.h:457:41: note: expanded from macro 'mci_fifo_writeq'
     457 | #define mci_fifo_writeq(__value, __reg) __raw_writeq(__reg, __value)
         |                                         ^
   drivers/mmc/host/dw_mmc.c:2404:4: error: call to undeclared function '__raw_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2404 |                         mci_fifo_writeq(host->fifo_reg, host->part_buf);
         |                         ^
   drivers/mmc/host/dw_mmc.h:457:41: note: expanded from macro 'mci_fifo_writeq'
     457 | #define mci_fifo_writeq(__value, __reg) __raw_writeq(__reg, __value)
         |                                         ^
>> drivers/mmc/host/dw_mmc.c:2420:22: error: call to undeclared function '__raw_readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2420 |                                 aligned_buf[i] = mci_fifo_readq(host->fifo_reg);
         |                                                  ^
   drivers/mmc/host/dw_mmc.h:453:31: note: expanded from macro 'mci_fifo_readq'
     453 | #define mci_fifo_readq(__reg)   __raw_readq(__reg)
         |                                 ^
   drivers/mmc/host/dw_mmc.c:2433:15: error: call to undeclared function '__raw_readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2433 |                         *pdata++ = mci_fifo_readq(host->fifo_reg);
         |                                    ^
   drivers/mmc/host/dw_mmc.h:453:31: note: expanded from macro 'mci_fifo_readq'
     453 | #define mci_fifo_readq(__reg)   __raw_readq(__reg)
         |                                 ^
   drivers/mmc/host/dw_mmc.c:2437:20: error: call to undeclared function '__raw_readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2437 |                 host->part_buf = mci_fifo_readq(host->fifo_reg);
         |                                  ^
   drivers/mmc/host/dw_mmc.h:453:31: note: expanded from macro 'mci_fifo_readq'
     453 | #define mci_fifo_readq(__reg)   __raw_readq(__reg)
         |                                 ^
   7 errors generated.


vim +/__raw_writeq +2370 drivers/mmc/host/dw_mmc.c

f95f3850f7a9e1d Will Newton     2011-01-02  2356  
f95f3850f7a9e1d Will Newton     2011-01-02  2357  static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
f95f3850f7a9e1d Will Newton     2011-01-02  2358  {
cfbeb59c7a818a2 Markos Chandras 2013-03-12  2359  	struct mmc_data *data = host->data;
cfbeb59c7a818a2 Markos Chandras 2013-03-12  2360  	int init_cnt = cnt;
cfbeb59c7a818a2 Markos Chandras 2013-03-12  2361  
34b664a20e2664d James Hogan     2011-06-24  2362  	/* try and push anything in the part_buf */
34b664a20e2664d James Hogan     2011-06-24  2363  	if (unlikely(host->part_buf_count)) {
34b664a20e2664d James Hogan     2011-06-24  2364  		int len = dw_mci_push_part_bytes(host, buf, cnt);
0e3a22c044478b6 Shawn Lin       2015-08-03  2365  
34b664a20e2664d James Hogan     2011-06-24  2366  		buf += len;
34b664a20e2664d James Hogan     2011-06-24  2367  		cnt -= len;
c09fbd7451b7972 Seungwon Jeon   2013-03-25  2368  
cfbeb59c7a818a2 Markos Chandras 2013-03-12  2369  		if (host->part_buf_count == 8) {
76184ac17edf3c6 Ben Dooks       2015-03-25 @2370  			mci_fifo_writeq(host->fifo_reg,	host->part_buf);
34b664a20e2664d James Hogan     2011-06-24  2371  			host->part_buf_count = 0;
34b664a20e2664d James Hogan     2011-06-24  2372  		}
34b664a20e2664d James Hogan     2011-06-24  2373  	}
34b664a20e2664d James Hogan     2011-06-24  2374  #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
34b664a20e2664d James Hogan     2011-06-24  2375  	if (unlikely((unsigned long)buf & 0x7)) {
34b664a20e2664d James Hogan     2011-06-24  2376  		while (cnt >= 8) {
34b664a20e2664d James Hogan     2011-06-24  2377  			u64 aligned_buf[16];
34b664a20e2664d James Hogan     2011-06-24  2378  			int len = min(cnt & -8, (int)sizeof(aligned_buf));
34b664a20e2664d James Hogan     2011-06-24  2379  			int items = len >> 3;
34b664a20e2664d James Hogan     2011-06-24  2380  			int i;
34b664a20e2664d James Hogan     2011-06-24  2381  			/* memcpy from input buffer into aligned buffer */
34b664a20e2664d James Hogan     2011-06-24  2382  			memcpy(aligned_buf, buf, len);
34b664a20e2664d James Hogan     2011-06-24  2383  			buf += len;
34b664a20e2664d James Hogan     2011-06-24  2384  			cnt -= len;
34b664a20e2664d James Hogan     2011-06-24  2385  			/* push data from aligned buffer into fifo */
34b664a20e2664d James Hogan     2011-06-24  2386  			for (i = 0; i < items; ++i)
76184ac17edf3c6 Ben Dooks       2015-03-25  2387  				mci_fifo_writeq(host->fifo_reg,	aligned_buf[i]);
34b664a20e2664d James Hogan     2011-06-24  2388  		}
34b664a20e2664d James Hogan     2011-06-24  2389  	} else
34b664a20e2664d James Hogan     2011-06-24  2390  #endif
34b664a20e2664d James Hogan     2011-06-24  2391  	{
34b664a20e2664d James Hogan     2011-06-24  2392  		u64 *pdata = buf;
0e3a22c044478b6 Shawn Lin       2015-08-03  2393  
34b664a20e2664d James Hogan     2011-06-24  2394  		for (; cnt >= 8; cnt -= 8)
76184ac17edf3c6 Ben Dooks       2015-03-25  2395  			mci_fifo_writeq(host->fifo_reg, *pdata++);
34b664a20e2664d James Hogan     2011-06-24  2396  		buf = pdata;
34b664a20e2664d James Hogan     2011-06-24  2397  	}
34b664a20e2664d James Hogan     2011-06-24  2398  	/* put anything remaining in the part_buf */
34b664a20e2664d James Hogan     2011-06-24  2399  	if (cnt) {
34b664a20e2664d James Hogan     2011-06-24  2400  		dw_mci_set_part_bytes(host, buf, cnt);
cfbeb59c7a818a2 Markos Chandras 2013-03-12  2401  		/* Push data if we have reached the expected data length */
cfbeb59c7a818a2 Markos Chandras 2013-03-12  2402  		if ((data->bytes_xfered + init_cnt) ==
cfbeb59c7a818a2 Markos Chandras 2013-03-12  2403  		    (data->blksz * data->blocks))
76184ac17edf3c6 Ben Dooks       2015-03-25 @2404  			mci_fifo_writeq(host->fifo_reg, host->part_buf);
f95f3850f7a9e1d Will Newton     2011-01-02  2405  	}
f95f3850f7a9e1d Will Newton     2011-01-02  2406  }
f95f3850f7a9e1d Will Newton     2011-01-02  2407  
f95f3850f7a9e1d Will Newton     2011-01-02  2408  static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
f95f3850f7a9e1d Will Newton     2011-01-02  2409  {
34b664a20e2664d James Hogan     2011-06-24  2410  #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
34b664a20e2664d James Hogan     2011-06-24  2411  	if (unlikely((unsigned long)buf & 0x7)) {
34b664a20e2664d James Hogan     2011-06-24  2412  		while (cnt >= 8) {
34b664a20e2664d James Hogan     2011-06-24  2413  			/* pull data from fifo into aligned buffer */
34b664a20e2664d James Hogan     2011-06-24  2414  			u64 aligned_buf[16];
34b664a20e2664d James Hogan     2011-06-24  2415  			int len = min(cnt & -8, (int)sizeof(aligned_buf));
34b664a20e2664d James Hogan     2011-06-24  2416  			int items = len >> 3;
34b664a20e2664d James Hogan     2011-06-24  2417  			int i;
0e3a22c044478b6 Shawn Lin       2015-08-03  2418  
34b664a20e2664d James Hogan     2011-06-24  2419  			for (i = 0; i < items; ++i)
76184ac17edf3c6 Ben Dooks       2015-03-25 @2420  				aligned_buf[i] = mci_fifo_readq(host->fifo_reg);
76184ac17edf3c6 Ben Dooks       2015-03-25  2421  
34b664a20e2664d James Hogan     2011-06-24  2422  			/* memcpy from aligned buffer into output buffer */
34b664a20e2664d James Hogan     2011-06-24  2423  			memcpy(buf, aligned_buf, len);
34b664a20e2664d James Hogan     2011-06-24  2424  			buf += len;
34b664a20e2664d James Hogan     2011-06-24  2425  			cnt -= len;
34b664a20e2664d James Hogan     2011-06-24  2426  		}
34b664a20e2664d James Hogan     2011-06-24  2427  	} else
34b664a20e2664d James Hogan     2011-06-24  2428  #endif
34b664a20e2664d James Hogan     2011-06-24  2429  	{
34b664a20e2664d James Hogan     2011-06-24  2430  		u64 *pdata = buf;
0e3a22c044478b6 Shawn Lin       2015-08-03  2431  
34b664a20e2664d James Hogan     2011-06-24  2432  		for (; cnt >= 8; cnt -= 8)
76184ac17edf3c6 Ben Dooks       2015-03-25  2433  			*pdata++ = mci_fifo_readq(host->fifo_reg);
34b664a20e2664d James Hogan     2011-06-24  2434  		buf = pdata;
f95f3850f7a9e1d Will Newton     2011-01-02  2435  	}
34b664a20e2664d James Hogan     2011-06-24  2436  	if (cnt) {
76184ac17edf3c6 Ben Dooks       2015-03-25  2437  		host->part_buf = mci_fifo_readq(host->fifo_reg);
34b664a20e2664d James Hogan     2011-06-24  2438  		dw_mci_pull_final_bytes(host, buf, cnt);
34b664a20e2664d James Hogan     2011-06-24  2439  	}
34b664a20e2664d James Hogan     2011-06-24  2440  }
34b664a20e2664d James Hogan     2011-06-24  2441  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
