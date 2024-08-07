Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02E149DFF;
	Wed,  7 Aug 2024 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066160; cv=none; b=O7KMeIYmZA8X+FkxGWSI46lA2qVKy1MiySQb5CW3iNOQ0IYzCnHMb3TmUFiVRDhJMxac/h/0UDJqaVsobOFfWVFDrH8b8VEUIM+GNsUlY5q6n4sXR2trUL5lJeVyZuPWpa1AA1dG9m/YvG8shCTLolCKK3pUPojPKr56jt8FJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066160; c=relaxed/simple;
	bh=qzOKWUz41TYDR4cdz3l1k0/R2WuyA/BV//cD3NYMHPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHqwoUuclyVARk1f8XY5q5kOwr9TVgcw0ObrSL3bXE0Yti6EvHQp/PWD6wncSyIVB4IeXu1VUYp0lP/+ee8xaEfvDnfUHwW5GLloke+F/TooTeJIyq7xsAZwOvrpdaAKePF9a/xJlxPfQwtvmWUh0xv+Jc7aMEiWs1w5pnMec0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCiV7Iw8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCiV7Iw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723066157; x=1754602157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qzOKWUz41TYDR4cdz3l1k0/R2WuyA/BV//cD3NYMHPA=;
  b=oCiV7Iw8+I8Odsc5z8PttO3CwpV4pEeWDLpYTzIOnNDyYGMVwSAlwflB
   cn2nGi+S8mvbOEH9XzqtmpJYxADGhbN/9F5XBvv5+w9MNYisQsRCcRgfC
   Qe75/r6iKwZXotwrUVI1RufpvITYwPfMSdd8Nsu38wjnLDwmWIF4YvBuN
   mayBndEXcGGLpNnNns+67bbNsq54iD8MAiaXR0wY+8XqMA7W+kCN6p7QS
   xvzW0C6dCFrkSlfLYs/gehtewCJjx280rmPw1SEIKCfcLPaZccH1lEVG4
   Rci8tR71GLzfc/dpkJzw0DujfzSVa5OwwIElFOiRdnaKSADWGKLoPsmCU
   Q==;
X-CSE-ConnectionGUID: ujpH8Y4QSluMV/Hud3zBSg==
X-CSE-MsgGUID: 5tEF9MG5S3KFyjf95R0Xnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21286273"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="21286273"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 14:29:14 -0700
X-CSE-ConnectionGUID: VO5TdQLCThqYeLxhxHYGww==
X-CSE-MsgGUID: iSgMtuprRgqN7ExnMuFUDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="56947521"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 07 Aug 2024 14:29:08 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sboDM-0005jV-21;
	Wed, 07 Aug 2024 21:29:02 +0000
Date: Thu, 8 Aug 2024 05:27:46 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 6/6] mtd: parser: add support for Airoha parser
Message-ID: <202408080559.nVw5Qez6-lkp@intel.com>
References: <20240806114118.17198-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806114118.17198-7-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on mtd/mtd/fixes linus/master v6.11-rc2 next-20240807]
[cannot apply to mtd/mtd/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvme-Document-nvme-card-compatible/20240806-195029
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240806114118.17198-7-ansuelsmth%40gmail.com
patch subject: [PATCH v3 6/6] mtd: parser: add support for Airoha parser
config: arc-randconfig-r121-20240807 (https://download.01.org/0day-ci/archive/20240808/202408080559.nVw5Qez6-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240808/202408080559.nVw5Qez6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080559.nVw5Qez6-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
>> ERROR: modpost: "of_update_property" [drivers/mtd/parsers/ofpart.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
