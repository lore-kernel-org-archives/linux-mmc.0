Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41751B65C
	for <linux-mmc@vger.kernel.org>; Mon,  2 Jun 2025 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846904; cv=none; b=r0YSz3C13Sh8tdxFAY8GQGjSbsG8U7w6eR+Mpd2TYoTGXSLCEmCOdxzg05hx6QXOI1alFz4nv1yjIAQKLNi3/A1x4cb8qsqkB3z4wtNBs+Oy/80hdyf9B5v5NlaPgOnYB6a4Z+/3SA3YliT+scugKvjuaw29Ll+Y47CLj+Lqn8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846904; c=relaxed/simple;
	bh=vKIZimpTaaE4qOmtV3rnMnKdHaGiSnz5hcrtealLAlA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q6fP7UliqiPRYxSdkYgvB1cJA7rv4EedHZCrRTaDZr3De6OuOt6hkkuQMx7GGD1wTM8UrVyBld5wvxsES6SrpN+Dl0tAJ1AxFSMPPB6PfgyIwSOEWLCIp8C+2VoFhbkaI/4+1O0/CTDOrQfE+VJOvEZXKvibkghImxLCB2luBYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d4T8wG0H; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4T8wG0H"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450caff6336so22818265e9.3
        for <linux-mmc@vger.kernel.org>; Sun, 01 Jun 2025 23:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748846900; x=1749451700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UGYcGfMDZ2DmHAoNlC5WwvnZH/3MHq1zzxTB0uBni8s=;
        b=d4T8wG0HZquvgCxIcPyPsbq2tqzEi148GM5VPeoFwnC30bY300kY0M1d9B4SoKHVpy
         0tCCgVT/2KZ5J5zkeNL303yVMesKLfnT4BvszdS1dDWz44pG/0WDZVUMK//7SdS20Wj7
         4p5brQoosTkG1r2IdfPZdGswGjoN2brCtXot0am8lk3s28Ny/igKNn++EC5QDMRuR5nf
         JZCiSxTFz1Hf0yFe4dYekQGoWKZT6TTKt/X2LC4ki5FWotVhHg8Ah+EUJo7EiC+D2zU1
         vUIQB5Ii/zx9VmCSVALXzRd9OuiSuS8z+OzPc3bFxdh9PSDGBNPrR81Tfo8Cl4nJXowZ
         of8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748846900; x=1749451700;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGYcGfMDZ2DmHAoNlC5WwvnZH/3MHq1zzxTB0uBni8s=;
        b=Khh80ACFj1BV8kVSAxPepOSOUQJnQWskFxgjXObSEtxeB4g4KTeq1wBoaYVnDRdbfH
         suOqzVWdd12mzoeHGoVfi2EFfyRJk2jQQs4hpbct2E5KUl5aCe6+iX/DT5C/HylLgO5F
         0IlZs9MchQIKW633NPW3McK/B36lJAV/8MKl9I8OdQbXvaC7I7gpW9zXOMmNl1UnP+uh
         MhsE/juaGaUHwm2VWCvHpFep1P7jviCbLY/px36qG2kVDb9FwDXRjOjesXkWJQ3gOtFc
         QPC8jozxwivdqUn9pNWU14PvWMAj3ZANCD7VX6W07KWnQB4I+oILfO5XSNFAMKofD8Yj
         ADew==
X-Forwarded-Encrypted: i=1; AJvYcCUIjEOWCrL3jzW8UYmxT6yy8ICHnB/o1/GXOKqRO7CCU6wi4sAoWo+dlgozYmmCtCx55GuWd4DJUS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Mx0Jp7dpIxBCKrquTgBph5wq5oYM596APnk1/lJYgAL8/16z
	8sYDpVcTapMIWqoWzFrrPVbnS2YUb3K656f4+CwfM4zwDLHVPu7xLbR2VVtT26Uts54=
X-Gm-Gg: ASbGncuriBL7LMKoHnFIjgcRDP9QLPYyIjQS/4HTEVzjd6OPRsFcBvq6ijaQwo+j3yY
	R0sq2v8kIePDf2XYhHI8BGNNnVWJPwQLcNco1mIYGY/5vkAxmpPQxyesuXXihIpBQnx7ZHzMBzO
	Jk/MXn4o2N6QNXtku4a4th/QPNay5yY430flMt2LSsPsINmLN6YBXfBlfQOJ6uLhB7IkWsbYj5d
	2Zali2Cq8kU61K9LTsT1Gw/UjjPR/pxbY6j878HS8Os3dqEmou7AuBWBYLkeJVcZF8zOj+CfQGK
	Q1QCiLpo7ThGPfp7RMuQDpJD/lG5HY6v/pejQ4aJcU+oCRLz0ye3aGSNQpch1AntFQ==
X-Google-Smtp-Source: AGHT+IFqFO4rW3RSXfE/U6h/VokWGUsgcVzZ5j/9AyBTiFeKRO2EovFEcdOooegUPlhIVlnxD3azXg==
X-Received: by 2002:a05:6000:2289:b0:3a4:e8bc:5aa with SMTP id ffacd0b85a97d-3a4f89a5bc2mr8706782f8f.11.1748846900467;
        Sun, 01 Jun 2025 23:48:20 -0700 (PDT)
