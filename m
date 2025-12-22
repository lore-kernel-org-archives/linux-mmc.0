Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E632D44B
	for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766391929; cv=none; b=Z1b01gniXOzD9B2c15QPEX6ac3G0ej9vaKlAxpI6GBfhBOyuN4DD0QwhGZ97vvx3xk58NNyQJOYHu2AEv5KQI1IMohtY3IJKV3eN/zwdczJsVyGCVQ4f0Vxifr6k1+XPsUbYYBrK7qg/dQv3LgnTs1507Vm3si0PN2UG5tnEeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766391929; c=relaxed/simple;
	bh=duwcowZ2Tp9bU8jZQF+DTECUctuaZr7skmMWcW9ts+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkBEgAobVZwjfP1Pez8R3bmr1xSpzMQwXHcxN9fZ54mOGAwHmdCSBaU1JqnTxKKexwdgY//75WLyoSaNFj3Yicr3Vto7hmusk/ITtrh6i6Q2w5KZScglUN1bsQ/DuhBF1NuX2vJfL/vDvsOj/JVeapt+BQOVH5yOp38JmmMs8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixv6V3mu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixv6V3mu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766391927; x=1797927927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=duwcowZ2Tp9bU8jZQF+DTECUctuaZr7skmMWcW9ts+E=;
  b=ixv6V3muPT+2KL6GWzVXmJA1va5QZjVU9yrlPzkwHkZJdh5MTD8s7K8N
   PqqFYMYgRE4wAGflgz2VEXzJ5+KoTXrLPloECpVZ8dS/U9hnZbovv5NhS
   O4TlDdrqhCzOx1V93X7YjNmLur21x/xi7BGrDzNVAmtYkhgFT2EMtnMZs
   SifhMfx2bQUmgaOc8rKsl8/+6gMmYzUYGluG1/zb2dJLku7Q8k6kizUze
   MaQkSHa2sHtmHJtmXmK5tdbZ0pO8ZWmj5RIMQ5YwyP9loqv22zX/mv5th
   SdHql6NFjlwBIRnLqmm6GCewGHzAnaYIHsneKNvGzfwvu7pSy792izDg+
   Q==;
X-CSE-ConnectionGUID: pj4quQb3Q6OnGHebTXLDag==
X-CSE-MsgGUID: zKkrIrb4TAKhrJ/pR5iN7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="68126231"
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="68126231"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 00:25:27 -0800
X-CSE-ConnectionGUID: vVw6QRdKS7S9OpMKI234Hg==
X-CSE-MsgGUID: /ik4qapjQF6vb9f0zRb9vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="203600969"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Dec 2025 00:25:24 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXbEI-000000000GX-0yVC;
	Mon, 22 Dec 2025 08:25:22 +0000
