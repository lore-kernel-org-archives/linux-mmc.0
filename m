Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8038019EED3;
	Thu, 29 May 2025 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748481798; cv=none; b=RF56s0D7kBy2D7Y2YDQ/+t/rw3JFweuZAnNHfQjKd+dcB74NViLSJaEN9e3vwDLZAwu/8Le9P40CVzrjha2ptuy1Dq9KgkGDPwdeihWjiII9L/Dr9xzmIKeyOdOq3x0LEIOGb3qtp6FyaYO3uIn8xtxdkZTHcm3vD1hLfmfk3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748481798; c=relaxed/simple;
	bh=QK5xN4iAYIy2de7G5LO7XNLDgkJPP8EX5G46RfYKVLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq46AWulQavxj8yMpGruaSEHvCAPE5yWcY7KUo7O5pOIcncMXSfACiJGKlo0Pnjg/SzhloolOQ0fwJH2o5VwYF1gpn6bE4+peOxjPXP/FkwUPOXSOPUAMaD/jgfYtN2qolpLz5nFIf8B57iCtbX7RLxNol9P399asgwlO/2myVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoaBlnhK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoaBlnhK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748481796; x=1780017796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QK5xN4iAYIy2de7G5LO7XNLDgkJPP8EX5G46RfYKVLc=;
  b=CoaBlnhK5J7wjLA/RyIy6QH926JST/iGD9hCKfyWj3capBboYRhpXUpT
   iq63DgiD4Z5rCIE4ai8xII6MP5pHGjGkGNIkqtIgKaOa+arf9B6vrvJUM
   F9Gm6Y/JSvOpuRu6OqZIjJOnr1GicEn995sSlhussz/nme66GEM4inojw
   kqaptTYUmPLazgFxYtYE/bTO68xXlbSjtQ18pjUvUVQfkg2nzqp2qg/KB
   eb9j4GSy/8kHK9lD/gwAVN98JH99icO+Rtjkmf398ebUf1w+8rm+ppH7E
   cZ0O31Qe2YNKMMDlVFuxHfu2lGCXR+1MmiAsr4UaWQVmyRZi0zzw3RykI
   g==;
X-CSE-ConnectionGUID: VrhSMW5nR+q4CyxQtZkEOg==
X-CSE-MsgGUID: tmqs0J3LTKSQWbAqSb79Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50633425"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="50633425"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:23:15 -0700
X-CSE-ConnectionGUID: vqbz4hkqSHqszwGlJQuVbA==
X-CSE-MsgGUID: ouBExTf0Q8KhqOEZkzz4Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="166563202"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 May 2025 18:23:12 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKRzB-000WDC-2S;
	Thu, 29 May 2025 01:23:09 +0000
Date: Thu, 29 May 2025 09:22:57 +0800
From: kernel test robot <lkp@intel.com>
To: Albert Yang <yangzh0906@thundersoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ge Gordon <gordon.ge@bst.ai>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Shan-Chun Hung <shanchun1218@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: Re: [PATCH v1 5/9] mmc: sdhci: add Black Sesame Technologies BST
 C1200 controller driver
Message-ID: <202505290935.IfNyJVFA-lkp@intel.com>
References: <20250528085453.481320-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528085453.481320-1-yangzh0906@thundersoft.com>

