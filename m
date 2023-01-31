Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A13C636CC
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Jan 2023 15:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjAaPXD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjAaPWf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2023 10:22:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DF016319
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2023 07:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675178460; x=1706714460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTMbZh7C8vZ3JVoDbyzthPDYC+3CGqqgiZ08u3h8Cl8=;
  b=DuQVwLfX+5rDhEUqYZkpa8Ztd8uaoKwVdxG3xL7cr1sgxfL19gGH26Xv
   Yyj/4nWl2xf7IbB0gXHLZ8zf7zTejn/rG6jNMObLFBM6LHu2CsMQfpgIx
   jg5hYQsgwzR/uYwmY1/WiMOQAcIC41fiFjT55ZgBcpkrwmbSG91h+x77b
   7yFil3wnZVTJ0ZKsoT7uk/rSOS7OE6fM3f7WcCL/jYCF42ARaV+FP+R6S
   EQZ7mrM9WmDt3ul7GUupGQrzYf24zV6RSSnGEvIU9XqFyfr3+4HApAyO9
   dAwZiYAvrwtmRMQEEHS8KVe87nO0s5xmvsbVlUJ4UklWTB+nyYiBCMRYa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="326527368"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="326527368"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 07:21:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="664524930"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="664524930"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2023 07:20:57 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMsRM-0004V4-2T;
        Tue, 31 Jan 2023 15:20:56 +0000
Date:   Tue, 31 Jan 2023 23:20:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-of-dwcmshc: Add host software queue
 support
