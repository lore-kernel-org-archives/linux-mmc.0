Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0C1804E;
	Sat,  5 Oct 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728138016; cv=none; b=eBB2KnwK9t7Vt12pVu5q9ymvDF12+gJXoAlAeV6FHhkyuD+o/6duggxH5I561YHZuVew5mkGR/xdyOSbQrnEMiKI/EV1zBvYsrDpbVhpyVtDZvgxdMLlRLJxSsWUibVa5BwXDH4rmH8KgNYYIjep2QlKDZfj0zpIGl86Fk7MmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728138016; c=relaxed/simple;
	bh=jTrJY5NY7nSitlKdPbrArtyQ+i8ZCWM8EMNpiIaduXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arN849TM5edf959Lj8YBVTx90GtvaaVjTbZFaDvrZXDmfvlkeucmREidBi/yJ6C5jme2GwSldXvKqE2lqMXxTOc2EO/3ad/W47kABGp9Nrjfyx4t0YkLrt4/OACBQwtAFcWLPm68ekpTQVKKT2fO9jGwiJPVxuevShLScOIP/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WKO3BOrI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WKO3BOrI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728138014; x=1759674014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jTrJY5NY7nSitlKdPbrArtyQ+i8ZCWM8EMNpiIaduXk=;
  b=WKO3BOrIvkehE46Bhgdj+GUAV1gjds+jQ4gujGSffcdjvqEiG3xguxVA
   uD6KJqaX7hpe58+VimPV1R0rmQPEGCUs0hHry6d0jOEiBKY/lDjn/Qfxv
   0GqMBx51rCtkUGlvgcuOut6eMHbL9atJDrVGcZ3B2Hcfm5j/IKuVDxBG+
   EDlBTvc6Whm9ppUebr0B62FpraEOhqBYh5/eJg4x7hZaIQBfLqZ/skEem
   rYLpbRQdUMTBKmnVaMGdKX+LMBg7kDBsSLR/IMhilfOMiqzMSjwF8AuSf
   BfEnazGW4LyR3VSAS2v9MJlDSBoL/TOCX/9Ha4uNDvMzFPuIdCynICKZK
   Q==;
X-CSE-ConnectionGUID: fcbt/5QlRIiIcFB0xPTAxA==
X-CSE-MsgGUID: wf7R4wJ+SaaLtjImzN22OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="27477239"
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="27477239"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 07:20:14 -0700
X-CSE-ConnectionGUID: vNox3mjuQJmK+q1hWuUItg==
X-CSE-MsgGUID: V+6EJzbzSFSYV4Jf19o69w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="74814459"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Oct 2024 07:20:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sx5dh-000314-1M;
	Sat, 05 Oct 2024 14:20:09 +0000
Date: Sat, 5 Oct 2024 22:19:38 +0800
From: kernel test robot <lkp@intel.com>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de
Cc: oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de, bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: Re: [PATCH 2/2] mmc: pwrseq_simple: add support for reset control
Message-ID: <202410052201.xEk9eC0T-lkp@intel.com>
References: <20241004120740.2887776-2-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004120740.2887776-2-catalin.popescu@leica-geosystems.com>

Hi Catalin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Catalin-Popescu/mmc-pwrseq_simple-add-support-for-reset-control/20241004-200909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241004120740.2887776-2-catalin.popescu%40leica-geosystems.com
patch subject: [PATCH 2/2] mmc: pwrseq_simple: add support for reset control
config: x86_64-randconfig-123-20241005 (https://download.01.org/0day-ci/archive/20241005/202410052201.xEk9eC0T-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410052201.xEk9eC0T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410052201.xEk9eC0T-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mmc/core/pwrseq_simple.c:123:31: sparse: sparse: symbol 'mmc_pwrseq_simple_gpio' was not declared. Should it be static?
>> drivers/mmc/core/pwrseq_simple.c:127:31: sparse: sparse: symbol 'mmc_pwrseq_simple_reset' was not declared. Should it be static?

vim +/mmc_pwrseq_simple_gpio +123 drivers/mmc/core/pwrseq_simple.c

   122	
 > 123	struct mmc_pwrseq_simple_data mmc_pwrseq_simple_gpio = {
   124		.use_reset = false,
   125	};
   126	
 > 127	struct mmc_pwrseq_simple_data mmc_pwrseq_simple_reset = {
   128		.use_reset = true,
   129	};
   130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
