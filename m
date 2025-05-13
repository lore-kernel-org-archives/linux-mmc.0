Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7591A4F12;
	Tue, 13 May 2025 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747102197; cv=none; b=lRIZmdn4bmjKNKCm7A4OTAIkhBCZjPRS6fZpfhvvZQmCDtM+sRSh+I+kVWZ0cKrbMQ5nb0uxBZKyR8dzyWcnGzZfwOM6MbDCsQQzgbfEoI/V56WQ37PlnXbNuat+FevL+qKBCX3jUDUL/PVwGz+rnwlSuIAFAmtvRYeLkOjb+58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747102197; c=relaxed/simple;
	bh=jli27B/5jY90qrTVnL5B2hPffaX2OOJy3Y08w33Rh5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuN1kQ1lhNPiplEbd/L/jfkcqGuONW2jd0K9zXYGumPDxofO/Fz2kg2xfX/vTdMkRFE8UcTpRhHyi49NphpNVe5yx5NjWfk2+9PlhUG48fFBBjZU6yq16z3U7mRVW9Gf4NrWaE6BT1F0K+X3Fxhgh72DatQSNH2Ff6PpT0fpweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hp9k/4Ph; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hp9k/4Ph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747102195; x=1778638195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jli27B/5jY90qrTVnL5B2hPffaX2OOJy3Y08w33Rh5k=;
  b=hp9k/4PhH6ghE1rnd/ara5/AxElT6QQCUyO7gmtydZvIoTvJLDkD8vJU
   PTbx+BPAyNqFdfBL5kODfEvBX8+/WSOBg4UVTCp3hjIRu7rt157hfgY2W
   0GVFdb2ReIsCJ/2sxdGTUBkjocQPtb6QxSk8sgC5lmBghP4BIVYYyhXiJ
   zvOTfSHrBre94rQ0Brck8Wz79+2g05llqdyZS7exAdnFvxEwUjlAD+Jwn
   tneFra/yQll+OP64dHBJSJlRT/u4dw1sol6iL/veXFEOVePaudlmJXkbn
   gMAl9zsbBe76FSB8gY4tndiG+QZZ4HFJmmPMrklnsQeJ+H1uCJFL0xNYi
   g==;
X-CSE-ConnectionGUID: KGf8opHJRVedZndU3LAJBQ==
X-CSE-MsgGUID: JAsDETEUQEiObh63foGZsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59929229"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="59929229"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:09:55 -0700
X-CSE-ConnectionGUID: 4KmA8ZP2Q1Kxb+NIqTdIWA==
X-CSE-MsgGUID: 3YBxHFhgQvCuzV2Ed3pDKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="168642027"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 May 2025 19:09:51 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEf5Z-000FaV-2Y;
	Tue, 13 May 2025 02:09:49 +0000
Date: Tue, 13 May 2025 10:09:40 +0800
From: kernel test robot <lkp@intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev, devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mmc: loongson2: Add Loongson-2K SD/SDIO
 controller driver
Message-ID: <202505130918.uanOGxju-lkp@intel.com>
References: <1308b6ca9ffc2674cc0f089cfd163da87e53a8cd.1746581751.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1308b6ca9ffc2674cc0f089cfd163da87e53a8cd.1746581751.git.zhoubinbin@loongson.cn>

Hi Binbin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9e12816f9a6195f1f5b7c5dc2e388c2458411b97]

url:    https://github.com/intel-lab-lkp/linux/commits/Binbin-Zhou/dt-bindings-mmc-Add-Loongson-2K-SD-SDIO-eMMC-controller-binding/20250507-153435
base:   9e12816f9a6195f1f5b7c5dc2e388c2458411b97
patch link:    https://lore.kernel.org/r/1308b6ca9ffc2674cc0f089cfd163da87e53a8cd.1746581751.git.zhoubinbin%40loongson.cn
patch subject: [PATCH v2 2/4] mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
config: csky-randconfig-r112-20250513 (https://download.01.org/0day-ci/archive/20250513/202505130918.uanOGxju-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250513/202505130918.uanOGxju-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505130918.uanOGxju-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mmc/host/loongson2-mmc.c:534:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/mmc/host/loongson2-mmc.c:534:41: sparse:     expected unsigned int [usertype]
   drivers/mmc/host/loongson2-mmc.c:534:41: sparse:     got restricted __be32 [usertype]

vim +534 drivers/mmc/host/loongson2-mmc.c

   500	
   501	static int loongson2_reorder_cmd_list[] = { SD_APP_SEND_SCR, SD_APP_SEND_NUM_WR_BLKS,
   502						    SD_APP_SD_STATUS, MMC_SEND_WRITE_PROT,
   503						    SD_SWITCH };
   504	
   505	/*
   506	 * According to SD spec, ACMD13, ACMD22, ACMD51 and CMD30
   507	 * response datas has different byte order with usual data packets.
   508	 * However sdio controller will send these datas in usual data format,
   509	 * so we need to adjust these datas to a protocol consistent byte order.
   510	 */
   511	static void loongson2_mmc_reorder_cmd_data(struct loongson2_mmc_host *host,
   512						   struct mmc_command *cmd)
   513	{
   514		struct scatterlist *sg;
   515		u32 *data;
   516		int i, j;
   517	
   518		if (mmc_cmd_type(cmd) != MMC_CMD_ADTC)
   519			return;
   520	
   521		for (i = 0; i < ARRAY_SIZE(loongson2_reorder_cmd_list); i++)
   522			if (cmd->opcode == loongson2_reorder_cmd_list[i])
   523				break;
   524	
   525		if (i == ARRAY_SIZE(loongson2_reorder_cmd_list))
   526			return;
   527	
   528		for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
   529			data = sg_virt(&sg[i]);
   530			for (j = 0; j < (sg_dma_len(&sg[i]) / 4); j++)
   531				if (cmd->opcode == SD_SWITCH)
   532					data[j] = bitrev8x4(data[j]);
   533				else
 > 534					data[j] = cpu_to_be32(data[j]);
   535		}
   536	}
   537	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
