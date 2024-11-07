Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70341CC16C
	for <linux-mmc@vger.kernel.org>; Thu,  7 Nov 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972169; cv=none; b=kKmcL3p5HtqYQt53EwtwK9paUWDf4BxkU3UUmwZZzAcsnq6FDCb4WWelkQkKW05sJyMycP2kT7RXVSawFPohMhw+8zOg5GdX/5hvJmRYn2qL3FGl65/dj4BA3BfPoBLTJEYgfpIVZSwA3iIKcPfsIz9m59Ld0LYHOP2Sq4xeiYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972169; c=relaxed/simple;
	bh=mB6MVB4b7gF6TXIDCHMbq8tLAQaO1lxgKeME80EOWEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL/x+dCa/HXOV0Rq6kXvlJeto7FkEIenNx+u+Zpu+P6uPfAyLsmH47VNAfXpcMYP8cVWa2w4pm1y/SfBRgYhb8KCo5XzuFtJA8ozz/JewghSYQGIIGDyZiXznW09bLAZyajese2ZTZs1OAaiI+o579a1LUT1yyVlz/xy3E2D5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/LF5sRX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/LF5sRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730972167; x=1762508167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mB6MVB4b7gF6TXIDCHMbq8tLAQaO1lxgKeME80EOWEs=;
  b=W/LF5sRX0ZwH9XMu0mUJwxdmIbcWR2ymBrWBq5XF196qOD3N1YEOZdT9
   yxvZ0xWI41EJxQ+XN5/xtkBbXLn83u/ySvXUNYux5pgrO8GeZSfoxoHI+
   e3fJvM14f4YuE7ru1dEubJW7TcdTBYIPOijWbFxqqjKR6H5wsVihjailb
   X1gogh4MhptWKlE6L5IeBt6er6AIeRyJ95dv/0EF4W5lYGs6vrB9Xondg
   2+Wc5zDj+zZYFyT1+M93PQkEL2zLWv7GvgrnikxFiXTjW4R+Ckblns6HG
   Y66ehZlOef1++/8Fz5yYhuwgf70JqRUKSlIMbWegYY8fZUAq/g6khJmdB
   w==;
X-CSE-ConnectionGUID: 1psddtsiQpy9GJcJL+21Fg==
X-CSE-MsgGUID: gEHEw9ruSiC6QzQYpKqyHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41908054"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41908054"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 01:36:07 -0800
X-CSE-ConnectionGUID: vHkGxGmZT/mZVkdWe7nFuQ==
X-CSE-MsgGUID: EvoS3kjmSamiqpQnEnEbQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="84561418"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Nov 2024 01:36:05 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8yvq-000q3q-21;
	Thu, 07 Nov 2024 09:36:02 +0000
Date: Thu, 7 Nov 2024 17:35:52 +0800
From: kernel test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on
 Vexia Edu Atla 10 tablet
Message-ID: <202411071730.x3HIZimE-lkp@intel.com>
References: <20241106215927.40482-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106215927.40482-1-hdegoede@redhat.com>

Hi Hans,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ulf-hansson-mmc-mirror/next]
[also build test WARNING on linus/master v6.12-rc6 next-20241106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hans-de-Goede/mmc-sdhci-pci-Add-DMI-quirk-for-missing-CD-GPIO-on-Vexia-Edu-Atla-10-tablet/20241107-060048
base:   https://git.linaro.org/people/ulf.hansson/mmc-mirror.git next
patch link:    https://lore.kernel.org/r/20241106215927.40482-1-hdegoede%40redhat.com
patch subject: [PATCH] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet
config: i386-randconfig-061-20241107 (https://download.01.org/0day-ci/archive/20241107/202411071730.x3HIZimE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411071730.x3HIZimE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411071730.x3HIZimE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mmc/host/sdhci-pci-core.c:2068:28: sparse: sparse: symbol 'sdhci_pci_dmi_cd_gpio_overrides' was not declared. Should it be static?

vim +/sdhci_pci_dmi_cd_gpio_overrides +2068 drivers/mmc/host/sdhci-pci-core.c

  2067	
> 2068	const struct dmi_system_id sdhci_pci_dmi_cd_gpio_overrides[] = {
  2069		{
  2070			/* Vexia Edu Atla 10 tablet 9V version */
  2071			.matches = {
  2072				DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
  2073				DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
  2074				/* Above strings are too generic, also match on BIOS date */
  2075				DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
  2076			},
  2077			.driver_data = (void *)&vexia_edu_atla10_cd_gpios,
  2078		},
  2079		{ }
  2080	};
  2081	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
