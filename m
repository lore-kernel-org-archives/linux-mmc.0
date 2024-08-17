Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE19149E1A;
	Sat, 17 Aug 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894602; cv=none; b=gae3tUCjNyVS2FKuB1MjIz2NHNJSW1vuwoJFwsgaf1FjEAnFM5yv09J7DQpPNKl1FNApy8QuRmeraz5BhwgY57EzD4oGyPGCV+Db6Ht6RURQWgGuOD7odTJxKM7I3R7Hhq+UD25CsnOJIjo8VLH+kBGiwjFw2Y3gJkxRJsHZYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894602; c=relaxed/simple;
	bh=9yTAN+FJALJO5RPttZwsbiiUQgEuBJUfPRhzN5sTCz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcnzcncdQ4gyrogwUGNgfeL6utCsTZB2zpyx653FZJMOUCp3SUJNELNWT7HPpl84JU4zoyMFqIZms0QJGnOdLs7r+GpSQ/kfnIyjOpHdNvKHtAJCn1DvY+2f/KGCyQDGILHqcN8Kf71REzuVWodOWW7Uxo+6oKh99fZzPju1/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwyUr8lc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwyUr8lc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723894601; x=1755430601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9yTAN+FJALJO5RPttZwsbiiUQgEuBJUfPRhzN5sTCz8=;
  b=hwyUr8lcy+xDKuXK4EIQphe2uqfQeD6HPMXd5Z/5LusoXTnfjfvIljy6
   ySBwBqSN7YuF9Z/edwf8uWAjzZqmwmFWp+X+fgno3zFKFR+DoWq6M050d
   tD+v/YZlHCMyC54Fei71qT2841wNUWFyWS1dUQ1PvuOvHAXP8y/lg14Iy
   GdzPALvi89TMU/mhPDAVfu6TpHAW8+QwJjpvB1Yr4zk6UnMOTJ1SOFxvb
   l7KraaTjB0vzpiYy6k8Laf4mfMLlZX/np+UX6qojjUmb7LdTjpJ2GlYCl
   7kDW/eoRPEPPZ4DKzqagkjDd0MYBmioOnmcDo7kCInP4BR0BWUUtt0mPu
   A==;
X-CSE-ConnectionGUID: USnarbtbSsqAkPEAZ1YqwQ==
X-CSE-MsgGUID: VwGhbQylT6qjsbMjUQVacA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22325217"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="22325217"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 04:36:38 -0700
X-CSE-ConnectionGUID: ozeieMuATguo4VUGdbJcow==
X-CSE-MsgGUID: Llap0mEITnuubxdbbocKcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="60471721"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Aug 2024 04:36:34 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfHjU-0007Oy-1B;
	Sat, 17 Aug 2024 11:36:32 +0000
Date: Sat, 17 Aug 2024 19:36:32 +0800
From: kernel test robot <lkp@intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, chaotian.jing@mediatek.com,
	ulf.hansson@linaro.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: Re: [PATCH] mmc: mtk-sd: Improve data type in msdc_timeout_cal()
Message-ID: <202408171942.A1TKwW7h-lkp@intel.com>
References: <20240815234602.59684-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815234602.59684-1-thorsten.blum@toblux.com>

