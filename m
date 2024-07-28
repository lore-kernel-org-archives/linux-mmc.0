Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4031B86E5
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jul 2024 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722163398; cv=none; b=baRU/ghAz/JccHDtM25BXgnql3qA2vmMxQZcZQWEKWz2I5n19hujemVg4pf2fsRCyO5pxEYR7QJmBqgH0dPbXGEzCZCZD1OqaEa8KN6JNUl+NE8r/1wF+hn9kBj4w9l09UD3zK9tL5qeKfgNaCtsqkxFNalYMCH8o9HVFnfIXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722163398; c=relaxed/simple;
	bh=lot65y8TDmxfd/RHyrMJzEDcRCK1jQzEF5BMDHCJRtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+uPjXfOoj73Q/cd77puYL4zNu3FQOxw8b3a7cCsqFuKyGgQaB/mjLNTstC23pA3l1AMrB6pfImqkKc3Q6t2MRPD2HpzmMEvmtBJbJajUPNLR6QHksGe3nrYmam35MTk96yz1y9DdcDDhaSY1KtpCHZIe4KhuHEiqCMjrpXoE2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Awpk1xGB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Awpk1xGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722163395; x=1753699395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lot65y8TDmxfd/RHyrMJzEDcRCK1jQzEF5BMDHCJRtc=;
  b=Awpk1xGBAJG8X+SA8ylj8ZzPIQffOT+KLDzh9kK8TL0931ZYcvZ62yvV
   7hAsGADOdoh+h/j6ijyhTR7+tG2iSqRP44dN+/dohZ8qnJxVfQSucv+Uc
   ucx7GNWouXmZbQ5T4JviwQrnL5qaCfcmuWf9lJRHhasVXN5+e0zb1YwJy
   2YD+psrkrcLB3+3Qd3T5imdYbqsK0Vm1LxHE9EG1Epvthpu/za5Xfczza
   FZrUkcAiTeEdUWwhzG5hiWl3dacZWRYH0q3dcAQypevIcEjYDDVh8zRnz
   CIIPfpjloD4H29c0HbOlShBwH/tx6VPMdAoMz5c6RxxwC0s/rUUE3fqoh
   w==;
X-CSE-ConnectionGUID: OevhmoOoTMibKOIRBQMn0A==
X-CSE-MsgGUID: YYK5Ryw/RzGk10ByGHNBKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="31297193"
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="31297193"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 03:43:03 -0700
X-CSE-ConnectionGUID: R9I55EuJQWu2+yt6/x9AKg==
X-CSE-MsgGUID: wByR+TZFTAGhbm/c+WvmWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,243,1716274800"; 
   d="scan'208";a="54277184"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 28 Jul 2024 03:43:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sY1Mg-000qjC-2T;
	Sun, 28 Jul 2024 10:42:58 +0000
Date: Sun, 28 Jul 2024 18:42:02 +0800
From: kernel test robot <lkp@intel.com>
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ricky WU <ricky_wu@realtek.com>, Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH 09/10] mmc: core: Add Ext memory addressing for erase
Message-ID: <202407281841.RRgIK067-lkp@intel.com>
References: <20240728081154.1782120-10-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728081154.1782120-10-avri.altman@wdc.com>

Hi Avri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10 next-20240726]
[cannot apply to ulf-hansson-mmc-mirror/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Avri-Altman/mmc-sd-SDUC-Support-Recognition/20240728-161645
base:   linus/master
patch link:    https://lore.kernel.org/r/20240728081154.1782120-10-avri.altman%40wdc.com
patch subject: [PATCH 09/10] mmc: core: Add Ext memory addressing for erase
config: i386-buildonly-randconfig-001-20240728 (https://download.01.org/0day-ci/archive/20240728/202407281841.RRgIK067-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240728/202407281841.RRgIK067-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407281841.RRgIK067-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/core/core.c:1667:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count is negative [-Wshift-count-negative]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count is negative [-Wshift-count-negative]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count is negative [-Wshift-count-negative]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count is negative [-Wshift-count-negative]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count is negative [-Wshift-count-negative]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count is negative [-Wshift-count-negative]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count is negative [-Wshift-count-negative]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count is negative [-Wshift-count-negative]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count is negative [-Wshift-count-negative]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   include/linux/bitfield.h:156:30: note: expanded from macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
>> drivers/mmc/core/core.c:1667:27: warning: shift count is negative [-Wshift-count-negative]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   include/linux/bitfield.h:156:30: note: expanded from macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   drivers/mmc/core/core.c:1667:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   include/linux/bitfield.h:156:50: note: expanded from macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                                       ~~~~~~~~~^~~~~~
   include/linux/bitfield.h:45:38: note: expanded from macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/mmc/core/core.c:1667:27: warning: shift count is negative [-Wshift-count-negative]
    1667 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   include/linux/bitfield.h:156:50: note: expanded from macro 'FIELD_GET'
     156 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                                       ~~~~~~~~~^~~~~~
   include/linux/bitfield.h:45:38: note: expanded from macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/mmc/core/core.c:1689:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1689 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, to);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/mmc/core/core.c:1689:27: warning: shift count is negative [-Wshift-count-negative]
    1689 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, to);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/mmc/core/core.c:1689:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1689 |                 u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, to);
         |                               ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/core/sd_ops.h:14:28: note: expanded from macro 'SDUC_ADDR_EXT_MASK'
      14 | #define SDUC_ADDR_EXT_MASK GENMASK(37, 32)
         |                            ^


