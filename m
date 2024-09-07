Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771E15CD58;
	Sat,  7 Sep 2024 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725728163; cv=none; b=rFbjV2XzzoSQBTRYkUJ6e8XZiMT2KW8Nh79qfAGwfB6+HLN/5EJCDfODtxl4l0k/37sTr3J6KTlb6K9uuB42H5/I1ejqGc/dI39IRZi2IBsOMjv7fjy6NK8Yb/ZY20iz1s6sL3Az6+rFdxOZwgldEHsHeCuC08BFByVJGxIJ8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725728163; c=relaxed/simple;
	bh=x8ex8U0+4Uls5APqW8e9vtoDHeP3MUGcBiEZJ+bYhhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKzUii02qrJAfTGTrqfTlNyqvdIjM+sgHGiZEYvlvpqyrXgG8mUvUQJhWMpRdyMCVENJTyYArAmZYmPISC1iZdT63PoqWZJXUdbctB+l8keBdU0jaQmVInKO4WA7+6dw20EQLdLwvPS1sIV9rSa/CgJgTAFbsCGs25TAhMO7/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwY65qwM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwY65qwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725728161; x=1757264161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x8ex8U0+4Uls5APqW8e9vtoDHeP3MUGcBiEZJ+bYhhI=;
  b=hwY65qwM2PymvH2X418YagnGHqtl7LR/RUi2cwkP+HQoKIntV5AqZ77C
   MxBb8ICnOy5a9FQ1EzKQN4D0henTbWa0LaA+ZmKB09YyAOT+22Djb/iu+
   Ee6Ba6g0ZEfEr/1EJCnClgEMQ7MzCH4GVFTtADsZ4gwnpOuTAfkbz1e89
   zrcVexuOzP926Ladxgy7Oj6bmSth1BBJ0meNZln9SPh4q9wr2IfkdbnuJ
   ARvH8GXyCuU1nVSpb6YzqrXKqxXIm+LtY7CrCorKfcuMw+pZjMhPVT/6F
   2JLEHkS35jDHw0AV+2KpW8SYsuxGiiTFmGOF7pVg89lN+9beSdlkqHhKa
   w==;
X-CSE-ConnectionGUID: vKrHaz2ySHeg0/4yHz3gcA==
X-CSE-MsgGUID: H9h0XN2ZQ+mcdH3MW7yjWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="28209677"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="28209677"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 09:56:00 -0700
X-CSE-ConnectionGUID: IOH8kLR+SYSJxCFoVqpOTQ==
X-CSE-MsgGUID: iWIgpdyOTL2BgCNJ5v2Mug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="66465071"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Sep 2024 09:55:57 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smyj5-000Ck7-2C;
	Sat, 07 Sep 2024 16:55:55 +0000
Date: Sun, 8 Sep 2024 00:55:23 +0800
From: kernel test robot <lkp@intel.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch
Message-ID: <202409080031.zgsuKKXB-lkp@intel.com>
References: <20240906175032.1580281-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906175032.1580281-1-jm@ti.com>

Hi Judith,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cf6444ba528f043398b112ac36e041a4d8685cb1]

url:    https://github.com/intel-lab-lkp/linux/commits/Judith-Mendez/mmc-sdhci_am654-Add-sdhci_am654_start_signal_voltage_switch/20240907-015144
base:   cf6444ba528f043398b112ac36e041a4d8685cb1
patch link:    https://lore.kernel.org/r/20240906175032.1580281-1-jm%40ti.com
patch subject: [PATCH v1] mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240908/202409080031.zgsuKKXB-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409080031.zgsuKKXB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080031.zgsuKKXB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/sdhci_am654.c:360:5: warning: no previous prototype for function 'sdhci_am654_start_signal_voltage_switch' [-Wmissing-prototypes]
     360 | int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc,
         |     ^
   drivers/mmc/host/sdhci_am654.c:360:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     360 | int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc,
         | ^
         | static 
>> drivers/mmc/host/sdhci_am654.c:377:3: warning: variable 'ctrl' is uninitialized when used here [-Wuninitialized]
     377 |                 ctrl &= ~SDHCI_CTRL_VDD_180;
         |                 ^~~~
   drivers/mmc/host/sdhci_am654.c:366:10: note: initialize the variable 'ctrl' to silence this warning
     366 |         u16 ctrl;
         |                 ^
         |                  = 0
   2 warnings generated.


vim +/sdhci_am654_start_signal_voltage_switch +360 drivers/mmc/host/sdhci_am654.c

   359	
 > 360	int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc,
   361						    struct mmc_ios *ios)
   362	{
   363		struct sdhci_host *host = mmc_priv(mmc);
   364		struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
   365		struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
   366		u16 ctrl;
   367		int ret;
   368	
   369		if (host->version < SDHCI_SPEC_300)
   370			return 0;
   371	
   372		switch (ios->signal_voltage) {
   373		case MMC_SIGNAL_VOLTAGE_330:
   374			if (!(host->flags & SDHCI_SIGNALING_330))
   375				return -EINVAL;
   376	
 > 377			ctrl &= ~SDHCI_CTRL_VDD_180;
   378			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
   379	
   380			if (!IS_ERR(mmc->supply.vqmmc)) {
   381				ret = mmc_regulator_set_vqmmc(mmc, ios);
   382				if (ret < 0) {
   383					pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
   384						mmc_hostname(mmc));
   385					return -EIO;
   386				}
   387			}
   388	
   389			usleep_range(5000, 5500);
   390	
   391			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
   392			if (!(ctrl & SDHCI_CTRL_VDD_180))
   393				return 0;
   394	
   395			pr_warn("%s: 3.3V regulator output did not become stable\n",
   396				mmc_hostname(mmc));
   397	
   398			return -EAGAIN;
   399	
   400		case MMC_SIGNAL_VOLTAGE_180:
   401			if (!(host->flags & SDHCI_SIGNALING_180))
   402				return -EINVAL;
   403	
   404			if (!IS_ERR(mmc->supply.vqmmc)) {
   405				ret = mmc_regulator_set_vqmmc(mmc, ios);
   406				if (ret < 0) {
   407					pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
   408						mmc_hostname(mmc));
   409					return -EIO;
   410				}
   411			}
   412	
   413			if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_SET_V1P8_ENA) {
   414				ctrl |= SDHCI_CTRL_VDD_180;
   415				sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
   416	
   417				ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
   418				if (ctrl & SDHCI_CTRL_VDD_180)
   419					return 0;
   420	
   421				pr_warn("%s: 1.8V regulator output did not become stable\n",
   422					mmc_hostname(mmc));
   423	
   424				return -EAGAIN;
   425			}
   426			return 0;
   427	
   428		default:
   429			return 0;
   430		}
   431	}
   432	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
