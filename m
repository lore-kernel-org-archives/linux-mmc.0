Received: from mail-m15578.qiye.163.com (mail-m15578.qiye.163.com [101.71.155.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334D19EED3;
	Fri, 23 Jan 2026 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156417; cv=none; b=MQrH9B3y5+ZXjNhNWQinUXQQGDrFjc4ExlFaEjb23fM7f/6hPr9gPYq2MGNItBxP7IIDjTLZwzlWNdBbJXsWdCdSudV0ngpsb3Y68W6JUd8ro6dCSXRQrwTpwSUsc7Q4mq83y/ypwWBOW1fU+agNPGegevxYSzOowLWG4Z6qbM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156417; c=relaxed/simple;
	bh=IYCmvBsbmv3kbUzepTmrDx9V8IbGtZjrChe2Iob6zcM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LOFtRJkOjNLgu+JMHzPuCk8YqDUUZrOfMnbdWmbeIEjaWWIm6vopk/cgZXOz8wRtGrAJZACJ0NLlxGZcDanUta3MeRjE8GgCJNFTfvun3iN6MD5Ibc4GAjPIPxDiVgVbHo/QhJv1+O/xrJEJAM76Gi2Y7G39+UWv3UD91tCTr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RXAH0D89; arc=none smtp.client-ip=101.71.155.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RXAH0D89"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31b860454;
	Fri, 23 Jan 2026 16:14:55 +0800 (GMT+08:00)
Message-ID: <1c275ed9-70ee-4eba-b3d5-0f0c19a3a2d1@rock-chips.com>
Date: Fri, 23 Jan 2026 16:14:54 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, oe-kbuild-all@lists.linux.dev,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] mmc: dw_mmc-k3: Remove mshc alias support
To: kernel test robot <lkp@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Wei Xu <xuwei5@hisilicon.com>
References: <1769132482-177365-2-git-send-email-shawn.lin@rock-chips.com>
 <202601231543.IzsYNOzJ-lkp@intel.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <202601231543.IzsYNOzJ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be9ebaeb309cckunmd7e25a7d1ac2f7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpNQ1ZDTEtNGEhJTEIZT0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RXAH0D89cH6q4GBkk69sDDStWYj96MI9ROl/xzkurdP1fq3lqI96TU1NMhbcS6teqcUJn7+YeG5v2+7V/bEmEn770Mup6IywksNpKXjV0hGBB4sk2kWxJg5uWp3xQ67LDK30F5xAHbJ/FfbwWPH/gVm4VSQB/xtZtSX/74qCj30=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=7ak2ukuGBc+Ys62uKbyQTY4W4bSjYwRQNwZcxuDSuWU=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/23 星期五 15:59, kernel test robot 写道:
> Hi Shawn,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on robh/for-next]
> [also build test WARNING on linus/master ulf-hansson-mmc-mirror/next v6.19-rc6 next-20260122]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/mmc-dw_mmc-k3-Remove-mshc-alias-support/20260123-095950
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/1769132482-177365-2-git-send-email-shawn.lin%40rock-chips.com
> patch subject: [PATCH 1/3] mmc: dw_mmc-k3: Remove mshc alias support
> config: arc-randconfig-002-20260123 (https://download.01.org/0day-ci/archive/20260123/202601231543.IzsYNOzJ-lkp@intel.com/config)
> compiler: arc-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260123/202601231543.IzsYNOzJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601231543.IzsYNOzJ-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/mmc/host/dw_mmc-k3.c: In function 'dw_mci_hs_set_timing':
>     drivers/mmc/host/dw_mmc-k3.c:220:16: error: 'struct dw_mci' has no member named 'mmc'

I think this is a false-positive warning as it's based on latest
linux-next tree.

>       ctrl_id = host->mmc->index;
>                     ^~
>>> drivers/mmc/host/dw_mmc-k3.c:217:18: warning: variable 'priv' set but not used [-Wunused-but-set-variable]
>       struct k3_priv *priv;
>                       ^~~~

But this one is indeed a valid warning, will fix.

Thanks, lkp.

> 
> 
> vim +/priv +217 drivers/mmc/host/dw_mmc-k3.c
> 
> 0293efddaddfcb Zhangfei Gao        2015-05-14  207
> d53e39b1131c08 Shawn Lin           2026-01-23  208  static int dw_mci_hs_set_timing(struct dw_mci *host, int timing,
> 361c7fe9b02eee liwei               2017-08-11  209  				     int smpl_phase)
> 361c7fe9b02eee liwei               2017-08-11  210  {
> 361c7fe9b02eee liwei               2017-08-11  211  	u32 drv_phase;
> 361c7fe9b02eee liwei               2017-08-11  212  	u32 smpl_dly;
> 361c7fe9b02eee liwei               2017-08-11  213  	u32 use_smpl_dly = 0;
> 361c7fe9b02eee liwei               2017-08-11  214  	u32 enable_shift = 0;
> 361c7fe9b02eee liwei               2017-08-11  215  	u32 reg_value;
> 361c7fe9b02eee liwei               2017-08-11  216  	int ctrl_id;
> 361c7fe9b02eee liwei               2017-08-11 @217  	struct k3_priv *priv;
> 361c7fe9b02eee liwei               2017-08-11  218
> 361c7fe9b02eee liwei               2017-08-11  219  	priv = host->priv;
> d53e39b1131c08 Shawn Lin           2026-01-23 @220  	ctrl_id = host->mmc->index;
> d53e39b1131c08 Shawn Lin           2026-01-23  221
> d53e39b1131c08 Shawn Lin           2026-01-23  222  	if (ctrl_id >= TIMING_MODE)
> d53e39b1131c08 Shawn Lin           2026-01-23  223  		return -EINVAL;
> 361c7fe9b02eee liwei               2017-08-11  224
> 361c7fe9b02eee liwei               2017-08-11  225  	drv_phase = hs_timing_cfg[ctrl_id][timing].drv_phase;
> 361c7fe9b02eee liwei               2017-08-11  226  	smpl_dly   = hs_timing_cfg[ctrl_id][timing].smpl_dly;
> 361c7fe9b02eee liwei               2017-08-11  227  	if (smpl_phase == -1)
> 361c7fe9b02eee liwei               2017-08-11  228  		smpl_phase = (hs_timing_cfg[ctrl_id][timing].smpl_phase_max +
> 361c7fe9b02eee liwei               2017-08-11  229  			     hs_timing_cfg[ctrl_id][timing].smpl_phase_min) / 2;
> 361c7fe9b02eee liwei               2017-08-11  230
> 361c7fe9b02eee liwei               2017-08-11  231  	switch (timing) {
> 361c7fe9b02eee liwei               2017-08-11  232  	case MMC_TIMING_UHS_SDR104:
> 361c7fe9b02eee liwei               2017-08-11  233  		if (smpl_phase >= USE_DLY_MIN_SMPL &&
> 361c7fe9b02eee liwei               2017-08-11  234  				smpl_phase <= USE_DLY_MAX_SMPL)
> 361c7fe9b02eee liwei               2017-08-11  235  			use_smpl_dly = 1;
> df561f6688fef7 Gustavo A. R. Silva 2020-08-23  236  		fallthrough;
> 361c7fe9b02eee liwei               2017-08-11  237  	case MMC_TIMING_UHS_SDR50:
> 361c7fe9b02eee liwei               2017-08-11  238  		if (smpl_phase >= ENABLE_SHIFT_MIN_SMPL &&
> 361c7fe9b02eee liwei               2017-08-11  239  				smpl_phase <= ENABLE_SHIFT_MAX_SMPL)
> 361c7fe9b02eee liwei               2017-08-11  240  			enable_shift = 1;
> 361c7fe9b02eee liwei               2017-08-11  241  		break;
> 361c7fe9b02eee liwei               2017-08-11  242  	}
> 361c7fe9b02eee liwei               2017-08-11  243
> 361c7fe9b02eee liwei               2017-08-11  244  	mci_writel(host, GPIO, 0x0);
> 361c7fe9b02eee liwei               2017-08-11  245  	usleep_range(5, 10);
> 361c7fe9b02eee liwei               2017-08-11  246
> 361c7fe9b02eee liwei               2017-08-11  247  	reg_value = FIELD_PREP(UHS_REG_EXT_SAMPLE_PHASE_MASK, smpl_phase) |
> 361c7fe9b02eee liwei               2017-08-11  248  		    FIELD_PREP(UHS_REG_EXT_SAMPLE_DLY_MASK, smpl_dly) |
> 361c7fe9b02eee liwei               2017-08-11  249  		    FIELD_PREP(UHS_REG_EXT_SAMPLE_DRVPHASE_MASK, drv_phase);
> 361c7fe9b02eee liwei               2017-08-11  250  	mci_writel(host, UHS_REG_EXT, reg_value);
> 361c7fe9b02eee liwei               2017-08-11  251
> 361c7fe9b02eee liwei               2017-08-11  252  	mci_writel(host, ENABLE_SHIFT, enable_shift);
> 361c7fe9b02eee liwei               2017-08-11  253
> 361c7fe9b02eee liwei               2017-08-11  254  	reg_value = FIELD_PREP(GPIO_CLK_DIV_MASK, GENCLK_DIV) |
> 361c7fe9b02eee liwei               2017-08-11  255  			     FIELD_PREP(GPIO_USE_SAMPLE_DLY_MASK, use_smpl_dly);
> 361c7fe9b02eee liwei               2017-08-11  256  	mci_writel(host, GPIO, (unsigned int)reg_value | GPIO_CLK_ENABLE);
> 361c7fe9b02eee liwei               2017-08-11  257
> 361c7fe9b02eee liwei               2017-08-11  258  	/* We should delay 1ms wait for timing setting finished. */
> 361c7fe9b02eee liwei               2017-08-11  259  	usleep_range(1000, 2000);
> d53e39b1131c08 Shawn Lin           2026-01-23  260
> d53e39b1131c08 Shawn Lin           2026-01-23  261  	return 0;
> 361c7fe9b02eee liwei               2017-08-11  262  }
> 361c7fe9b02eee liwei               2017-08-11  263
> 

