Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3E2AEE0;
	Tue, 15 Oct 2024 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728958166; cv=none; b=LI7Qpa/o6pegYC07SWGKo62wZLg/Csi1LVCCoHNAbKdLiPgGiMfJ0Is6RH8N8auur5sPSMMq9ikYf0sWj/uBAHhLwssEwUQ5YKQSSLAtP1I2uDuZDHcnQZ+PhT22gnp9gPWYObJ/xhi2m8U+V55v30KlfEiA+j0xzFj5uNg8UEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728958166; c=relaxed/simple;
	bh=urQTujlL+mXX00KaOkcwECReA/98PcrsWg4J5CM//nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL1iUYkhUqek3auYgh4K5KLMDSv1c5FocxeRQlYgLLHlt5j//BelHUZhvKgnJd3LGJQQmHOi8yteBSGIG0xh4vEycI/CKAF41hGOSCf3E2yKjk3bj5N60sYYtgCF82oVIkBXxxvePT2JckznavHKUg+kqLAbi7eoI3k7SnkP6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R45q3o+l; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R45q3o+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728958165; x=1760494165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=urQTujlL+mXX00KaOkcwECReA/98PcrsWg4J5CM//nk=;
  b=R45q3o+l26cg4EwRMKXeeduvqzmVms2D+1JEN4UcjPhE+MFEMIZo7Z6n
   3KM0MdZgAREfDCF13TdzOJ6dqGEpfr+eegdKjbNL0b6kzbHRcIY0Gnvka
   jHpr/a8BmPKAOgB6qDUz/tECMqn5UWHa3A9/6+YOZRwsieUtpJV9B72wc
   7sJ6e+U/scP8FTyul+BO2My2nbirL3ffXdvoK1olP/D0mGFUXCk9Z2ptP
   I9yYkv2+cMhhwPg4Vohd1SdNvaPdNykUgxoPUREskWSH6LZ4oFCf2B/d1
   wBsZW/bYHKmQSOvGBGMPJXW+pyspHf5y8qai+RhjcFvhtx5bVReMTmkCL
   A==;
X-CSE-ConnectionGUID: ZHYNBGqYRQin7YXNa7YEbg==
X-CSE-MsgGUID: AYK+t0XFQP+DSY8tp8jKGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45802472"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45802472"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 19:09:24 -0700
X-CSE-ConnectionGUID: jXhq2bYrSJCW/i13dUYxFw==
X-CSE-MsgGUID: KXJTS7GvRxuRpjnD/nkwzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="82516590"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Oct 2024 19:09:21 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0Wzt-000HTU-3A;
	Tue, 15 Oct 2024 02:09:17 +0000
Date: Tue, 15 Oct 2024 10:08:26 +0800
From: kernel test robot <lkp@intel.com>
To: haibo.chen@nxp.com, adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev, haibo.chen@nxp.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, s32@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mmc: host: sdhci-esdhc-imx: save tuning value for
 the SDIO card as wakeup source
Message-ID: <202410150906.OEI0jyKN-lkp@intel.com>
References: <20241014060130.1162629-4-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014060130.1162629-4-haibo.chen@nxp.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on linus/master v6.12-rc3 next-20241014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/haibo-chen-nxp-com/mmc-sdhci-export-APIs-for-sdhci-irq-wakeup/20241014-140300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20241014060130.1162629-4-haibo.chen%40nxp.com
patch subject: [PATCH 3/4] mmc: host: sdhci-esdhc-imx: save tuning value for the SDIO card as wakeup source
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241015/202410150906.OEI0jyKN-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241015/202410150906.OEI0jyKN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410150906.OEI0jyKN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-esdhc-imx.c:1592:13: warning: 'sdhc_esdhc_tuning_restore' defined but not used [-Wunused-function]
    1592 | static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-esdhc-imx.c:1569:13: warning: 'sdhc_esdhc_tuning_save' defined but not used [-Wunused-function]
    1569 | static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
         |             ^~~~~~~~~~~~~~~~~~~~~~


vim +/sdhc_esdhc_tuning_restore +1592 drivers/mmc/host/sdhci-esdhc-imx.c

  1568	
> 1569	static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
  1570	{
  1571		struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
  1572		struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
  1573		u32 reg;
  1574	
  1575		/*
  1576		 * SD/eMMC do not need this tuning save because it will re-init
  1577		 * after system resume back.
  1578		 * Here save the tuning delay value for SDIO device since it may
  1579		 * keep power during system PM. And for usdhc, only SDR50 and
  1580		 * SDR104 mode for SDIO devide need to do tuning, and need to
  1581		 * save/restore.
  1582		 */
  1583		if ((host->timing == MMC_TIMING_UHS_SDR50) |
  1584				(host->timing == MMC_TIMING_UHS_SDR104)) {
  1585			reg = readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
  1586			reg = (reg & ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK) >>
  1587					ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_SHIFT;
  1588			imx_data->boarddata.saved_tuning_delay_cell = reg;
  1589		}
  1590	}
  1591	
> 1592	static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
  1593	{
  1594		struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
  1595		struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
  1596		u32 reg;
  1597	
  1598		if ((host->timing == MMC_TIMING_UHS_SDR50) |
  1599				(host->timing == MMC_TIMING_UHS_SDR104)) {
  1600			/*
  1601			 * restore the tuning delay value actually is a
  1602			 * manual tuning method, so clear the standard
  1603			 * tuning enable bit here. Will set back this
  1604			 * ESDHC_STD_TUNING_EN in esdhc_reset_tuning()
  1605			 * when trigger re-tuning.
  1606			 */
  1607			reg = readl(host->ioaddr + ESDHC_TUNING_CTRL);
  1608			reg &= ~ESDHC_STD_TUNING_EN;
  1609			writel(reg, host->ioaddr + ESDHC_TUNING_CTRL);
  1610	
  1611			reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
  1612			reg |= ESDHC_MIX_CTRL_SMPCLK_SEL | ESDHC_MIX_CTRL_FBCLK_SEL;
  1613			writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
  1614	
  1615			writel(imx_data->boarddata.saved_tuning_delay_cell <<
  1616					ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_SHIFT,
  1617					host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
  1618		}
  1619	}
  1620	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
