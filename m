Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617A207A22;
	Wed,  6 Aug 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475922; cv=none; b=PTRhUhYn8lXopmmLAv4bO07Sz9S5104grj9S1mrOos+EjNV6lrHPNx6gjKk8krzzC4NdzK1o3aD8sm5nlKimIaU+jpbar1i7DipN8Hu82m8E37ZQBAZQKseTUJyvU1FObeyzQU0s2HUUmvYg37sBAKVbcokeuMfmia0NOlqN0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475922; c=relaxed/simple;
	bh=lQuKRNOdyBLCKnmOXaLObB146vsfWcL0sWyfJEa5yo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyuQp8BCZzo5FYb9Zl30cqSr39+HCiryg1Nf+gzpps5KO/cJ9UmnsBEJ2nkLEARhbLMEHc3NpGtYo7NVfxOOUf4kcasnbIUeZjM/BnSoVl/UUthN0g4ApS9+osYsJsKY1OSBNtTgKICMYV8SDXajwjw8L675YQRj7Y1L8bqmeLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEYm2b/x; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEYm2b/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754475921; x=1786011921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lQuKRNOdyBLCKnmOXaLObB146vsfWcL0sWyfJEa5yo8=;
  b=AEYm2b/xTxyQu/CUGCjKkZnakRNsgBDSZ2sHCszulmZJExwXAj4fiSH5
   gPf4Cqp54CoRGSiqpH9mIGJIczDmkJhWBG40IQhVD06HpdQvBi6/7sUFL
   UY/qfneE66c14CpU+TjjkxoDQBERWnw5gOi7y/JzAtATan7Yzm+M5wfRk
   sNtIqMo0nntviY/9sC2G1vRKS1k4oeCAqY3ldsXTdg0pYmHvugv4l1L0Y
   +4mT9QhHudD4fsM6oNN9E37HyJy6B6d9NDHmEm5iz8oLsjxwrgY9xWldp
   fTucpi02PczgiZEEhplpSUtHNmij6QwFqixp0l7w19VPW1vBO7/ntBv34
   w==;
X-CSE-ConnectionGUID: RQSEnFjUQ5C7YW+iw+U/LQ==
X-CSE-MsgGUID: b/cJDfU/TOSTb4TTO5Pndw==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="79337040"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="79337040"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 03:25:21 -0700
X-CSE-ConnectionGUID: Z6/6PeVJTYOIZNPtcxitnA==
X-CSE-MsgGUID: HS2lCiJCTYaqt9oompwpvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="195579330"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 06 Aug 2025 03:25:18 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujbKW-0001Xe-0I;
	Wed, 06 Aug 2025 10:25:11 +0000
Date: Wed, 6 Aug 2025 18:24:15 +0800
From: kernel test robot <lkp@intel.com>
To: Ricky Wu <ricky_wu@realtek.com>, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, chenhuacai@kernel.org,
	ulf.hansson@linaro.org, maximlevitsky@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] misc: rtsx: usb card reader: add OCP support
Message-ID: <202508061704.hwI8epAJ-lkp@intel.com>
References: <20250805032220.2355160-1-ricky_wu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805032220.2355160-1-ricky_wu@realtek.com>

Hi Ricky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master next-20250806]
[cannot apply to soc/for-next ulf-hansson-mmc-mirror/next v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ricky-Wu/misc-rtsx-usb-card-reader-add-OCP-support/20250806-101802
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250805032220.2355160-1-ricky_wu%40realtek.com
patch subject: [PATCH] misc: rtsx: usb card reader: add OCP support
config: i386-buildonly-randconfig-001-20250806 (https://download.01.org/0day-ci/archive/20250806/202508061704.hwI8epAJ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508061704.hwI8epAJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508061704.hwI8epAJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/rtsx_usb_sdmmc.c:1054:7: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1054 |                 if (!(host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)))
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/rtsx_usb_sdmmc.c:1056:7: note: uninitialized use occurs here
    1056 |                 if (err)
         |                     ^~~
   drivers/mmc/host/rtsx_usb_sdmmc.c:1054:3: note: remove the 'if' if its condition is always true
    1054 |                 if (!(host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1055 |                         err = sd_power_on(host);
   drivers/mmc/host/rtsx_usb_sdmmc.c:1038:9: note: initialize the variable 'err' to silence this warning
    1038 |         int err;
         |                ^
         |                 = 0
   1 warning generated.


vim +1054 drivers/mmc/host/rtsx_usb_sdmmc.c

  1034	
  1035	static void sd_set_power_mode(struct rtsx_usb_sdmmc *host,
  1036			unsigned char power_mode)
  1037	{
  1038		int err;
  1039		struct rtsx_ucr *ucr = host->ucr;
  1040	
  1041		if (power_mode == host->power_mode)
  1042			return;
  1043	
  1044		switch (power_mode) {
  1045		case MMC_POWER_OFF:
  1046			err = sd_power_off(host);
  1047			if (err)
  1048				dev_dbg(sdmmc_dev(host), "power-off (err = %d)\n", err);
  1049			pm_runtime_put_noidle(sdmmc_dev(host));
  1050			break;
  1051	
  1052		case MMC_POWER_UP:
  1053			pm_runtime_get_noresume(sdmmc_dev(host));
> 1054			if (!(host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)))
  1055				err = sd_power_on(host);
  1056			if (err)
  1057				dev_dbg(sdmmc_dev(host), "power-on (err = %d)\n", err);
  1058			/* issue the clock signals to card at least 74 clocks */
  1059			rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
  1060			break;
  1061	
  1062		case MMC_POWER_ON:
  1063			/* stop to send the clock signals */
  1064			rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0x00);
  1065			break;
  1066	
  1067		case MMC_POWER_UNDEFINED:
  1068			break;
  1069	
  1070		default:
  1071			break;
  1072		}
  1073	
  1074		host->power_mode = power_mode;
  1075	}
  1076	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
