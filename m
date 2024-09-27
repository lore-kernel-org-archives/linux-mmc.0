Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D316F287;
	Fri, 27 Sep 2024 04:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409960; cv=none; b=W1sTkMXqWHOcKriHaf15ZeCFsPUDgbX+Q0iwZBI0vMR6/sEymEMBe/jfRQiIelkzsuOptJad4Tz4aDT/v9I0D3JZeO1j2388dn2jD8IzqqV4/kFwLohA+uz9qQP6jLUTLnmM0fP01lPlZsj6OBDzCo8ntGuD0sQ0W9+LH8RcpVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409960; c=relaxed/simple;
	bh=cyeDaxD6Y4GV+oBDpuWeWZppdMCUa7jpzaaR05xTrfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT3anuHmLpX0E9kinjh/NDCtzMvs7ZcFOr7QFwCu892hODaI0+najAkj5C5VXvXcFQBVCJaMnKhDZlLBF6nhe3J6T4IjjwxF4i/SnVAfeufDGnV9wayox5rjYmrXscivuL9lKuyg1aGs2RPKpIyJVTTO0+GxkhWRR469sDzuXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZyzTEdg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZyzTEdg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727409958; x=1758945958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cyeDaxD6Y4GV+oBDpuWeWZppdMCUa7jpzaaR05xTrfw=;
  b=lZyzTEdghdDdFT3maWjHjQljD9Gb8EZh6thvlTGSnAGuDvjnD5dk7Hdx
   05cIxDGFdqeKNz78pgrRkvbsdjHclRdYzmEWjxLe/OmYFgjt8dwiY74ss
   8qDtBPhLaoE4518p7GqtUp4ltNQDjkl+ZDtbumW5PY5Hx/u/km1Ric7X5
   E6vEbamuDYkL9J6Lv9/E3U5wePuHN8S8L9CcWYluw4jtAbs4WZ4v41rGc
   MdY/94TufYkfI7SGC5daKyUqP4Jamuj19XmicYUrR7xEtFxJ98lbVeFbz
   af8UHk/XmUky/svXgZQWUumE76UN9l3X34LjOiAVuAKXD5iarY/uLLm8O
   g==;
X-CSE-ConnectionGUID: CXfrHiBvSQCteUOQzJfhUw==
X-CSE-MsgGUID: BuAVmTEDR+Wx5FcoxXfWIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26674464"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="26674464"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 21:05:57 -0700
X-CSE-ConnectionGUID: AzfU2nF/Ty6/ez1q2t4KCA==
X-CSE-MsgGUID: 5PxHDTPoQqOfSEGGWEmwBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72287376"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Sep 2024 21:05:54 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1su2Ep-000LRh-2d;
	Fri, 27 Sep 2024 04:05:51 +0000
Date: Fri, 27 Sep 2024 12:05:28 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chaotian.jing@mediatek.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ulf.hansson@linaro.org, matthias.bgg@gmail.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] mmc: mtk-sd: Implement Host Software Queue for eMMC and
 SD Card
Message-ID: <202409271143.hRope856-lkp@intel.com>
References: <20240925113949.149655-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925113949.149655-1-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11 next-20240926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/mmc-mtk-sd-Implement-Host-Software-Queue-for-eMMC-and-SD-Card/20240925-200025
base:   linus/master
patch link:    https://lore.kernel.org/r/20240925113949.149655-1-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH] mmc: mtk-sd: Implement Host Software Queue for eMMC and SD Card
config: i386-randconfig-001-20240927 (https://download.01.org/0day-ci/archive/20240927/202409271143.hRope856-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240927/202409271143.hRope856-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409271143.hRope856-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: mmc_hsq_suspend
   >>> referenced by mtk-sd.c:3078 (drivers/mmc/host/mtk-sd.c:3078)
   >>>               drivers/mmc/host/mtk-sd.o:(msdc_runtime_suspend) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: mmc_hsq_resume
   >>> referenced by mtk-sd.c:3112 (drivers/mmc/host/mtk-sd.c:3112)
   >>>               drivers/mmc/host/mtk-sd.o:(msdc_runtime_resume) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