vim +1667 drivers/mmc/core/core.c

  1618	
  1619	static int mmc_do_erase(struct mmc_card *card, sector_t from,
  1620				sector_t to, unsigned int arg)
  1621	{
  1622		struct mmc_command cmd = {};
  1623		unsigned int qty = 0, busy_timeout = 0;
  1624		bool use_r1b_resp;
  1625		int err;
  1626	
  1627		mmc_retune_hold(card->host);
  1628	
  1629		/*
  1630		 * qty is used to calculate the erase timeout which depends on how many
  1631		 * erase groups (or allocation units in SD terminology) are affected.
  1632		 * We count erasing part of an erase group as one erase group.
  1633		 * For SD, the allocation units are always a power of 2.  For MMC, the
  1634		 * erase group size is almost certainly also power of 2, but it does not
  1635		 * seem to insist on that in the JEDEC standard, so we fall back to
  1636		 * division in that case.  SD may not specify an allocation unit size,
  1637		 * in which case the timeout is based on the number of write blocks.
  1638		 *
  1639		 * Note that the timeout for secure trim 2 will only be correct if the
  1640		 * number of erase groups specified is the same as the total of all
  1641		 * preceding secure trim 1 commands.  Since the power may have been
  1642		 * lost since the secure trim 1 commands occurred, it is generally
  1643		 * impossible to calculate the secure trim 2 timeout correctly.
  1644		 */
  1645		if (card->erase_shift)
  1646			qty += ((to >> card->erase_shift) -
  1647				(from >> card->erase_shift)) + 1;
  1648		else if (mmc_card_sd(card))
  1649			qty += to - from + 1;
  1650		else
  1651			qty += ((to / card->erase_size) -
  1652				(from / card->erase_size)) + 1;
  1653	
  1654		if (!mmc_card_blockaddr(card)) {
  1655			from <<= 9;
  1656			to <<= 9;
  1657		}
  1658	
  1659		if (mmc_card_sd(card))
  1660			cmd.opcode = SD_ERASE_WR_BLK_START;
  1661		else
  1662			cmd.opcode = MMC_ERASE_GROUP_START;
  1663		cmd.arg = from & 0xFFFFFFFF;
  1664		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
  1665	
  1666		if (mmc_card_is_sduc(card->host)) {
> 1667			u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, from);
  1668	
  1669			mmc_send_ext_addr(card->host, ext_addr);
  1670		}
  1671	
  1672		err = mmc_wait_for_cmd(card->host, &cmd, 0);
  1673		if (err) {
  1674			pr_err("mmc_erase: group start error %d, "
  1675			       "status %#x\n", err, cmd.resp[0]);
  1676			err = -EIO;
  1677			goto out;
  1678		}
  1679	
  1680		memset(&cmd, 0, sizeof(struct mmc_command));
  1681		if (mmc_card_sd(card))
  1682			cmd.opcode = SD_ERASE_WR_BLK_END;
  1683		else
  1684			cmd.opcode = MMC_ERASE_GROUP_END;
  1685		cmd.arg = to & 0xFFFFFFFF;
  1686		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
  1687	
  1688		if (mmc_card_is_sduc(card->host)) {
  1689			u8 ext_addr = FIELD_GET(SDUC_ADDR_EXT_MASK, to);
  1690	
  1691			mmc_send_ext_addr(card->host, ext_addr);
  1692		}
  1693	
  1694		err = mmc_wait_for_cmd(card->host, &cmd, 0);
  1695		if (err) {
  1696			pr_err("mmc_erase: group end error %d, status %#x\n",
  1697			       err, cmd.resp[0]);
  1698			err = -EIO;
  1699			goto out;
  1700		}
  1701	
  1702		memset(&cmd, 0, sizeof(struct mmc_command));
  1703		cmd.opcode = MMC_ERASE;
  1704		cmd.arg = arg;
  1705		busy_timeout = mmc_erase_timeout(card, arg, qty);
  1706		use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout);
  1707	
  1708		err = mmc_wait_for_cmd(card->host, &cmd, 0);
  1709		if (err) {
  1710			pr_err("mmc_erase: erase error %d, status %#x\n",
  1711			       err, cmd.resp[0]);
  1712			err = -EIO;
  1713			goto out;
  1714		}
  1715	
  1716		if (mmc_host_is_spi(card->host))
  1717			goto out;
  1718	
  1719		/*
  1720		 * In case of when R1B + MMC_CAP_WAIT_WHILE_BUSY is used, the polling
  1721		 * shall be avoided.
  1722		 */
  1723		if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
  1724			goto out;
  1725	
  1726		/* Let's poll to find out when the erase operation completes. */
  1727		err = mmc_poll_for_busy(card, busy_timeout, false, MMC_BUSY_ERASE);
  1728	
  1729	out:
  1730		mmc_retune_release(card->host);
  1731		return err;
  1732	}
  1733	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
