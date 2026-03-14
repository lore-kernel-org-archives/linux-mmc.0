Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69658282F0A;
	Sat, 14 Mar 2026 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773520766; cv=none; b=odNFWbzchY4ATE+S8ji43JxoBuh5/yp11RNwhtkKDaoeBHj8FKob/BpjLYD6ew+4OfUJ9D2B8g3e9aYvqzTL1wDpPOrnn/h9DtMFGdEPu1lXR8EvLF88EtbaeE09fFxT36t5ErOK3W0yP+KTdf5/diWOhAkwD7+KPyKDQGURPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773520766; c=relaxed/simple;
	bh=AukoqsMcYsnDKt5+d2e638BLLQ4ybjY4dyDeaqoO5S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sH969aul5xuD1r3Y1SG4rCXOqVuFtZZB9nN+baFvJv21OMUF3HGCChbXIWL2cy03bNpEvGe+6LQKetQ4cSMICXuaDPIrGNElWWHk0st6J6Ecs6U/i6/U9o9AfR2sbb5GQdDyIqEnbkBcR22Isud8pZdQIIwU8nHzAxY2awR+xr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CW4LqOly; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CW4LqOly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773520763; x=1805056763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AukoqsMcYsnDKt5+d2e638BLLQ4ybjY4dyDeaqoO5S4=;
  b=CW4LqOlyhuxjagiqAXGqQAKU4vG+UCjcQQEfWI/6aRNL1EQxUg1x3nw5
   W7UV1TPkvNcqcM54xsen6xq3O9X1Wt4o/qzbofhKWtltbMWpiO9DL0lfk
   WhJJBfFEu7htcodU0J3ALMtmZVCeIeEdk7g6dQvBKS/VLAQu4ipNWOHsG
   IQPkMeW9LelEqVLGpJmjAEaZDyJMmOfvs9DoPJq3CeLh8vk+pza3iOPNc
   T5M1hkERrt7VGtlNWlj1Du1IHDWXIEHknLqeFShr32z64y1n8LWD2Y7HX
   Lj77RHNpA5vQf9wW1y5lrfgk6jMr5rHA763VtAb+9zO1P4IsvVuxHevtd
   w==;
X-CSE-ConnectionGUID: I0XXXvLMQQm7CrF6YP+wcQ==
X-CSE-MsgGUID: I5y0Pzu1SpyNeLmfanYOWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="85214885"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="85214885"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 13:39:22 -0700
X-CSE-ConnectionGUID: /Zma5jHUTamC/jFSOEsqDQ==
X-CSE-MsgGUID: jgQOkDZJRUW7aIRqQu3piw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="217835982"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Mar 2026 13:39:18 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w1VlS-000000005ip-3yYv;
	Sat, 14 Mar 2026 20:39:14 +0000
Date: Sun, 15 Mar 2026 04:39:00 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Ryan Chen <ryanchen.aspeed@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
Message-ID: <202603150439.FM8mt7EG-lkp@intel.com>
References: <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-mmc-sdhci-of-aspeed-Add-ast2700-support/20260314-132323
base:   6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
patch link:    https://lore.kernel.org/r/20260313-sdhci-v1-2-91cea19c8a67%40aspeedtech.com
patch subject: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260315/202603150439.FM8mt7EG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260315/202603150439.FM8mt7EG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603150439.FM8mt7EG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-of-aspeed.c: In function 'aspeed_sdc_probe':
>> drivers/mmc/host/sdhci-of-aspeed.c:533:17: error: implicit declaration of function 'reset_control_get_optional_exclusive' [-Wimplicit-function-declaration]
     533 |         reset = reset_control_get_optional_exclusive(&pdev->dev, NULL);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-of-aspeed.c:533:15: error: assignment to 'struct reset_control *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     533 |         reset = reset_control_get_optional_exclusive(&pdev->dev, NULL);
         |               ^
>> drivers/mmc/host/sdhci-of-aspeed.c:537:15: error: implicit declaration of function 'reset_control_deassert' [-Wimplicit-function-declaration]
     537 |         ret = reset_control_deassert(sdc->rst);
         |               ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-of-aspeed.c:537:41: error: 'struct aspeed_sdc' has no member named 'rst'
     537 |         ret = reset_control_deassert(sdc->rst);
         |                                         ^~


vim +/reset_control_get_optional_exclusive +533 drivers/mmc/host/sdhci-of-aspeed.c

   520	
   521	{
   522		struct device_node *parent, *child;
   523		struct reset_control *reset;
   524		struct aspeed_sdc *sdc;
   525		int ret;
   526	
   527		sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
   528		if (!sdc)
   529			return -ENOMEM;
   530	
   531		spin_lock_init(&sdc->lock);
   532	
 > 533		reset = reset_control_get_optional_exclusive(&pdev->dev, NULL);
   534		if (IS_ERR(reset))
   535			return dev_err_probe(&pdev->dev, PTR_ERR(reset),
   536					     "unable to acquire reset\n");
 > 537		ret = reset_control_deassert(sdc->rst);
   538		if (ret)
   539			return dev_err_probe(&pdev->dev, ret,
   540					     "reset deassert failed\n");
   541	
   542		sdc->clk = devm_clk_get(&pdev->dev, NULL);
   543		if (IS_ERR(sdc->clk))
   544			return PTR_ERR(sdc->clk);
   545	
   546		ret = clk_prepare_enable(sdc->clk);
   547		if (ret) {
   548			dev_err(&pdev->dev, "Unable to enable SDCLK\n");
   549			return ret;
   550		}
   551	
   552		sdc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &sdc->res);
   553		if (IS_ERR(sdc->regs)) {
   554			ret = PTR_ERR(sdc->regs);
   555			goto err_clk;
   556		}
   557	
   558		dev_set_drvdata(&pdev->dev, sdc);
   559	
   560		parent = pdev->dev.of_node;
   561		for_each_available_child_of_node(parent, child) {
   562			struct platform_device *cpdev;
   563	
   564			cpdev = of_platform_device_create(child, NULL, &pdev->dev);
   565			if (!cpdev) {
   566				of_node_put(child);
   567				ret = -ENODEV;
   568				goto err_clk;
   569			}
   570		}
   571	
   572		return 0;
   573	
   574	err_clk:
   575		clk_disable_unprepare(sdc->clk);
   576		return ret;
   577	}
   578	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
