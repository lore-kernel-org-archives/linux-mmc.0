Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851E19E967;
	Sun, 13 Jul 2025 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752388395; cv=none; b=S6p+CID+8JyEJ9w9DnBqO8Sp0iCpPyOoJpBgZw5zUEgBHNf0Zz6p1O2LoAo2v7yacb0w6fx9GiOoahAdYt3N960QY6GpwzXCC6PABWif3u5h8DaL9NBSU8MIiHF0E98idIJ5mYVfcZzAJRWTOBZMY0CQYDPiBWsGE0JMeCluT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752388395; c=relaxed/simple;
	bh=RV2fZ2M4TKY0D92MjssBZlAVgtq65IeP0WmOHlbH5hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiFsJw2dRGEym/CRg0jf/C8j6ZroDp8WII/UAXpe9jJiNQnEh5kzarlg3ESxQBTNBPARLz+LMrmY+z/bztGbmkl+ss4hwG/57hyckOT6W59hz8V8bSy3cZYbX0gvOnAQVfqZU5FLrsLzJmjApfZ0UY1WyH0+pK5wF8D74Hkw+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3zn32Zg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3zn32Zg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752388393; x=1783924393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RV2fZ2M4TKY0D92MjssBZlAVgtq65IeP0WmOHlbH5hI=;
  b=G3zn32ZggHBfCMjiJaMVd3bwyWnksBWFAwuCTrCafold0KzMQO/U7muS
   +VL1cMhONUSroeYfoeZuEJyYgeNmm8wyOCvwvb4sJgaLVOHOoz5Vu0ydC
   iQRE/xNeksbHAimVVb4RTCb+GINNmiMToHi+KCZXgBZQj8lWbcWfJGVr3
   7nF4wFCFUWgyfQIt00UUfojpkH+7NwrMImV27Q9sB9Y1UhhgXrrt6l61M
   0XD3v7XuI8sTGqq+75l41fjjl5zsKsBJHORQrSSbdJZRJtmMTOjDLp69O
   RZAJIUZE0L/dhL1NkOv4TBGYDfbPHJ8iivoEdo949J27oPIeT2FqMfCI5
   g==;
X-CSE-ConnectionGUID: QU/8y/C9R4yPEG5vnKxk6Q==
X-CSE-MsgGUID: QVg8f5ewRzSBb8kOW4zVtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65319372"
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="65319372"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 23:33:13 -0700
X-CSE-ConnectionGUID: 7P1p74VrRPeSyGGK8aOmsA==
X-CSE-MsgGUID: Gk/3Mb/kQ7yzmO6RcneGmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="157018597"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 Jul 2025 23:33:09 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaqGo-0007wR-2u;
	Sun, 13 Jul 2025 06:33:06 +0000
Date: Sun, 13 Jul 2025 14:33:01 +0800
From: kernel test robot <lkp@intel.com>
To: Kamal Dasu <kamal.dasu@broadcom.com>, andersson@kernel.org,
	baolin.wang@linux.alibaba.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: oe-kbuild-all@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com,
	kamal.dasu@broadcom.com, linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	Kamal Dasu <kdasu@broadcom.com>
Subject: Re: [PATCH 2/4] hwspinlock: brcmstb hardware semaphore support
Message-ID: <202507131422.6eIuyxUJ-lkp@intel.com>
References: <20250711154221.928164-4-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711154221.928164-4-kamal.dasu@broadcom.com>

Hi Kamal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.16-rc5 next-20250711]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/dt-bindings-brcmstb-hwspinlock-support-for-hwspinlock/20250712-034624
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250711154221.928164-4-kamal.dasu%40broadcom.com
patch subject: [PATCH 2/4] hwspinlock: brcmstb hardware semaphore support
config: arc-randconfig-r111-20250713 (https://download.01.org/0day-ci/archive/20250713/202507131422.6eIuyxUJ-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250713/202507131422.6eIuyxUJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507131422.6eIuyxUJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hwspinlock/brcmstb_hwspinlock.c:26:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *lock_addr @@     got void *priv @@
   drivers/hwspinlock/brcmstb_hwspinlock.c:26:39: sparse:     expected void [noderef] __iomem *lock_addr
   drivers/hwspinlock/brcmstb_hwspinlock.c:26:39: sparse:     got void *priv
   drivers/hwspinlock/brcmstb_hwspinlock.c:35:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *lock_addr @@     got void *priv @@
   drivers/hwspinlock/brcmstb_hwspinlock.c:35:39: sparse:     expected void [noderef] __iomem *lock_addr
   drivers/hwspinlock/brcmstb_hwspinlock.c:35:39: sparse:     got void *priv
>> drivers/hwspinlock/brcmstb_hwspinlock.c:73:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/hwspinlock/brcmstb_hwspinlock.c:73:30: sparse:     expected void *priv
   drivers/hwspinlock/brcmstb_hwspinlock.c:73:30: sparse:     got void [noderef] __iomem *

vim +26 drivers/hwspinlock/brcmstb_hwspinlock.c

    23	
    24	static int brcmstb_hwspinlock_trylock(struct hwspinlock *lock)
    25	{
  > 26		void __iomem *lock_addr = lock->priv;
    27	
    28		writel(HWSPINLOCK_VAL, lock_addr);
    29	
    30		return (readl(lock_addr) == HWSPINLOCK_VAL);
    31	}
    32	
    33	static void brcmstb_hwspinlock_unlock(struct hwspinlock *lock)
    34	{
    35		void __iomem *lock_addr = lock->priv;
    36	
    37		/* release the lock by writing 0 to it */
    38		writel(RESET_SEMAPHORE, lock_addr);
    39	}
    40	
    41	static void brcmstb_hwspinlock_relax(struct hwspinlock *lock)
    42	{
    43		ndelay(50);
    44	}
    45	
    46	static const struct hwspinlock_ops brcmstb_hwspinlock_ops = {
    47		.trylock	= brcmstb_hwspinlock_trylock,
    48		.unlock		= brcmstb_hwspinlock_unlock,
    49		.relax		= brcmstb_hwspinlock_relax,
    50	};
    51	
    52	static int brcmstb_hwspinlock_probe(struct platform_device *pdev)
    53	{
    54		struct hwspinlock_device *bank;
    55		struct hwspinlock *hwlock;
    56		void __iomem *io_base;
    57		int i, num_locks = BRCMSTB_MAX_SEMAPHORES;
    58	
    59		io_base = devm_platform_ioremap_resource(pdev, 0);
    60		if (IS_ERR(io_base)) {
    61			dev_err(&pdev->dev, "semaphore iobase mapping error\n");
    62			return PTR_ERR(io_base);
    63		}
    64	
    65		bank = devm_kzalloc(&pdev->dev, struct_size(bank, lock, num_locks),
    66				    GFP_KERNEL);
    67		if (!bank)
    68			return -ENOMEM;
    69	
    70		platform_set_drvdata(pdev, bank);
    71	
    72		for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
  > 73			hwlock->priv = io_base + sizeof(u32) * i;
    74	
    75		return devm_hwspin_lock_register(&pdev->dev, bank,
    76						 &brcmstb_hwspinlock_ops,
    77						 0, num_locks);
    78	}
    79	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