Hi Thorsten,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thorsten-Blum/mmc-mtk-sd-Improve-data-type-in-msdc_timeout_cal/20240816-102400
base:   linus/master
patch link:    https://lore.kernel.org/r/20240815234602.59684-1-thorsten.blum%40toblux.com
patch subject: [PATCH] mmc: mtk-sd: Improve data type in msdc_timeout_cal()
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240817/202408171942.A1TKwW7h-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408171942.A1TKwW7h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408171942.A1TKwW7h-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/mmc/host/mtk-sd.c:11:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/mmc/host/mtk-sd.c:11:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/mmc/host/mtk-sd.c:11:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/mmc/host/mtk-sd.c:11:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/mmc/host/mtk-sd.c:805:3: warning: comparison of distinct pointer types ('typeof ((clk_ns)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
     805 |                 do_div(clk_ns, mmc->actual_clock);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
>> drivers/mmc/host/mtk-sd.c:805:3: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     805 |                 do_div(clk_ns, mmc->actual_clock);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                                      ^
>> drivers/mmc/host/mtk-sd.c:805:3: warning: shift count >= width of type [-Wshift-count-overflow]
     805 |                 do_div(clk_ns, mmc->actual_clock);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   9 warnings and 1 error generated.


vim +805 drivers/mmc/host/mtk-sd.c

208489032bdd8d Chaotian Jing              2015-06-15  794  
557011b6b8c87c Chun-Hung Wu               2020-07-20  795  static u64 msdc_timeout_cal(struct msdc_host *host, u64 ns, u64 clks)
208489032bdd8d Chaotian Jing              2015-06-15  796  {
0caf60c4b110b5 Amey Narkhede              2020-09-18  797  	struct mmc_host *mmc = mmc_from_priv(host);
d5c9ac0e2eb203 Thorsten Blum              2024-08-16  798  	u64 timeout;
d5c9ac0e2eb203 Thorsten Blum              2024-08-16  799  	u32 clk_ns, mode = 0;
208489032bdd8d Chaotian Jing              2015-06-15  800  
0caf60c4b110b5 Amey Narkhede              2020-09-18  801  	if (mmc->actual_clock == 0) {
208489032bdd8d Chaotian Jing              2015-06-15  802  		timeout = 0;
208489032bdd8d Chaotian Jing              2015-06-15  803  	} else {
d5c9ac0e2eb203 Thorsten Blum              2024-08-16  804  		clk_ns  = 1000000000U;
0caf60c4b110b5 Amey Narkhede              2020-09-18 @805  		do_div(clk_ns, mmc->actual_clock);
557011b6b8c87c Chun-Hung Wu               2020-07-20  806  		timeout = ns + clk_ns - 1;
557011b6b8c87c Chun-Hung Wu               2020-07-20  807  		do_div(timeout, clk_ns);
557011b6b8c87c Chun-Hung Wu               2020-07-20  808  		timeout += clks;
208489032bdd8d Chaotian Jing              2015-06-15  809  		/* in 1048576 sclk cycle unit */
4fe54318496004 AngeloGioacchino Del Regno 2021-12-16  810  		timeout = DIV_ROUND_UP(timeout, BIT(20));
762d491a8bff7a Chaotian Jing              2017-10-16  811  		if (host->dev_comp->clk_div_bits == 8)
762d491a8bff7a Chaotian Jing              2017-10-16  812  			sdr_get_field(host->base + MSDC_CFG,
762d491a8bff7a Chaotian Jing              2017-10-16  813  				      MSDC_CFG_CKMOD, &mode);
762d491a8bff7a Chaotian Jing              2017-10-16  814  		else
762d491a8bff7a Chaotian Jing              2017-10-16  815  			sdr_get_field(host->base + MSDC_CFG,
762d491a8bff7a Chaotian Jing              2017-10-16  816  				      MSDC_CFG_CKMOD_EXTRA, &mode);
208489032bdd8d Chaotian Jing              2015-06-15  817  		/*DDR mode will double the clk cycles for data timeout */
208489032bdd8d Chaotian Jing              2015-06-15  818  		timeout = mode >= 2 ? timeout * 2 : timeout;
208489032bdd8d Chaotian Jing              2015-06-15  819  		timeout = timeout > 1 ? timeout - 1 : 0;
208489032bdd8d Chaotian Jing              2015-06-15  820  	}
557011b6b8c87c Chun-Hung Wu               2020-07-20  821  	return timeout;
557011b6b8c87c Chun-Hung Wu               2020-07-20  822  }
557011b6b8c87c Chun-Hung Wu               2020-07-20  823  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
