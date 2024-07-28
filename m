Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142157174F
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182294; cv=none; b=pDC1mixVl/6OzZaYIMdgvogIYydfcgxnPspynI6Q/rlgJjd5yi/FCvCX6whWlfioF93GlTPCIqphPf0YlOeoT7mbRKwIaUmDGor0be/2jnkJgBphCNjhNbQ9CYkBhT9nscWyJ3ki7aRx19Gf7GB8j2/vX6ZmnNAJk81ZXwz0yzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182294; c=relaxed/simple;
	bh=SjT42p438Cma/Y0VAQ7zyhTXcN9MspFdpA/0x+DZJ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfXUw5JccqawMPWVvhHB6jG8zc+wH7zCuh3EPVHrHUGdXTErFbKxsBdnOhYKRGnVoa/ocTqlzLS7EQMppHuV3DJGtLU1AiKOqNMjA2+rKez5nVtMCBajzUNPJSt2Z8QV1TB/f3M0vaKEOlWbKpSfMCkcNVBU5ria/kBIeCZyqPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kznwtBFE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kznwtBFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722182291; x=1753718291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SjT42p438Cma/Y0VAQ7zyhTXcN9MspFdpA/0x+DZJ1U=;
  b=kznwtBFEzemzjffOEtq695dyjSgl4xZMWIHUN2NUCY3QLyMhSHlI3vkC
   bq0IMStlGP+NPIihhiwfBCUTFti3Z6iYEZf2mvDwvgMQLoomlNzfyCIQb
   ymY9gLbteGqc5bFVxwH3JIqG1f2tEWlex/2pQfDC2IKcfBKhUxVFWOPO3
   4xQzB19RAcsMrsgyXe+gfzmgwu5bL81nLrfH2mD47su1Hir9RKNhFipKc
   TzkbYJQLsIvNaCXe7U/DTY/Wp1XoVNlRB9FrCdo+tm2ngK7uU6TxQMI/r
   CD9D7EjU1kGKyvDCJBvIyJ9hmm6u1oOBjtATz5qVA6S+wF2wEf/BBD8fh
   g==;
X-CSE-ConnectionGUID: kfzsc6aDSBG+tVl7SQ4wjA==
X-CSE-MsgGUID: OK9hO3TaSRegxagtZspzeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="12753723"
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="12753723"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 08:58:11 -0700
X-CSE-ConnectionGUID: TtBAlootS26LfXxxrmRgiQ==
X-CSE-MsgGUID: Z6lqw8cdRh+21NyjXQ5Q6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="58319812"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jul 2024 08:58:09 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sY6He-000qvm-21;
	Sun, 28 Jul 2024 15:58:06 +0000
Date: Sun, 28 Jul 2024 23:57:45 +0800
From: kernel test robot <lkp@intel.com>
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ricky WU <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH 04/10] mmc: core: Add open-ended Ext memory addressing
Message-ID: <202407282317.uYbf4apc-lkp@intel.com>
References: <20240728081154.1782120-5-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728081154.1782120-5-avri.altman@wdc.com>

Hi Avri,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10 next-20240726]
[cannot apply to ulf-hansson-mmc-mirror/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Avri-Altman/mmc-sd-SDUC-Support-Recognition/20240728-161645
base:   linus/master
patch link:    https://lore.kernel.org/r/20240728081154.1782120-5-avri.altman%40wdc.com
patch subject: [PATCH 04/10] mmc: core: Add open-ended Ext memory addressing
config: arm-s5pv210_defconfig (https://download.01.org/0day-ci/archive/20240728/202407282317.uYbf4apc-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240728/202407282317.uYbf4apc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407282317.uYbf4apc-lkp@intel.com/

All errors (new ones prefixed by >>):

      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:76:56: note: in expansion of macro '__bf_shf'
      76 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:1717:31: note: in expansion of macro 'FIELD_GET'
    1717 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
         |                               ^~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: in expansion of macro 'GENMASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^~~~~~~
   drivers/mmc/core/block.c:1717:41: note: in expansion of macro 'SDUC_ADDR_EXT_MASK'
    1717 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
         |                                         ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/ptrace.h:13,
                    from arch/arm/include/asm/irqflags.h:7,
                    from include/linux/irqflags.h:18,
                    from arch/arm/include/asm/bitops.h:28,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from include/linux/moduleparam.h:7,
                    from drivers/mmc/core/block.c:21:
   include/uapi/linux/bits.h:8:31: warning: left shift count >= width of type [-Wshift-count-overflow]
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^~
   include/linux/bitfield.h:156:44: note: in definition of macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: in expansion of macro 'GENMASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^~~~~~~
   drivers/mmc/core/block.c:1717:41: note: in expansion of macro 'SDUC_ADDR_EXT_MASK'
    1717 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
         |                                         ^~~~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bitfield.h:156:44: note: in definition of macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: in expansion of macro 'GENMASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^~~~~~~
   drivers/mmc/core/block.c:1717:41: note: in expansion of macro 'SDUC_ADDR_EXT_MASK'
    1717 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
         |                                         ^~~~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:8:31: warning: left shift count >= width of type [-Wshift-count-overflow]
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/mmc/core/block.c:1717:31: note: in expansion of macro 'FIELD_GET'
    1717 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
         |                               ^~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: in expansion of macro 'GENMASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^~~~~~~
   drivers/mmc/core/block.c:1717:41: note: in expansion of macro 'SDUC_ADDR_EXT_MASK'
    1717 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
         |                                         ^~~~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/mmc/core/block.c:1717:31: note: in expansion of macro 'FIELD_GET'
    1717 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
         |                               ^~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: in expansion of macro 'GENMASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^~~~~~~
   drivers/mmc/core/block.c:1717:41: note: in expansion of macro 'SDUC_ADDR_EXT_MASK'
    1717 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
         |                                         ^~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_290' declared with attribute error: FIELD_GET: mask is zero
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/mmc/core/block.c:1717:31: note: in expansion of macro 'FIELD_GET'
    1717 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, blk_rq_pos(req));
         |                               ^~~~~~~~~


vim +/__compiletime_assert_290 +510 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  496  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  497  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  498  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  499  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  500  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  501   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  502   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  503   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  504   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  505   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  506   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  507   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  508   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  509  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @510  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  511  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
