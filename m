Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD2AD59;
	Sun,  4 Aug 2024 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722811976; cv=none; b=KzMf6cRydnf5GojpVVj1OmepC0rBknnO9lCAKiZ9PYuu6ySnp83FqrYj+1B/SM93dMUbAnZbqSrPYraKUrx2efZyeBRaLE6H4Znd/KlKS1qRiobRwjksIr6TdcnkUumD58gMjBG6gWw/Y1ZTaYxpQFjoZqJRyZWLIa0kwGNo1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722811976; c=relaxed/simple;
	bh=SC6pWjsNLdf8Ha0Xw9lyvFenqRq2ilvJTWh9TexvBZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfeyCk1YK4+XArktBhuDR9Ksix8gr2i0G17JWO8irzA+7q/iSHN2WWxeP0YlRYsGtFxmUTImuDe3f1wJjbMCQGjkBo7/J3aMH4qJIaiXBEMERon6wtOkuUC9zANaJdDNJoZcdkv2KK1Egipbnoy+bDoif1O+7C9clv+D97HiAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcaVnDiE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcaVnDiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722811975; x=1754347975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SC6pWjsNLdf8Ha0Xw9lyvFenqRq2ilvJTWh9TexvBZI=;
  b=JcaVnDiE5MS6GHCNA0i9kU72mLFRV51gumxoUetixmZx9wwJNa+HykrI
   GU9kLuc7+YJoZSzScFJAT3F73y7a3feH+56MZLJwhbLk1oPUfry2lMYUW
   hY5QbwQG/mruI+DSm5v0FTaX9OfRPm4+gGo/OdnJ9HP3wT5fkElFVGlnb
   o1M8fG8vhwijtwKAjg1lGIu6nXHOzss0C+ppQugQWtmlr75pjMD41ywJT
   tlCo9rh2DUP0EMQOpgxvR34+VcVH68Azq5ssiwM+Crc9Ts7T0tU4T6WrO
   VYQETPZ3nSPy6jIkdllA1Kts+UctKfw6EamoBsuE1dfrlSsrHwT6Rsf0x
   A==;
X-CSE-ConnectionGUID: 5DI9d1HdQjarMMZuevPnCA==
X-CSE-MsgGUID: kKPb9pkWT0Gm0KSVEnTyxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20922605"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="20922605"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 15:52:54 -0700
X-CSE-ConnectionGUID: BjEKeAYSTFOLZIjIvaRe3A==
X-CSE-MsgGUID: VFBeEUHhSLuwRTbWMoIdOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="56720569"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Aug 2024 15:52:49 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sak5h-0001dc-0C;
	Sun, 04 Aug 2024 22:52:42 +0000
Date: Mon, 5 Aug 2024 06:52:04 +0800
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
Subject: Re: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
Message-ID: <202408050612.Ya1m6REu-lkp@intel.com>
References: <20240804174414.18171-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804174414.18171-7-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc1 next-20240802]
[cannot apply to mtd/mtd/next mtd/mtd/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvme-Document-nvme-card-compatible/20240805-014740
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240804174414.18171-7-ansuelsmth%40gmail.com
patch subject: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408050612.Ya1m6REu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/parsers/ofpart_airoha.c: In function 'airoha_partitions_post_parse':
   drivers/mtd/parsers/ofpart_airoha.c:33:16: error: implicit declaration of function 'kzalloc' [-Wimplicit-function-declaration]
      33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
         |                ^~~~~~~
>> drivers/mtd/parsers/ofpart_airoha.c:33:14: error: assignment to 'struct property *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
         |              ^


vim +33 drivers/mtd/parsers/ofpart_airoha.c

    10	
    11	int airoha_partitions_post_parse(struct mtd_info *mtd,
    12					 struct mtd_partition *parts,
    13					 int nr_parts)
    14	{
    15		struct mtd_partition *part;
    16		int len, a_cells, s_cells;
    17		struct device_node *pp;
    18		struct property *prop;
    19		const __be32 *reg;
    20		__be32 *new_reg;
    21	
    22		part = &parts[nr_parts - 1];
    23		pp = part->of_node;
    24	
    25		/* Skip if ART partition have a valid offset instead of a dynamic one */
    26		if (!of_device_is_compatible(pp, "airoha,dynamic-art"))
    27			return 0;
    28	
    29		/* ART partition is set at the end of flash - size */
    30		part->offset = mtd->size - part->size;
    31	
    32		/* Update the offset with the new calculate value in DT */
  > 33		prop = kzalloc(sizeof(*prop), GFP_KERNEL);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
