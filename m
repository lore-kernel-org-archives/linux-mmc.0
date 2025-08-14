Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83453D6D;
	Thu, 14 Aug 2025 03:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143448; cv=none; b=qOLMW1gFWOIQDvb97PLIGwhm2TL7urPktBKkNH2UiWMbBgDru92+mbooeosjWbblRfoZsaGYBwGy9c5JmM1M0vxfobDK6NYuj4oAPBpk19/6G4ujGEmvz32P2qwTapVBgUtwKQQkhipWr8gOjM+OBEAlmtbINWoTmE+hRgMms+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143448; c=relaxed/simple;
	bh=ism4DX/0tvtC7UUo4wckL9jSeiXUZ1Nq7Lv7Sj8l4Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA3Poc04yy90zpbOnMVLFETeSzuWx54kifBGaow5+eKYy9kxN4r0I9GBcf/eAlOMrQdOdQ0LAvq9d1Yk+lEW52uq38nOD/qVvkDveWMcO05g8Xoxf43df2OZMjjFkaGQEGNWxsrwfFFFXGRS9voYGJRf11/TlTZZGBjsHCrt5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkSiKz8+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkSiKz8+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755143445; x=1786679445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ism4DX/0tvtC7UUo4wckL9jSeiXUZ1Nq7Lv7Sj8l4Rg=;
  b=ZkSiKz8+oZAGOI7NNqt6eELpGCyuE1X2irtEKGhQhtJGdMg1x0fyJmPh
   4dvW3Ks50x7ejWAGpbOSW0GkpD92TLkL4j51ySmbPawjqK7IwOhrlW8Y1
   BD02HR0a2fnraL3YZzvHrsP9YBsjQ/yv2ayorwQP9Sw/BaRp2ZTUJ8FqI
   uYmhv3sAhy8mlGzB1ciZtzq7A30vw125to55YZDccLYsVC4fRm76hnrlm
   XKcdwZJijXTIbmf78W9yHWiQGrTiCjNn8GH38Xu+FQse97O5c8nf9mSiK
   fXUOFo2GLe3Z9uRTp75dIj8v825OaDaRFX9CD9AgRQuJnCWfz6birik/V
   g==;
X-CSE-ConnectionGUID: ipstxmj/T4uhicUv9qhq6A==
X-CSE-MsgGUID: OBIcgM+jS0Oao+XGFduHaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68056393"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="68056393"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 20:50:44 -0700
X-CSE-ConnectionGUID: lLI0kl0bRriL7Ccik4xtbQ==
X-CSE-MsgGUID: v4wETOxZQ2yzmtln7ND2fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="165871159"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2025 20:50:41 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umOz8-000AYe-0X;
	Thu, 14 Aug 2025 03:50:38 +0000
Date: Thu, 14 Aug 2025 11:49:54 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
	Christian Loehle <christian.loehle@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <Avri.Altman@sandisk.com>
Subject: Re: [PATCH v7 1/2] mmc: core: Add infrastructure for undervoltage
 handling
Message-ID: <202508141139.psCBtuQz-lkp@intel.com>
References: <20250813103309.3810728-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813103309.3810728-2-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v6.17-rc1 next-20250813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/mmc-core-add-undervoltage-handler-for-MMC-eMMC-devices/20250813-193625
base:   linus/master
patch link:    https://lore.kernel.org/r/20250813103309.3810728-2-o.rempel%40pengutronix.de
patch subject: [PATCH v7 1/2] mmc: core: Add infrastructure for undervoltage handling
config: x86_64-buildonly-randconfig-002-20250814 (https://download.01.org/0day-ci/archive/20250814/202508141139.psCBtuQz-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508141139.psCBtuQz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508141139.psCBtuQz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/core/core.c:1412:6: warning: unused variable 'ret' [-Wunused-variable]
    1412 |         int ret;
         |             ^~~
   1 warning generated.


vim +/ret +1412 drivers/mmc/core/core.c

  1400	
  1401	/**
  1402	 * mmc_handle_undervoltage - Handle an undervoltage event on the MMC bus
  1403	 * @host: The MMC host that detected the undervoltage condition
  1404	 *
  1405	 * This function is called when an undervoltage event is detected on one of
  1406	 * the MMC regulators.
  1407	 *
  1408	 * Returns: 0 on success or a negative error code on failure.
  1409	 */
  1410	int mmc_handle_undervoltage(struct mmc_host *host)
  1411	{
> 1412		int ret;
  1413	
  1414		/* Stop the host to prevent races with card removal */
  1415		__mmc_stop_host(host);
  1416	
  1417		if (!host->bus_ops || !host->bus_ops->handle_undervoltage)
  1418			return 0;
  1419	
  1420		dev_warn(mmc_dev(host), "%s: Undervoltage detected, initiating emergency stop\n",
  1421			 mmc_hostname(host));
  1422	
  1423		return host->bus_ops->handle_undervoltage(host);
  1424	}
  1425	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