Hi Albert,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm64/for-next/core soc/for-next krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next linus/master v6.15 next-20250528]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Albert-Yang/dt-bindings-vendor-prefixes-Add-Black-Sesame-Technologies-Co-Ltd/20250528-190614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250528085453.481320-1-yangzh0906%40thundersoft.com
patch subject: [PATCH v1 5/9] mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250529/202505290935.IfNyJVFA-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505290935.IfNyJVFA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505290935.IfNyJVFA-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-of-bst-c1200.c:64:6: warning: no previous prototype for function 'sdhci_bst_print_vendor' [-Wmissing-prototypes]
      64 | void sdhci_bst_print_vendor(struct sdhci_host *host)
         |      ^
   drivers/mmc/host/sdhci-of-bst-c1200.c:64:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      64 | void sdhci_bst_print_vendor(struct sdhci_host *host)
         | ^
         | static 
   drivers/mmc/host/sdhci-of-bst-c1200.c:153:6: warning: no previous prototype for function 'sdhci_enable_bst_clk' [-Wmissing-prototypes]
     153 | void sdhci_enable_bst_clk(struct sdhci_host *host, unsigned int clk)
         |      ^
   drivers/mmc/host/sdhci-of-bst-c1200.c:153:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     153 | void sdhci_enable_bst_clk(struct sdhci_host *host, unsigned int clk)
         | ^
         | static 
   drivers/mmc/host/sdhci-of-bst-c1200.c:245:6: warning: no previous prototype for function 'sdhci_set_bst_clock' [-Wmissing-prototypes]
     245 | void sdhci_set_bst_clock(struct sdhci_host *host, unsigned int clock)
         |      ^
   drivers/mmc/host/sdhci-of-bst-c1200.c:245:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     245 | void sdhci_set_bst_clock(struct sdhci_host *host, unsigned int clock)
         | ^
         | static 
   drivers/mmc/host/sdhci-of-bst-c1200.c:323:6: warning: unused variable 'val' [-Wunused-variable]
     323 |         u32 val;
         |             ^~~
>> drivers/mmc/host/sdhci-of-bst-c1200.c:607:18: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     607 |         host->max_clk = FIELD_GET(SDHCI_CLOCK_V3_BASE_MASK, host->caps);
         |                         ^
   drivers/mmc/host/sdhci-of-bst-c1200.c:513:6: warning: variable 'max_clk' set but not used [-Wunused-but-set-variable]
     513 |         u32 max_clk;
         |             ^
   drivers/mmc/host/sdhci-of-bst-c1200.c:515:7: warning: variable 'enable_vqmmc' set but not used [-Wunused-but-set-variable]
     515 |         bool enable_vqmmc = false;
         |              ^
   drivers/mmc/host/sdhci-of-bst-c1200.c:507:5: warning: no previous prototype for function 'bst_sdhci_setup_host' [-Wmissing-prototypes]
     507 | int bst_sdhci_setup_host(struct sdhci_host *host)
         |     ^
   drivers/mmc/host/sdhci-of-bst-c1200.c:507:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     507 | int bst_sdhci_setup_host(struct sdhci_host *host)
         | ^
         | static 
   7 warnings and 1 error generated.