Message-ID: <202301312350.1e3cuVCa-lkp@intel.com>
References: <1675125991-189452-4-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675125991-189452-4-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Shawn,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.2-rc6 next-20230131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/mmc-sdhci-of-dwcmshc-Update-DLL-and-pre-change-delay-for-rockchip-platform/20230131-084738
patch link:    https://lore.kernel.org/r/1675125991-189452-4-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH v2 3/3] mmc: sdhci-of-dwcmshc: Add host software queue support
config: nios2-randconfig-r016-20230130 (https://download.01.org/0day-ci/archive/20230131/202301312350.1e3cuVCa-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/73576aaa2a9d56edd98c4259a33d4896677bb211
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shawn-Lin/mmc-sdhci-of-dwcmshc-Update-DLL-and-pre-change-delay-for-rockchip-platform/20230131-084738
        git checkout 73576aaa2a9d56edd98c4259a33d4896677bb211
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/mmc/host/sdhci-of-dwcmshc.o: in function `sdhci_dwcmshc_request_done':
>> drivers/mmc/host/sdhci-of-dwcmshc.c:337: undefined reference to `mmc_hsq_finalize_request'
   drivers/mmc/host/sdhci-of-dwcmshc.c:337:(.text+0x144): relocation truncated to fit: R_NIOS2_CALL26 against `mmc_hsq_finalize_request'
   nios2-linux-ld: drivers/mmc/host/sdhci-of-dwcmshc.o: in function `dwcmshc_probe':
>> drivers/mmc/host/sdhci-of-dwcmshc.c:535: undefined reference to `mmc_hsq_init'
   drivers/mmc/host/sdhci-of-dwcmshc.c:535:(.text+0x8fc): relocation truncated to fit: R_NIOS2_CALL26 against `mmc_hsq_init'


vim +337 drivers/mmc/host/sdhci-of-dwcmshc.c

   334	
   335	static void sdhci_dwcmshc_request_done(struct sdhci_host *host, struct mmc_request *mrq)
   336	{
 > 337		if (mmc_hsq_finalize_request(host->mmc, mrq))
   338			return;
   339	
   340		mmc_request_done(host->mmc, mrq);
   341	}
   342	
   343	static const struct sdhci_ops sdhci_dwcmshc_ops = {
   344		.set_clock		= sdhci_set_clock,
   345		.set_bus_width		= sdhci_set_bus_width,
   346		.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
   347		.get_max_clock		= dwcmshc_get_max_clock,
   348		.reset			= sdhci_reset,
   349		.adma_write_desc	= dwcmshc_adma_write_desc,
   350	};
   351	
   352	static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
   353		.set_clock		= dwcmshc_rk3568_set_clock,
   354		.set_bus_width		= sdhci_set_bus_width,
   355		.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
   356		.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
   357		.reset			= rk35xx_sdhci_reset,
   358		.adma_write_desc	= dwcmshc_adma_write_desc,
   359		.request_done		= sdhci_dwcmshc_request_done,
   360	};
   361	
   362	static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
   363		.ops = &sdhci_dwcmshc_ops,
   364		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
   365		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
   366	};
   367	
   368	#ifdef CONFIG_ACPI
   369	static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
   370		.ops = &sdhci_dwcmshc_ops,
   371		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
   372		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
   373			   SDHCI_QUIRK2_ACMD23_BROKEN,
   374	};
   375	#endif
   376	
   377	static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
   378		.ops = &sdhci_dwcmshc_rk35xx_ops,
   379		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
   380			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
   381		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
   382			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
   383	};
   384	
   385	static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
   386	{
   387		int err;
   388		struct rk35xx_priv *priv = dwc_priv->priv;
   389	
   390		priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
   391		if (IS_ERR(priv->reset)) {
   392			err = PTR_ERR(priv->reset);
   393			dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
   394			return err;
   395		}
   396	
   397		priv->rockchip_clks[0].id = "axi";
   398		priv->rockchip_clks[1].id = "block";
   399		priv->rockchip_clks[2].id = "timer";
   400		err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK35xx_MAX_CLKS,
   401						 priv->rockchip_clks);
   402		if (err) {
   403			dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
   404			return err;
   405		}
   406	
   407		err = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
   408		if (err) {
   409			dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
   410			return err;
   411		}
   412	
   413		if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
   414					&priv->txclk_tapnum))
   415			priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
   416	
   417		/* Disable cmd conflict check */
   418		sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
   419		/* Reset previous settings */
   420		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
   421		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
   422	
   423		return 0;
   424	}
   425	
   426	static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
   427	{
   428		/*
   429		 * Don't support highspeed bus mode with low clk speed as we
   430		 * cannot use DLL for this condition.
   431		 */
   432		if (host->mmc->f_max <= 52000000) {
   433			dev_info(mmc_dev(host->mmc), "Disabling HS200/HS400, frequency too low (%d)\n",
   434				 host->mmc->f_max);
   435			host->mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
   436			host->mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR);
   437		}
   438	}
   439	
   440	static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
   441		{
   442			.compatible = "rockchip,rk3588-dwcmshc",
   443			.data = &sdhci_dwcmshc_rk35xx_pdata,
   444		},
   445		{
   446			.compatible = "rockchip,rk3568-dwcmshc",
   447			.data = &sdhci_dwcmshc_rk35xx_pdata,
   448		},
   449		{
   450			.compatible = "snps,dwcmshc-sdhci",
   451			.data = &sdhci_dwcmshc_pdata,
   452		},
   453		{},
   454	};
   455	MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
   456	
   457	#ifdef CONFIG_ACPI
   458	static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
   459		{
   460			.id = "MLNXBF30",
   461			.driver_data = (kernel_ulong_t)&sdhci_dwcmshc_bf3_pdata,
   462		},
   463		{}
   464	};
   465	#endif
   466	
   467	static int dwcmshc_probe(struct platform_device *pdev)
   468	{
   469		struct device *dev = &pdev->dev;
   470		struct sdhci_pltfm_host *pltfm_host;
   471		struct sdhci_host *host;
   472		struct dwcmshc_priv *priv;
   473		struct rk35xx_priv *rk_priv = NULL;
   474		const struct sdhci_pltfm_data *pltfm_data;
   475		struct mmc_hsq *hsq;
   476		int err;
   477		u32 extra;
   478	
   479		pltfm_data = device_get_match_data(&pdev->dev);
   480		if (!pltfm_data) {
   481			dev_err(&pdev->dev, "Error: No device match data found\n");
   482			return -ENODEV;
   483		}
   484	
   485		host = sdhci_pltfm_init(pdev, pltfm_data,
   486					sizeof(struct dwcmshc_priv));
   487		if (IS_ERR(host))
   488			return PTR_ERR(host);
   489	
   490		/*
   491		 * extra adma table cnt for cross 128M boundary handling.
   492		 */
   493		extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
   494		if (extra > SDHCI_MAX_SEGS)
   495			extra = SDHCI_MAX_SEGS;
   496		host->adma_table_cnt += extra;
   497	
   498		pltfm_host = sdhci_priv(host);
   499		priv = sdhci_pltfm_priv(pltfm_host);
   500	
   501		if (dev->of_node) {
   502			pltfm_host->clk = devm_clk_get(dev, "core");
   503			if (IS_ERR(pltfm_host->clk)) {
   504				err = PTR_ERR(pltfm_host->clk);
   505				dev_err(dev, "failed to get core clk: %d\n", err);
   506				goto free_pltfm;
   507			}
   508			err = clk_prepare_enable(pltfm_host->clk);
   509			if (err)
   510				goto free_pltfm;
   511	
   512			priv->bus_clk = devm_clk_get(dev, "bus");
   513			if (!IS_ERR(priv->bus_clk))
   514				clk_prepare_enable(priv->bus_clk);
   515		}
   516	
   517		err = mmc_of_parse(host->mmc);
   518		if (err)
   519			goto err_clk;
   520	
   521		sdhci_get_of_property(pdev);
   522	
   523		priv->vendor_specific_area1 =
   524			sdhci_readl(host, DWCMSHC_P_VENDOR_AREA1) & DWCMSHC_AREA1_MASK;
   525	
   526		host->mmc_host_ops.request = dwcmshc_request;
   527		host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
   528	
   529		hsq = devm_kzalloc(&pdev->dev, sizeof(*hsq), GFP_KERNEL);
   530		if (!hsq) {
   531			err = -ENOMEM;
   532			goto err_clk;
   533		}
   534	
 > 535		err = mmc_hsq_init(hsq, host->mmc);
   536		if (err)
   537			goto err_clk;
   538	
   539		if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
   540			rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
   541			if (!rk_priv) {
   542				err = -ENOMEM;
   543				goto err_clk;
   544			}
   545	
   546			if (of_device_is_compatible(pdev->dev.of_node, "rockchip,rk3588-dwcmshc"))
   547				rk_priv->devtype = DWCMSHC_RK3588;
   548			else
   549				rk_priv->devtype = DWCMSHC_RK3568;
   550	
   551			priv->priv = rk_priv;
   552	
   553			err = dwcmshc_rk35xx_init(host, priv);
   554			if (err)
   555				goto err_clk;
   556		}
   557	
   558		host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
   559	
   560		err = sdhci_setup_host(host);
   561		if (err)
   562			goto err_clk;
   563	
   564		if (rk_priv)
   565			dwcmshc_rk35xx_postinit(host, priv);
   566	
   567		err = __sdhci_add_host(host);
   568		if (err)
   569			goto err_setup_host;
   570	
   571		pm_runtime_get_noresume(&pdev->dev);
   572		pm_runtime_set_active(&pdev->dev);
   573		pm_runtime_enable(&pdev->dev);
   574		pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
   575		pm_runtime_use_autosuspend(&pdev->dev);
   576		pm_runtime_put_autosuspend(&pdev->dev);
   577	
   578		return 0;
   579	
   580	err_setup_host:
   581		sdhci_cleanup_host(host);
   582	err_clk:
   583		clk_disable_unprepare(pltfm_host->clk);
   584		clk_disable_unprepare(priv->bus_clk);
   585		if (rk_priv)
   586			clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
   587						   rk_priv->rockchip_clks);
   588	free_pltfm:
   589		sdhci_pltfm_free(pdev);
   590		return err;
   591	}
   592	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
