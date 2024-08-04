Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D874424;
	Sun,  4 Aug 2024 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722811311; cv=none; b=onuAB6afzRb0otbZ4R8TB00cd3QhlchKjhgdEVfjQaD9AAXvm59f4TzLoA3FSfwhJ3EQBimyXP7ApQPmSVQgyBgwV56fYkcyVxjMOcE/Zzf57ofjiiHh950/uSNXA5h5OVBtx2LAcBTalmSymXdAUe0LTibe/l3lxG28z9HSUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722811311; c=relaxed/simple;
	bh=x9dFSWS1m5DZ+vMj98CnMITJsEa4MZFFF5i1ylpdm6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uODRarRbktmzgOP7EVfOIk/BztMOL4tqH7Mn/6Cwd1RTvbPt5l4RtsoIZsz2EQiTT9iLwuDiIJUHUYqb8xdjctzRDZ09EcyNE69s/RXbbotD6OK2OwsmTJnQMtfaoYIH9XBta1IGjbUEcoWKF2R95/mm04jAuGo1FAwXeg9YF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qfgejkp5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qfgejkp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722811310; x=1754347310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x9dFSWS1m5DZ+vMj98CnMITJsEa4MZFFF5i1ylpdm6s=;
  b=Qfgejkp5f/dczpOhfNo/Pw3mnNYkqzL1MXXC22XzVQwwb7l1eAeC3fqR
   fvJcBWc+uBXUA7DEZeqRcooRCDkKw1XxSwFATYZmovwpnjQmFZ7Ljd9IC
   N3k3MX5hTjdLJ+VhKkufaKW1SKJY7T/lvT7uP21rAaARJY4t6GuxopHN9
   aaCKIfjiLI+8PSwNjSBbHICosA0rLdE/IniEB+WFSPdD1fhM0lp0VMd4p
   HUQgtWPA/iNav7Unc9UpJpTHLU/x8Z1Dh7GA5+TXdi3WQ9Z3bUNJV0YxQ
   0yczmKtfIvmLx4nTx8XT0jUpooSt8pnMi8yl4XSSkJYAnDFvLgnUsizG4
   g==;
X-CSE-ConnectionGUID: jjgytsykShSMLW3+wknb7A==
X-CSE-MsgGUID: X+lIrdzLRHuxW+0MV4QWFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="31386655"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="31386655"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 15:41:49 -0700
X-CSE-ConnectionGUID: SXBm/78uSyGywqYaNiDvMg==
X-CSE-MsgGUID: hVdafZAcTHmgjknCPHoUew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="60811074"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Aug 2024 15:41:44 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sajv3-0001dT-01;
	Sun, 04 Aug 2024 22:41:41 +0000
Date: Mon, 5 Aug 2024 06:41:40 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
Message-ID: <202408050650.ScFbLl34-lkp@intel.com>
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
config: arm-randconfig-003-20240805 (https://download.01.org/0day-ci/archive/20240805/202408050650.ScFbLl34-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050650.ScFbLl34-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408050650.ScFbLl34-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mtd/parsers/ofpart_airoha.c:33:9: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
         |                ^
>> drivers/mtd/parsers/ofpart_airoha.c:33:7: error: incompatible integer to pointer conversion assigning to 'struct property *' from 'int' [-Wint-conversion]
      33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/kzalloc +33 drivers/mtd/parsers/ofpart_airoha.c

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