vim +/FIELD_GET +607 drivers/mmc/host/sdhci-of-bst-c1200.c

   506	
   507	int bst_sdhci_setup_host(struct sdhci_host *host)
   508	{
   509		struct mmc_host *mmc;
   510		u32 max_current_caps;
   511		unsigned int ocr_avail;
   512		unsigned int override_timeout_clk;
   513		u32 max_clk;
   514		int ret = 0;
   515		bool enable_vqmmc = false;
   516	
   517		WARN_ON(!host);
   518		if (!host)
   519			return -EINVAL;
   520	
   521		mmc = host->mmc;
   522	
   523		/*
   524		 * If there are external regulators, get them. Note this must be done
   525		 * early before resetting the host and reading the capabilities so that
   526		 * the host can take the appropriate action if regulators are not
   527		 * available.
   528		 */
   529		if (!mmc->supply.vqmmc) {
   530			ret = mmc_regulator_get_supply(mmc);
   531			if (ret)
   532				return ret;
   533			enable_vqmmc  = true;
   534		}
   535	
   536		pr_info("Version:   0x%08x | Present:  0x%08x\n",
   537			sdhci_readw(host, SDHCI_HOST_VERSION),
   538			sdhci_readl(host, SDHCI_PRESENT_STATE));
   539		pr_info("Caps:      0x%08x | Caps_1:   0x%08x\n",
   540			sdhci_readl(host, SDHCI_CAPABILITIES),
   541			sdhci_readl(host, SDHCI_CAPABILITIES_1));
   542	
   543		sdhci_read_caps(host);
   544	
   545		override_timeout_clk = host->timeout_clk;
   546	
   547		host->flags |= SDHCI_USE_SDMA;
   548	
   549		if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
   550			if (host->ops->set_dma_mask)
   551				ret = host->ops->set_dma_mask(host);
   552			else
   553				ret = bst_sdhci_set_dma_mask(host);
   554	
   555			if (!ret && host->ops->enable_dma)
   556				ret = host->ops->enable_dma(host);
   557	
   558			if (ret) {
   559				pr_warn("%s: No suitable DMA available - falling back to PIO\n",
   560					mmc_hostname(mmc));
   561				host->flags &= ~(SDHCI_USE_SDMA | SDHCI_USE_ADMA);
   562	
   563				ret = 0;
   564			}
   565		}
   566	
   567		if (host->flags & SDHCI_USE_ADMA) {
   568			dma_addr_t dma;
   569			void *buf;
   570	
   571			if (!(host->flags & SDHCI_USE_64_BIT_DMA))
   572				host->alloc_desc_sz = SDHCI_ADMA2_32_DESC_SZ;
   573			else if (!host->alloc_desc_sz)
   574				host->alloc_desc_sz = SDHCI_ADMA2_64_DESC_SZ(host);
   575	
   576			host->desc_sz = host->alloc_desc_sz;
   577			host->adma_table_sz = host->adma_table_cnt * host->desc_sz;
   578	
   579			host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
   580			/*
   581			 * Use zalloc to zero the reserved high 32-bits of 128-bit
   582			 * descriptors so that they never need to be written.
   583			 */
   584			buf = dma_alloc_coherent(mmc_dev(mmc),
   585						 host->align_buffer_sz + host->adma_table_sz,
   586						 &dma, GFP_KERNEL);
   587			if (!buf) {
   588				pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
   589					mmc_hostname(mmc));
   590				host->flags &= ~SDHCI_USE_ADMA;
   591			} else if ((dma + host->align_buffer_sz) &
   592				   (SDHCI_ADMA2_DESC_ALIGN - 1)) {
   593				pr_warn("%s: unable to allocate aligned ADMA descriptor\n",
   594					mmc_hostname(mmc));
   595				host->flags &= ~SDHCI_USE_ADMA;
   596				dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
   597						  host->adma_table_sz, buf, dma);
   598			} else {
   599				host->align_buffer = buf;
   600				host->align_addr = dma;
   601	
   602				host->adma_table = buf + host->align_buffer_sz;
   603				host->adma_addr = dma + host->align_buffer_sz;
   604			}
   605		}
   606	
 > 607		host->max_clk = FIELD_GET(SDHCI_CLOCK_V3_BASE_MASK, host->caps);
   608	
   609		host->max_clk *= 1000000;
   610		if (host->max_clk == 0 || host->quirks &
   611				SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN) {
   612			if (!host->ops->get_max_clock) {
   613				pr_err("%s: Hardware doesn't specify base clock frequency.\n",
   614				       mmc_hostname(mmc));
   615				ret = -ENODEV;
   616				goto undma;
   617			}
   618			host->max_clk = host->ops->get_max_clock(host);
   619		}
   620	
   621		/*
   622		 * Set host parameters.
   623		 */
   624		max_clk = host->max_clk;
   625	
   626		if (host->ops->get_min_clock)
   627			mmc->f_min = host->ops->get_min_clock(host);
   628	
   629		if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
   630			host->timeout_clk = FIELD_GET(SDHCI_TIMEOUT_CLK_MASK, host->caps);
   631	
   632			if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
   633				host->timeout_clk *= 1000;
   634	
   635			if (host->timeout_clk == 0) {
   636				if (!host->ops->get_timeout_clock) {
   637					pr_err("%s: Hardware doesn't specify timeout clock frequency.\n",
   638					       mmc_hostname(mmc));
   639					ret = -ENODEV;
   640					goto undma;
   641				}
   642	
   643				host->timeout_clk =
   644					DIV_ROUND_UP(host->ops->get_timeout_clock(host),
   645						     1000);
   646			}
   647	
   648			if (override_timeout_clk)
   649				host->timeout_clk = override_timeout_clk;
   650	
   651			mmc->max_busy_timeout = host->ops->get_max_timeout_count ?
   652				host->ops->get_max_timeout_count(host) : 1 << 27;
   653			mmc->max_busy_timeout /= host->timeout_clk;
   654		}
   655	
   656		mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_CMD23;
   657		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
   658	
   659		if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
   660			host->flags |= SDHCI_AUTO_CMD12;
   661	
   662		/*
   663		 * A controller may support 8-bit width, but the board itself
   664		 * might not have the pins brought out.  Boards that support
   665		 * 8-bit width must set "mmc->caps |= MMC_CAP_8_BIT_DATA;" in
   666		 * their platform code before calling sdhci_add_host(), and we
   667		 * won't assume 8-bit width for hosts without that CAP.
   668		 */
   669		if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
   670			mmc->caps |= MMC_CAP_4_BIT_DATA;
   671	
   672		if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
   673			mmc->caps &= ~MMC_CAP_CMD23;
   674	
   675		if (host->caps & SDHCI_CAN_DO_HISPD)
   676			mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
   677	
   678		/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
   679		if (host->caps1 & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
   680				   SDHCI_SUPPORT_DDR50))
   681			mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
   682	
   683		/* SDR104 supports also implies SDR50 support */
   684		if (host->caps1 & SDHCI_SUPPORT_SDR104) {
   685			mmc->caps |= MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_SDR50;
   686			/* SD3.0: SDR104 is supported so (for eMMC) the caps2
   687			 * field can be promoted to support HS200.
   688			 */
   689			if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200))
   690				mmc->caps2 |= MMC_CAP2_HS200;
   691		}
   692	
   693		if ((mmc->caps2 & MMC_CAP2_HSX00_1_2V) &&
   694		    (IS_ERR(mmc->supply.vqmmc) ||
   695		     !regulator_is_supported_voltage(mmc->supply.vqmmc, 1100000,
   696						     1300000)))
   697			mmc->caps2 &= ~MMC_CAP2_HSX00_1_2V;
   698	
   699		/* Does the host need tuning for SDR50? */
   700		if (host->caps1 & SDHCI_USE_SDR50_TUNING)
   701			host->flags |= SDHCI_SDR50_NEEDS_TUNING;
   702	
   703		/* Driver Type(s) (A, C, D) supported by the host */
   704		if (host->caps1 & SDHCI_DRIVER_TYPE_A)
   705			mmc->caps |= MMC_CAP_DRIVER_TYPE_A;
   706		if (host->caps1 & SDHCI_DRIVER_TYPE_C)
   707			mmc->caps |= MMC_CAP_DRIVER_TYPE_C;
   708		if (host->caps1 & SDHCI_DRIVER_TYPE_D)
   709			mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
   710	
   711		/* Initial value for re-tuning timer count */
   712		host->tuning_count = FIELD_GET(SDHCI_RETUNING_TIMER_COUNT_MASK,
   713					       host->caps1);
   714	
   715		/*
   716		 * In case Re-tuning Timer is not disabled, the actual value of
   717		 * re-tuning timer will be 2 ^ (n - 1).
   718		 */
   719		if (host->tuning_count)
   720			host->tuning_count = 1 << (host->tuning_count - 1);
   721	
   722		/* Re-tuning mode supported by the Host Controller */
   723		host->tuning_mode = FIELD_GET(SDHCI_RETUNING_MODE_MASK, host->caps1);
   724	
   725		ocr_avail = 0;
   726	
   727		if (host->caps & SDHCI_CAN_VDD_330) {
   728			ocr_avail |= MMC_VDD_32_33 | MMC_VDD_33_34;
   729	
   730			mmc->max_current_330 = FIELD_GET(SDHCI_MAX_CURRENT_330_MASK,
   731							 max_current_caps) *
   732							SDHCI_MAX_CURRENT_MULTIPLIER;
   733		}
   734		if (host->caps & SDHCI_CAN_VDD_300) {
   735			ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
   736	
   737			mmc->max_current_300 = FIELD_GET(SDHCI_MAX_CURRENT_300_MASK,
   738							 max_current_caps) *
   739							SDHCI_MAX_CURRENT_MULTIPLIER;
   740		}
   741		if (host->caps & SDHCI_CAN_VDD_180) {
   742			ocr_avail |= MMC_VDD_165_195;
   743	
   744			mmc->max_current_180 = FIELD_GET(SDHCI_MAX_CURRENT_180_MASK,
   745							 max_current_caps) *
   746							SDHCI_MAX_CURRENT_MULTIPLIER;
   747		}
   748	
   749		/* If OCR set by host, use it instead. */
   750		if (host->ocr_mask)
   751			ocr_avail = host->ocr_mask;
   752	
   753		/* If OCR set by external regulators, give it highest prio. */
   754		if (mmc->ocr_avail)
   755			ocr_avail = mmc->ocr_avail;
   756	
   757		mmc->ocr_avail = ocr_avail;
   758		mmc->ocr_avail_sdio = ocr_avail;
   759		if (host->ocr_avail_sdio)
   760			mmc->ocr_avail_sdio &= host->ocr_avail_sdio;
   761		mmc->ocr_avail_sd = ocr_avail;
   762		if (host->ocr_avail_sd)
   763			mmc->ocr_avail_sd &= host->ocr_avail_sd;
   764		else /* normal SD controllers don't support 1.8V */
   765			mmc->ocr_avail_sd &= ~MMC_VDD_165_195;
   766		mmc->ocr_avail_mmc = ocr_avail;
   767		if (host->ocr_avail_mmc)
   768			mmc->ocr_avail_mmc &= host->ocr_avail_mmc;
   769	
   770		if ((mmc->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
   771				  MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
   772				  MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR)) ||
   773		    (mmc->caps2 & (MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)))
   774			host->flags |= SDHCI_SIGNALING_180;
   775	
   776		spin_lock_init(&host->lock);
   777	
   778		/*
   779		 * Maximum number of sectors in one transfer. Limited by SDMA boundary
   780		 * size (512KiB). Note some tuning modes impose a 4MiB limit, but this
   781		 * is less anyway.
   782		 */
   783		mmc->max_req_size = 524288;
   784		/*
   785		 * Maximum number of segments. Depends on if the hardware
   786		 * can do scatter/gather or not.
   787		 */
   788		mmc->max_segs = 1;
   789		mmc->max_req_size = min_t(size_t, mmc->max_req_size,
   790					  dma_max_mapping_size(mmc_dev(mmc)));
   791	
   792		mmc->max_seg_size = mmc->max_req_size;
   793	
   794		mmc->max_blk_size = (host->caps & SDHCI_MAX_BLOCK_MASK) >>
   795				SDHCI_MAX_BLOCK_SHIFT;
   796	
   797		mmc->max_blk_size = 512 << mmc->max_blk_size;
   798	
   799		/*
   800		 * Maximum block count.
   801		 */
   802		mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
   803	
   804		if (mmc->max_segs == 1)
   805			/* This may alter mmc->*_blk_* parameters */
   806			// bst sdhci must reallocate bounce buffer
   807			bst_sdhci_allocate_bounce_buffer(host);
   808	
   809		return 0;
   810	
   811	undma:
   812		if (host->align_buffer)
   813			dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
   814					  host->adma_table_sz, host->align_buffer,
   815					  host->align_addr);
   816		host->adma_table = NULL;
   817		host->align_buffer = NULL;
   818	
   819		return ret;
   820	}
   821	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