Received: from localhost ([41.210.143.146])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d7fc1adesm111519205e9.33.2025.06.01.23.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 23:48:19 -0700 (PDT)
Date: Mon, 2 Jun 2025 09:48:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Binbin Zhou <zhoubinbin@loongson.cn>,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Hu Ziji <huziji@marvell.com>
Subject: Re: [PATCH v2 32/35] mmc: sdhci-xenon: Drop the use of
 sdhci_pltfm_free()
Message-ID: <202505310526.Nh371Swn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b79920fa8bff8f7cf2f407863846446344d2eab7.1748515612.git.zhoubinbin@loongson.cn>

Hi Binbin,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Binbin-Zhou/mmc-sdhci-Use-devm_mmc_alloc_host-helper/20250529-212928
base:   d2c6acff6386f43ed307822454b970c831c48f1b
patch link:    https://lore.kernel.org/r/b79920fa8bff8f7cf2f407863846446344d2eab7.1748515612.git.zhoubinbin%40loongson.cn
patch subject: [PATCH v2 32/35] mmc: sdhci-xenon: Drop the use of sdhci_pltfm_free()
config: i386-randconfig-141-20250530 (https://download.01.org/0day-ci/archive/20250531/202505310526.Nh371Swn-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202505310526.Nh371Swn-lkp@intel.com/

smatch warnings:
drivers/mmc/host/sdhci-xenon.c:536 xenon_probe() error: uninitialized symbol 'err'.

vim +/err +536 drivers/mmc/host/sdhci-xenon.c

3a3748dba881ed Hu Ziji         2017-03-30  509  static int xenon_probe(struct platform_device *pdev)
3a3748dba881ed Hu Ziji         2017-03-30  510  {
3a3748dba881ed Hu Ziji         2017-03-30  511  	struct sdhci_pltfm_host *pltfm_host;
1542488031deed Marcin Wojtas   2020-12-04  512  	struct device *dev = &pdev->dev;
3a3748dba881ed Hu Ziji         2017-03-30  513  	struct sdhci_host *host;
bb16ea1742c8f3 Gregory CLEMENT 2017-10-02  514  	struct xenon_priv *priv;
3a3748dba881ed Hu Ziji         2017-03-30  515  	int err;
3a3748dba881ed Hu Ziji         2017-03-30  516  
3a3748dba881ed Hu Ziji         2017-03-30  517  	host = sdhci_pltfm_init(pdev, &sdhci_xenon_pdata,
3a3748dba881ed Hu Ziji         2017-03-30  518  				sizeof(struct xenon_priv));
3a3748dba881ed Hu Ziji         2017-03-30  519  	if (IS_ERR(host))
3a3748dba881ed Hu Ziji         2017-03-30  520  		return PTR_ERR(host);
3a3748dba881ed Hu Ziji         2017-03-30  521  
3a3748dba881ed Hu Ziji         2017-03-30  522  	pltfm_host = sdhci_priv(host);
bb16ea1742c8f3 Gregory CLEMENT 2017-10-02  523  	priv = sdhci_pltfm_priv(pltfm_host);
3a3748dba881ed Hu Ziji         2017-03-30  524  
f75fda3730728e Marcin Wojtas   2020-12-04  525  	priv->hw_version = (unsigned long)device_get_match_data(&pdev->dev);
f75fda3730728e Marcin Wojtas   2020-12-04  526  
3a3748dba881ed Hu Ziji         2017-03-30  527  	/*
3a3748dba881ed Hu Ziji         2017-03-30  528  	 * Link Xenon specific mmc_host_ops function,
3a3748dba881ed Hu Ziji         2017-03-30  529  	 * to replace standard ones in sdhci_ops.
3a3748dba881ed Hu Ziji         2017-03-30  530  	 */
3a3748dba881ed Hu Ziji         2017-03-30  531  	xenon_replace_mmc_host_ops(host);
3a3748dba881ed Hu Ziji         2017-03-30  532  
1542488031deed Marcin Wojtas   2020-12-04  533  	if (dev->of_node) {
3a3748dba881ed Hu Ziji         2017-03-30  534  		pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
3a3748dba881ed Hu Ziji         2017-03-30  535  		if (IS_ERR(pltfm_host->clk)) {
3a3748dba881ed Hu Ziji         2017-03-30 @536  			dev_err(&pdev->dev, "Failed to setup input clk: %d\n", err);
                                                                                                                               ^^^
Use %pe and pass pltfm_host->clk as the error code.

6773eb1cf68bcb Binbin Zhou     2025-05-29  537  			return PTR_ERR(pltfm_host->clk);
3a3748dba881ed Hu Ziji         2017-03-30  538  		}
3a3748dba881ed Hu Ziji         2017-03-30  539  		err = clk_prepare_enable(pltfm_host->clk);
3a3748dba881ed Hu Ziji         2017-03-30  540  		if (err)
6773eb1cf68bcb Binbin Zhou     2025-05-29  541  			return err;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

