Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3629CF5;
	Sat, 11 Oct 2025 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760143193; cv=none; b=WJkkcb15/0aT7PnxyzM+ACC/3RGohsGqhgKvXGta12r18zWuPNEKWq1l3sVgulx9JdbeNuOkYK4nmz0BISzudA/VAcwfTo29BrJSffDiJsmTMqWdqi9nhlloXKjOHvtneE/qLq02urTXe037QnE9ZaldAC9QAtowW8l061H0nmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760143193; c=relaxed/simple;
	bh=PHOnhmJSf3S/v1nTNXKbtDvw0Ynu3HDacRHjmrT2KPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkIw6YRfYmlTz4SnYGK6pjzZ6mxEG5TVslxrq4bGa/9NTz2oQhIKTutRFHejDg+7OTQAAX6ifjkl7pFlOv0uzsSe6q5nELAbmPEDSZNlOX+UrD9yctgJu+0fgjSawvn7xB/MKpUs3mnGOvQVWaB2bn2/auvfC9UUM+fAocU7hqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5BFvq/E; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5BFvq/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760143191; x=1791679191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PHOnhmJSf3S/v1nTNXKbtDvw0Ynu3HDacRHjmrT2KPQ=;
  b=V5BFvq/EiL22jFeSBKjyyBlRoc1z7rKByEmiZbAuy2pGKxCK+4K1Cjrq
   BDkwy4wIG8pWaA0Z9J1g2qaRaeOKXi/wXJdm3p+8w1bURghg9Mt2GXXBw
   SuxoJlvjkkDPxylrkCbYB3GUcbW6Knz5RnXN44uPQt9r5gCDBWNDId1RR
   1IfJNokC6o+dl7RfLgLHh9cro1x2gsoiPIx7s0UEE2YaBHrpf/LoIbCn+
   WtmaVA6GfWAwLR8uafMy+u3pbUihDsvgMnMzwWtgGSwKaHO4ZVrJzgtPS
   STChahSMJuEnrD6HlBZo0boyMZmP/pv6YdUbydW2xOq3etZaZaOj469mc
   g==;
X-CSE-ConnectionGUID: CYgD3uGNTBOzCOpIfBfiRA==
X-CSE-MsgGUID: 802hl6IbS+GSq3IRKgNOnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62067012"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62067012"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 17:39:51 -0700
X-CSE-ConnectionGUID: oqK4AyzMQmKBKMqUYzsFRw==
X-CSE-MsgGUID: VsBiR1HhSTmg6ReRECDU2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="180791576"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Oct 2025 17:39:46 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7NeB-0003Kr-2q;
	Sat, 11 Oct 2025 00:39:43 +0000
Date: Sat, 11 Oct 2025 08:39:07 +0800
From: kernel test robot <lkp@intel.com>
To: hehuan1@eswincomputing.com, ulf.hansson@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jszhang@kernel.org,
	adrian.hunter@intel.com, p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, xuxiang@eswincomputing.com,
	luyulin@eswincomputing.com, dongxuyang@eswincomputing.com,
	zhangsenchuan@eswincomputing.com, weishangjuan@eswincomputing.com,
	lizhi2@eswincomputing.com, caohang@eswincomputing.com,
	hehuan1@eswincomputing.com
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add support for Eswin
 EIC7700
Message-ID: <202510110829.1yKzYvIP-lkp@intel.com>
References: <20251010094109.1613-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010094109.1613-1-hehuan1@eswincomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on ulf-hansson-mmc-mirror/next v6.17 next-20251010]
[cannot apply to robh/for-next pza/reset/next pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hehuan1-eswincomputing-com/dt-bindings-mmc-sdhci-of-dwcmshc-Add-Eswin-EIC7700/20251010-174323
base:   linus/master
patch link:    https://lore.kernel.org/r/20251010094109.1613-1-hehuan1%40eswincomputing.com
patch subject: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add support for Eswin EIC7700
config: riscv-randconfig-001-20251011 (https://download.01.org/0day-ci/archive/20251011/202510110829.1yKzYvIP-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110829.1yKzYvIP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110829.1yKzYvIP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/mmc/host/sdhci-of-dwcmshc.c:15:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:838:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     838 |         insb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:108:53: note: expanded from macro 'insb'
     108 | #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/mmc/host/sdhci-of-dwcmshc.c:15:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:846:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     846 |         insw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:109:53: note: expanded from macro 'insw'
     109 | #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/mmc/host/sdhci-of-dwcmshc.c:15:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:854:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     854 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:110:53: note: expanded from macro 'insl'
     110 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/mmc/host/sdhci-of-dwcmshc.c:15:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:863:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     863 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:122:55: note: expanded from macro 'outsb'
     122 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/mmc/host/sdhci-of-dwcmshc.c:15:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:872:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     872 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:123:55: note: expanded from macro 'outsw'
     123 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/mmc/host/sdhci-of-dwcmshc.c:15:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:881:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     881 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:124:55: note: expanded from macro 'outsl'
     124 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/mmc/host/sdhci-of-dwcmshc.c:15:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:140:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/mmc/host/sdhci-of-dwcmshc.c:300:13: error: redefinition of 'dwcmshc_enable_card_clk'
     300 | static void dwcmshc_enable_card_clk(struct sdhci_host *host)
         |             ^
   drivers/mmc/host/sdhci-of-dwcmshc.c:289:13: note: previous definition is here
     289 | static void dwcmshc_enable_card_clk(struct sdhci_host *host)
         |             ^
>> drivers/mmc/host/sdhci-of-dwcmshc.c:1179:2: error: call to undeclared function 'dwcmshc_disable_card_clk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1179 |         dwcmshc_disable_card_clk(host);
         |         ^
   drivers/mmc/host/sdhci-of-dwcmshc.c:1179:2: note: did you mean 'dwcmshc_enable_card_clk'?
   drivers/mmc/host/sdhci-of-dwcmshc.c:300:13: note: 'dwcmshc_enable_card_clk' declared here
     300 | static void dwcmshc_enable_card_clk(struct sdhci_host *host)
         |             ^
   drivers/mmc/host/sdhci-of-dwcmshc.c:1988:2: error: call to undeclared function 'dwcmshc_disable_card_clk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1988 |         dwcmshc_disable_card_clk(host);
         |         ^
   drivers/mmc/host/sdhci-of-dwcmshc.c:2070:2: error: call to undeclared function 'dwcmshc_disable_card_clk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2070 |         dwcmshc_disable_card_clk(host);
         |         ^
   7 warnings and 4 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARCH_HAS_ELF_CORE_EFLAGS
   Depends on [n]: BINFMT_ELF [=n] && ELF_CORE [=y]
   Selected by [y]:
   - RISCV [=y]


vim +/dwcmshc_enable_card_clk +300 drivers/mmc/host/sdhci-of-dwcmshc.c

   299	
 > 300	static void dwcmshc_enable_card_clk(struct sdhci_host *host)
   301	{
   302		u16 ctrl;
   303	
   304		ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
   305		if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
   306			ctrl |= SDHCI_CLOCK_CARD_EN;
   307			sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
   308		}
   309	}
   310	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
