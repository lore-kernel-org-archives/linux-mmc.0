Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4D2D8DC3
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654436; cv=none; b=Zn8QwefLVj470ABd/h6gHfgoQxUNd3v91KmcKPuVHH4YSg1znetm2BPTEZzcmXyx0mQ9LszduIj44yq74M6HWkXH5OHTf7LKv8Ac5bUY4OlYW/TmJxmx8RyQ4RkujMtSKe1r4iYGoyrjlvNzc4CMjKI3WAt65T0zM26f5j5YX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654436; c=relaxed/simple;
	bh=AwoFhfHB65Rsiv5PesshxAZvETzOOKhUWF8bqFlUsMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQOTkwVnpViahdZRxyZa3ZnuiJnl35q4dOPhvUXp7GR/y9mTrSipWqaKPxUgH2aTh6j8onUfT8IThXugLuuoZqunZ/ZVArSySNtTRE6FZCPaLr1hFc6Muib8wAsl3wKy7JlrCMNI8A90ZDcugAsl5MLVbbz38a8m3QqRjnoI9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxaikR0y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxaikR0y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763654434; x=1795190434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AwoFhfHB65Rsiv5PesshxAZvETzOOKhUWF8bqFlUsMw=;
  b=CxaikR0ya4zUSxEXEv1buhxO2ItJllhzgZSzhUWh7CgTg3f9Ft2HXv5q
   nxjL3MQ86xS1qIfHkwcDXSOBbDwlDTHg7Yxgdo02pXE6MDqiekvIYv387
   tRQIdPquMf2lCfRIsBfy3NAbcb4IjkGFdgEUqghdBkfeN2YwG85XMpCmV
   trOtLrkQ8AMHWKGxZ4N0D+8kdr6OT6XpBmJN2uldkWr1TQcxqY6t0EWSC
   JpTYuiizOD5Gv7RtCuT4FdE8GVNa/RC71mp0t03zpdcY8Em+OJT0W/N6j
   Au1SjN9X3y/PQtMHUn2QKNErdERxaRksw+PmdaWbR6/gL9chI2NvoQVkV
   A==;
X-CSE-ConnectionGUID: bP06DYnsTHKmS+NpHKRuFw==
X-CSE-MsgGUID: jQssgynSQGWhB9L4xVrwKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65674232"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65674232"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 08:00:34 -0800
X-CSE-ConnectionGUID: zSPPkakLSf2F3dEc9oFl2w==
X-CSE-MsgGUID: Je1DeRWyQ5u3NdUQU3sGFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191210814"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Nov 2025 08:00:33 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vM75C-0004D1-0w;
	Thu, 20 Nov 2025 16:00:30 +0000
Date: Fri, 21 Nov 2025 00:00:06 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add dw_mci_prepare_desc() for both of
 32bit and 64bit DMA
Message-ID: <202511202301.b4PYJbNg-lkp@intel.com>
References: <1763540498-84315-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763540498-84315-2-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v6.18-rc6 next-20251120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/mmc-dw_mmc-add-dw_mci_prepare_desc-for-both-of-32bit-and-64bit-DMA/20251119-163950
base:   linus/master
patch link:    https://lore.kernel.org/r/1763540498-84315-2-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH 2/2] mmc: dw_mmc: add dw_mci_prepare_desc() for both of 32bit and 64bit DMA
config: arm64-randconfig-r121-20251120 (https://download.01.org/0day-ci/archive/20251120/202511202301.b4PYJbNg-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0bba1e76581bad04e7d7f09f5115ae5e2989e0d9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511202301.b4PYJbNg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511202301.b4PYJbNg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mmc/host/dw_mmc.c:609:29: sparse: sparse: incompatible types in conditional expression (different base types):
   drivers/mmc/host/dw_mmc.c:609:29: sparse:    unsigned int *
   drivers/mmc/host/dw_mmc.c:609:29: sparse:    restricted __le32 *

vim +609 drivers/mmc/host/dw_mmc.c

   577	
   578	static inline int dw_mci_prepare_desc(struct dw_mci *host, struct mmc_data *data,
   579					      unsigned int sg_len, bool is_64bit)
   580	{
   581		unsigned int desc_len;
   582		struct idmac_desc *desc_first, *desc_last, *desc;
   583		struct idmac_desc_64addr *desc64_first, *desc64_last, *desc64;
   584		u32 val, des0;
   585		int i;
   586	
   587		if (is_64bit)
   588			desc64_first = desc64_last = desc64 = host->sg_cpu;
   589		else
   590			desc_first = desc_last = desc = host->sg_cpu;
   591	
   592		for (i = 0; i < sg_len; i++) {
   593			unsigned int length = sg_dma_len(&data->sg[i]);
   594	
   595			u64 mem_addr = sg_dma_address(&data->sg[i]);
   596	
   597			for ( ; length ; desc++) {
   598				desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
   599					   length : DW_MCI_DESC_DATA_LENGTH;
   600	
   601				length -= desc_len;
   602	
   603				/*
   604				 * Wait for the former clear OWN bit operation
   605				 * of IDMAC to make sure that this descriptor
   606				 * isn't still owned by IDMAC as IDMAC's write
   607				 * ops and CPU's read ops are asynchronous.
   608				 */
 > 609				if (readl_poll_timeout_atomic(is_64bit ? &desc64->des0 : &desc->des0,
   610							val, IDMAC_OWN_CLR64(val), 10, 100 * USEC_PER_MSEC))
   611					goto err_own_bit;
   612	
   613				des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
   614				if (is_64bit)
   615					desc64->des0 = des0;
   616				else
   617					desc->des0 = cpu_to_le32(des0);
   618	
   619				/*
   620				 * 1. Set OWN bit and disable interrupts for this descriptor
   621				 * 2. Set Buffer length
   622				 * Set physical address to DMA to/from
   623				 */
   624				if (is_64bit) {
   625					desc64->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
   626					IDMAC_64ADDR_SET_BUFFER1_SIZE(desc64, desc_len);
   627					desc64->des4 = mem_addr & 0xffffffff;
   628					desc64->des5 = mem_addr >> 32;
   629				} else {
   630					IDMAC_SET_BUFFER1_SIZE(desc, desc_len);
   631					desc->des2 = cpu_to_le32(mem_addr);
   632				}
   633	
   634				/* Update physical address for the next desc */
   635				mem_addr += desc_len;
   636	
   637				/* Save pointer to the last descriptor */
   638				if (is_64bit)
   639					desc64_last = desc64;
   640				else
   641					desc_last = desc;
   642			}
   643		}
   644	
   645		/* Set the first descriptor and the last descriptor */
   646		if (is_64bit) {
   647			desc64_first->des0 |= IDMAC_DES0_FD;
   648			desc64_last->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
   649			desc64_last->des0 |= IDMAC_DES0_LD;
   650		} else {
   651			desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
   652			desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH | IDMAC_DES0_DIC));
   653			desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
   654		}
   655	
   656		return 0;
   657	err_own_bit:
   658		/* restore the descriptor chain as it's polluted */
   659		dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
   660		memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
   661		dw_mci_idmac_init(host);
   662		return -EINVAL;
   663	}
   664	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
