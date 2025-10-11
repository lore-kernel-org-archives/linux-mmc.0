Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1C13C8E8;
	Sat, 11 Oct 2025 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760147703; cv=none; b=GaYyjgtmYh4dTcMxS8EhSBUUxB3XYl7gw46wz4+bBQdyeBDye77wXDk1iO7s4qgfRrkKQTJJaxLiQKbpXGUHuQrQEQKfSu08QvwPPPhmAQTlp90JqVgz3HhbzSPB3UneQmFDEFHfHoTQFa1Wr+G2dHk2S5ugaym/fmOXoNGKu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760147703; c=relaxed/simple;
	bh=FNVXbYYMLM7AKO+I86PHtmefui3iXAnkZpKI60U5gIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTuS2xjft81bIJTWtRDf8JnEkjGMoXNGZbQUNcpx0QTK8ni4PUbfnEE6pEQWfgTQrylZioVke359og9Ihr1XgWX31aBFnG97LKq0kyyRgweLg0cLfq0WowD6qS4LcYJ8j4Mt6EOT/lXBSwfy35pqtpL+mYwUopUeSQQTalZIv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lw8iGx78; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lw8iGx78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760147701; x=1791683701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FNVXbYYMLM7AKO+I86PHtmefui3iXAnkZpKI60U5gIE=;
  b=lw8iGx78ts+yvEfwb8ce3aabmdpv2s/r4027h+LF9DAxn3hrFJcE4IlU
   i9TFvh8aGX64Z2lQ4LOdPA1EFtNyjvd/ow6iOS/aXUNsS7DA7eMnUjTGo
   bQnQjKQ6Ps4t62FV0oOdzQmKw5h1x3fAQ+c7NQziSKYojHXifiMnY+y9Y
   qJmYM2e/uLmdYvgp+zZJsIRv6MR8gmKzKkeyT3NsjOtM0t3PiydeTrcFc
   gAlBSUp+aKwy5CjDejvphwhrDoscoAWnA/1y3B65hMM3F4Q6sBNDVwba3
   F+Or+lMcXkfX6cB35MQeva6fg6ceyYZq8K5hTvdOrbsSQBSUGrNcXPHMf
   A==;
X-CSE-ConnectionGUID: YsgERyGqTriBxD0TFOY4NA==
X-CSE-MsgGUID: Mq3Yg6OySjqGgraygA7mUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="87828806"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="87828806"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 18:55:01 -0700
X-CSE-ConnectionGUID: RN3Ws31oQOiBFZpjBbXCFg==
X-CSE-MsgGUID: WKFTCCVFT+W0kfFRR/rZnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="204790286"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Oct 2025 18:54:56 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7Oou-0003PL-2I;
	Sat, 11 Oct 2025 01:54:52 +0000
Date: Sat, 11 Oct 2025 09:54:24 +0800
From: kernel test robot <lkp@intel.com>
To: hehuan1@eswincomputing.com, ulf.hansson@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jszhang@kernel.org,
	adrian.hunter@intel.com, p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com, luyulin@eswincomputing.com,
	dongxuyang@eswincomputing.com, zhangsenchuan@eswincomputing.com,
	weishangjuan@eswincomputing.com, lizhi2@eswincomputing.com,
	caohang@eswincomputing.com, hehuan1@eswincomputing.com
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add support for Eswin
 EIC7700
Message-ID: <202510110904.0H6EStUB-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v6.17 next-20251010]
[cannot apply to robh/for-next pza/reset/next pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hehuan1-eswincomputing-com/dt-bindings-mmc-sdhci-of-dwcmshc-Add-Eswin-EIC7700/20251010-174323
base:   linus/master
patch link:    https://lore.kernel.org/r/20251010094109.1613-1-hehuan1%40eswincomputing.com
patch subject: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add support for Eswin EIC7700
config: x86_64-randconfig-005-20251011 (https://download.01.org/0day-ci/archive/20251011/202510110904.0H6EStUB-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110904.0H6EStUB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110904.0H6EStUB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mmc/host/sdhci-of-dwcmshc.c:300:13: error: redefinition of 'dwcmshc_enable_card_clk'
     300 | static void dwcmshc_enable_card_clk(struct sdhci_host *host)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-of-dwcmshc.c:289:13: note: previous definition of 'dwcmshc_enable_card_clk' with type 'void(struct sdhci_host *)'
     289 | static void dwcmshc_enable_card_clk(struct sdhci_host *host)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-of-dwcmshc.c: In function 'sdhci_eic7700_set_clock':
   drivers/mmc/host/sdhci-of-dwcmshc.c:1179:9: error: implicit declaration of function 'dwcmshc_disable_card_clk'; did you mean 'dwcmshc_enable_card_clk'? [-Wimplicit-function-declaration]
    1179 |         dwcmshc_disable_card_clk(host);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         dwcmshc_enable_card_clk
   drivers/mmc/host/sdhci-of-dwcmshc.c: At top level:
>> drivers/mmc/host/sdhci-of-dwcmshc.c:289:13: warning: 'dwcmshc_enable_card_clk' defined but not used [-Wunused-function]
     289 | static void dwcmshc_enable_card_clk(struct sdhci_host *host)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +/dwcmshc_enable_card_clk +289 drivers/mmc/host/sdhci-of-dwcmshc.c

   288	
 > 289	static void dwcmshc_enable_card_clk(struct sdhci_host *host)
   290	{
   291		u16 ctrl;
   292	
   293		ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
   294		if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
   295			ctrl |= SDHCI_CLOCK_CARD_EN;
   296			sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
   297		}
   298	}
   299	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