Date: Mon, 22 Dec 2025 16:24:43 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 17/18] mmc: dw_mmc-pltfm: use modern PM macros
Message-ID: <202512221642.SEMmxjZw-lkp@intel.com>
References: <1766066445-14144-18-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1766066445-14144-18-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251218]
[cannot apply to rockchip/for-next linus/master ulf-hansson-mmc-mirror/next v6.19-rc1 v6.18 v6.18-rc7 v6.19-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/mmc-dw_mmc-Check-return-value-of-dma_ops-init-in-resume/20251218-222945
base:   next-20251218
patch link:    https://lore.kernel.org/r/1766066445-14144-18-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH 17/18] mmc: dw_mmc-pltfm: use modern PM macros
config: hexagon-randconfig-001-20251222 (https://download.01.org/0day-ci/archive/20251222/202512221642.SEMmxjZw-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251222/202512221642.SEMmxjZw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512221642.SEMmxjZw-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/dw_mmc.c:2368:4: error: call to undeclared function '__raw_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2368 |                         mci_fifo_writeq(host->fifo_reg, host->part_buf);
         |                         ^
   drivers/mmc/host/dw_mmc.h:457:41: note: expanded from macro 'mci_fifo_writeq'
     457 | #define mci_fifo_writeq(__value, __reg) __raw_writeq(__reg, __value)
         |                                         ^
   drivers/mmc/host/dw_mmc.c:2385:5: error: call to undeclared function '__raw_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2385 |                                 mci_fifo_writeq(host->fifo_reg, aligned_buf[i]);
         |                                 ^
   drivers/mmc/host/dw_mmc.h:457:41: note: expanded from macro 'mci_fifo_writeq'
     457 | #define mci_fifo_writeq(__value, __reg) __raw_writeq(__reg, __value)
         |                                         ^
   drivers/mmc/host/dw_mmc.c:2393:4: error: call to undeclared function '__raw_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2393 |                         mci_fifo_writeq(host->fifo_reg, *pdata++);
         |                         ^
   drivers/mmc/host/dw_mmc.h:457:41: note: expanded from macro 'mci_fifo_writeq'
     457 | #define mci_fifo_writeq(__value, __reg) __raw_writeq(__reg, __value)
         |                                         ^
   drivers/mmc/host/dw_mmc.c:2402:4: error: call to undeclared function '__raw_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2402 |                         mci_fifo_writeq(host->fifo_reg, host->part_buf);
         |                         ^
   drivers/mmc/host/dw_mmc.h:457:41: note: expanded from macro 'mci_fifo_writeq'
     457 | #define mci_fifo_writeq(__value, __reg) __raw_writeq(__reg, __value)
         |                                         ^
   drivers/mmc/host/dw_mmc.c:2418:22: error: call to undeclared function '__raw_readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2418 |                                 aligned_buf[i] = mci_fifo_readq(host->fifo_reg);
         |                                                  ^
   drivers/mmc/host/dw_mmc.h:453:31: note: expanded from macro 'mci_fifo_readq'
     453 | #define mci_fifo_readq(__reg)   __raw_readq(__reg)
         |                                 ^
   drivers/mmc/host/dw_mmc.c:2431:15: error: call to undeclared function '__raw_readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2431 |                         *pdata++ = mci_fifo_readq(host->fifo_reg);
         |                                    ^
   drivers/mmc/host/dw_mmc.h:453:31: note: expanded from macro 'mci_fifo_readq'
     453 | #define mci_fifo_readq(__reg)   __raw_readq(__reg)
         |                                 ^
   drivers/mmc/host/dw_mmc.c:2435:20: error: call to undeclared function '__raw_readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2435 |                 host->part_buf = mci_fifo_readq(host->fifo_reg);
         |                                  ^
   drivers/mmc/host/dw_mmc.h:453:31: note: expanded from macro 'mci_fifo_readq'
     453 | #define mci_fifo_readq(__reg)   __raw_readq(__reg)
         |                                 ^
>> drivers/mmc/host/dw_mmc.c:3438:5: error: redefinition of 'dw_mci_runtime_suspend'
    3438 | int dw_mci_runtime_suspend(struct device *dev)
         |     ^
   drivers/mmc/host/dw_mmc.h:496:19: note: previous definition is here
     496 | static inline int dw_mci_runtime_suspend(struct device *device) { return -EOPNOTSUPP; }
         |                   ^
>> drivers/mmc/host/dw_mmc.c:3456:5: error: redefinition of 'dw_mci_runtime_resume'
    3456 | int dw_mci_runtime_resume(struct device *dev)
         |     ^
   drivers/mmc/host/dw_mmc.h:497:19: note: previous definition is here
     497 | static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTSUPP; }
         |                   ^
   9 errors generated.


vim +/dw_mci_runtime_suspend +3438 drivers/mmc/host/dw_mmc.c

62ca8034d940439 Shashidhar Hiremath 2012-01-13  3437  
ed24e1ff5ae3d74 Shawn Lin           2016-10-12 @3438  int dw_mci_runtime_suspend(struct device *dev)
f95f3850f7a9e1d Will Newton         2011-01-02  3439  {
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3440  	struct dw_mci *host = dev_get_drvdata(dev);
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3441  
3fc7eaef44dbcbc Shawn Lin           2015-09-16  3442  	if (host->use_dma && host->dma_ops->exit)
3fc7eaef44dbcbc Shawn Lin           2015-09-16  3443  		host->dma_ops->exit(host);
3fc7eaef44dbcbc Shawn Lin           2015-09-16  3444  
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3445  	clk_disable_unprepare(host->ciu_clk);
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3446  
926311cf33618e6 Shawn Lin           2025-12-16  3447  	if (host &&
6ac3503c447016a Shawn Lin           2025-12-16  3448  	    (mmc_host_can_gpio_cd(host->mmc) ||
6ac3503c447016a Shawn Lin           2025-12-16  3449  	     !mmc_card_is_removable(host->mmc)))
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3450  		clk_disable_unprepare(host->biu_clk);
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3451  
f95f3850f7a9e1d Will Newton         2011-01-02  3452  	return 0;
f95f3850f7a9e1d Will Newton         2011-01-02  3453  }
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3454  EXPORT_SYMBOL(dw_mci_runtime_suspend);
f95f3850f7a9e1d Will Newton         2011-01-02  3455  
ed24e1ff5ae3d74 Shawn Lin           2016-10-12 @3456  int dw_mci_runtime_resume(struct device *dev)
f95f3850f7a9e1d Will Newton         2011-01-02  3457  {
b23475faed77f6a Jaehoon Chung       2017-06-05  3458  	int ret = 0;
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3459  	struct dw_mci *host = dev_get_drvdata(dev);
f95f3850f7a9e1d Will Newton         2011-01-02  3460  
926311cf33618e6 Shawn Lin           2025-12-16  3461  	if (host &&
6ac3503c447016a Shawn Lin           2025-12-16  3462  	    (mmc_host_can_gpio_cd(host->mmc) ||
6ac3503c447016a Shawn Lin           2025-12-16  3463  	     !mmc_card_is_removable(host->mmc))) {
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3464  		ret = clk_prepare_enable(host->biu_clk);
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3465  		if (ret)
e61cf1184d72e57 Jaehoon Chung       2011-03-17  3466  			return ret;
e61cf1184d72e57 Jaehoon Chung       2011-03-17  3467  	}
e61cf1184d72e57 Jaehoon Chung       2011-03-17  3468  
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3469  	ret = clk_prepare_enable(host->ciu_clk);
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3470  	if (ret)
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3471  		goto err;
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3472  
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3473  	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3474  		clk_disable_unprepare(host->ciu_clk);
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3475  		ret = -ENODEV;
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3476  		goto err;
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3477  	}
ed24e1ff5ae3d74 Shawn Lin           2016-10-12  3478  
b99f9a35a19687b Shawn Lin           2025-12-18  3479  	if (host->use_dma && host->dma_ops->init) {
b99f9a35a19687b Shawn Lin           2025-12-18  3480  		ret = host->dma_ops->init(host);
b99f9a35a19687b Shawn Lin           2025-12-18  3481  		if (ret)
b99f9a35a19687b Shawn Lin           2025-12-18  3482  			return ret;
b99f9a35a19687b Shawn Lin           2025-12-18  3483  	}
141a712a4eb0963 Seungwon Jeon       2012-05-22  3484  
524268990e54dab Seungwon Jeon       2013-08-31  3485  	/*
524268990e54dab Seungwon Jeon       2013-08-31  3486  	 * Restore the initial value at FIFOTH register
524268990e54dab Seungwon Jeon       2013-08-31  3487  	 * And Invalidate the prev_blksz with zero
524268990e54dab Seungwon Jeon       2013-08-31  3488  	 */
e61cf1184d72e57 Jaehoon Chung       2011-03-17  3489  	mci_writel(host, FIFOTH, host->fifoth_val);
524268990e54dab Seungwon Jeon       2013-08-31  3490  	host->prev_blksz = 0;
e61cf1184d72e57 Jaehoon Chung       2011-03-17  3491  
2eb2944fa7d1470 Doug Anderson       2013-08-31  3492  	/* Put in max timeout */
2eb2944fa7d1470 Doug Anderson       2013-08-31  3493  	mci_writel(host, TMOUT, 0xFFFFFFFF);
2eb2944fa7d1470 Doug Anderson       2013-08-31  3494  
e61cf1184d72e57 Jaehoon Chung       2011-03-17  3495  	mci_writel(host, RINTSTS, 0xFFFFFFFF);
e61cf1184d72e57 Jaehoon Chung       2011-03-17  3496  	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
e61cf1184d72e57 Jaehoon Chung       2011-03-17  3497  		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
fa0c328343c6314 Doug Anderson       2015-02-25  3498  		   DW_MCI_ERROR_FLAGS);
e61cf1184d72e57 Jaehoon Chung       2011-03-17  3499  	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
e61cf1184d72e57 Jaehoon Chung       2011-03-17  3500  
0e3a22c044478b6 Shawn Lin           2015-08-03  3501  
926311cf33618e6 Shawn Lin           2025-12-16  3502  	if (host && host->mmc->pm_flags & MMC_PM_KEEP_POWER)
6ac3503c447016a Shawn Lin           2025-12-16  3503  		dw_mci_set_ios(host->mmc, &host->mmc->ios);
e9748e0364fe82d Ziyuan Xu           2017-01-17  3504  
e9748e0364fe82d Ziyuan Xu           2017-01-17  3505  	/* Force setup bus to guarantee available clock output */
926311cf33618e6 Shawn Lin           2025-12-16  3506  	dw_mci_setup_bus(host, true);
fa0c328343c6314 Doug Anderson       2015-02-25  3507  
7c526608d5afb62 Ulf Hansson         2019-09-08  3508  	/* Re-enable SDIO interrupts. */
6ac3503c447016a Shawn Lin           2025-12-16  3509  	if (sdio_irq_claimed(host->mmc))
926311cf33618e6 Shawn Lin           2025-12-16  3510  		__dw_mci_enable_sdio_irq(host, 1);
7c526608d5afb62 Ulf Hansson         2019-09-08  3511  
926311cf33618e6 Shawn Lin           2025-12-16  3512  	/* Now that host is setup, we can enable card detect */
fa0c328343c6314 Doug Anderson       2015-02-25  3513  	dw_mci_enable_cd(host);
fa0c328343c6314 Doug Anderson       2015-02-25  3514  
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3515  	return 0;
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3516  
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3517  err:
926311cf33618e6 Shawn Lin           2025-12-16  3518  	if (host &&
6ac3503c447016a Shawn Lin           2025-12-16  3519  	    (mmc_host_can_gpio_cd(host->mmc) ||
6ac3503c447016a Shawn Lin           2025-12-16  3520  	     !mmc_card_is_removable(host->mmc)))
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3521  		clk_disable_unprepare(host->biu_clk);
df9bcc2bc0a1f8d Joonyoung Shim      2016-11-25  3522  
1f5c51d76e8f304 Shawn Lin           2016-10-12  3523  	return ret;
1f5c51d76e8f304 Shawn Lin           2016-10-12  3524  }
e9ed8835e990474 Shawn Lin           2016-10-12  3525  EXPORT_SYMBOL(dw_mci_runtime_resume);
6fe8890d0200ea0 Jaehoon Chung       2011-12-08  3526  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
