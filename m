Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A7C4167B
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Dec 2022 17:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiL0RuU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Dec 2022 12:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiL0RuS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Dec 2022 12:50:18 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2921A1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Dec 2022 09:50:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m3so889065wmq.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Dec 2022 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7f0CdUXe8phT2kexAusIBnKBuWstxNOnBu3E9cI6oAw=;
        b=Q9sjBtEne7RjKn4hDm87PK/7ZG+eYBNLw9Wv6p8ORD/X4ZMGE00WqK/5RRwu9Ml5lk
         mk59HNlGK2PWEXyXq9ZyMrHIif2h7tBjd2i8Gfd5mA93mHHll16vwUI4/FIya6y68QmW
         tGwTikOjEtEmXsVEDDBjLH5NFniqHqBmFSXZZrPZpL3bpd9RJjafMQMGAiG7VtCfZJeu
         EWsp45l1oUERqLxPaHcnsaFUcEam1uc4psoX5rQu07/4Gpe4sZ7Vp6Dmi/0BFQ3rbtbE
         eyx+QROpP7b1hSow6o0SXDfTg0Fo/zK3i55W+9JuMaGiRlbT/dSLGvO/ETrXfMyIAcw5
         xCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7f0CdUXe8phT2kexAusIBnKBuWstxNOnBu3E9cI6oAw=;
        b=3GfpgasVb4JHUxMAG8qi0cn2DYEtYX+rThkcFdsofy5gOnBZ/POWpIdvdxIYlw2ItR
         xS2/AEbCUyU9Xe9pUiz6/TJW4SoKTYIrwuBmX2luAP965yVRMC8gm5UQWpWHxthTo8YG
         15C5eAmkLpoNGeyR2knwGRLUniBnPNu7DrvXqU6fQcgIWiWCRCH6COdzJJDPBAIwkSu8
         8RgPjPHGhqkJbQNvfXAo9CdDa6yKDYXYQEzpKZVzg0QLqkUhwJ3JXkzcBq5S+IzFRvm1
         zc4IVELSc7jnd2X9BvXBS6JIvIS+sTFGCBmIOTK9PQuByXXBsoZqd1EMuzlOyD1CrLkz
         4nmQ==
X-Gm-Message-State: AFqh2krzBuDaVmwRpNKQ+zx3KjiN2AdZsBGoPtwTjskYFIINB9kUnG2M
        kBY58DuAFpOaNdT2qH/chw4=
X-Google-Smtp-Source: AMrXdXtEFINalGZewRhoRzS8KM0N+ONevOn0UdkngxKVKJp6fU6iLO0GHdGRhrwQ9567YL6Sv8i6zQ==
X-Received: by 2002:a05:600c:5012:b0:3d3:5a4a:9103 with SMTP id n18-20020a05600c501200b003d35a4a9103mr15680308wmr.31.1672163416349;
        Tue, 27 Dec 2022 09:50:16 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id hg24-20020a05600c539800b003cf71b1f66csm17759245wmb.0.2022.12.27.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 09:50:15 -0800 (PST)
Date:   Tue, 27 Dec 2022 20:50:13 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, haibo.chen@nxp.com,
        ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        kgroeneveld@lenbrook.com, haibo.chen@nxp.com
Subject: Re: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD
 line auto tuning for SDIO device
Message-ID: <202212262324.SVvtUbT2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221112853.789675-4-haibo.chen@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/haibo-chen-nxp-com/fix-the-sdio-device-DATA-CMD-CRC-and-Timeout-issue-after-tuning/20221221-193033
patch link:    https://lore.kernel.org/r/20221221112853.789675-4-haibo.chen%40nxp.com
patch subject: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD line auto tuning for SDIO device
config: parisc-randconfig-m031-20221225
compiler: hppa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/mmc/host/sdhci-esdhc-imx.c:462 usdhc_auto_tuning_mode_sel_and_en() error: we previously assumed 'host->mmc->card' could be null (see line 462)

vim +462 drivers/mmc/host/sdhci-esdhc-imx.c

45334ee13858de Haibo Chen 2021-08-18  431  /* Enable the auto tuning circuit to check the CMD line and BUS line */
235cd41770bdcb Haibo Chen 2022-12-21  432  static inline void usdhc_auto_tuning_mode_sel_and_en(struct sdhci_host *host)
45334ee13858de Haibo Chen 2021-08-18  433  {
45334ee13858de Haibo Chen 2021-08-18  434  	u32 buswidth, auto_tune_buswidth;
235cd41770bdcb Haibo Chen 2022-12-21  435  	u32 reg;
45334ee13858de Haibo Chen 2021-08-18  436  
45334ee13858de Haibo Chen 2021-08-18  437  	buswidth = USDHC_GET_BUSWIDTH(readl(host->ioaddr + SDHCI_HOST_CONTROL));
45334ee13858de Haibo Chen 2021-08-18  438  
45334ee13858de Haibo Chen 2021-08-18  439  	switch (buswidth) {
45334ee13858de Haibo Chen 2021-08-18  440  	case ESDHC_CTRL_8BITBUS:
45334ee13858de Haibo Chen 2021-08-18  441  		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_8BIT_EN;
45334ee13858de Haibo Chen 2021-08-18  442  		break;
45334ee13858de Haibo Chen 2021-08-18  443  	case ESDHC_CTRL_4BITBUS:
45334ee13858de Haibo Chen 2021-08-18  444  		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_4BIT_EN;
45334ee13858de Haibo Chen 2021-08-18  445  		break;
45334ee13858de Haibo Chen 2021-08-18  446  	default:	/* 1BITBUS */
45334ee13858de Haibo Chen 2021-08-18  447  		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
45334ee13858de Haibo Chen 2021-08-18  448  		break;
45334ee13858de Haibo Chen 2021-08-18  449  	}
45334ee13858de Haibo Chen 2021-08-18  450  
e088d1496d45c2 Haibo Chen 2022-12-21  451  	/*
e088d1496d45c2 Haibo Chen 2022-12-21  452  	 * For USDHC, auto tuning circuit can not handle the async sdio
e088d1496d45c2 Haibo Chen 2022-12-21  453  	 * device interrupt correctly. When sdio device use 4 data lines,
e088d1496d45c2 Haibo Chen 2022-12-21  454  	 * async sdio interrupt will use the shared DAT[1], if enable auto
e088d1496d45c2 Haibo Chen 2022-12-21  455  	 * tuning circuit check these 4 data lines, include the DAT[1],
e088d1496d45c2 Haibo Chen 2022-12-21  456  	 * this circuit will detect this interrupt, take this as a data on
e088d1496d45c2 Haibo Chen 2022-12-21  457  	 * DAT[1], and adjust the delay cell wrongly.
e088d1496d45c2 Haibo Chen 2022-12-21  458  	 * This is the hardware design limitation, to avoid this, for sdio
e088d1496d45c2 Haibo Chen 2022-12-21  459  	 * device, config the auto tuning circuit only check DAT[0] and CMD
e088d1496d45c2 Haibo Chen 2022-12-21  460  	 * line.
e088d1496d45c2 Haibo Chen 2022-12-21  461  	 */
e088d1496d45c2 Haibo Chen 2022-12-21 @462  	if (!host->mmc->card && mmc_card_sdio(host->mmc->card))

Presumably the ! is a mistake?  mmc_card_sdio() dereferences
host->mmc->card.

e088d1496d45c2 Haibo Chen 2022-12-21  463  		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
e088d1496d45c2 Haibo Chen 2022-12-21  464  
45334ee13858de Haibo Chen 2021-08-18  465  	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
45334ee13858de Haibo Chen 2021-08-18  466  			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
45334ee13858de Haibo Chen 2021-08-18  467  			ESDHC_VEND_SPEC2);
235cd41770bdcb Haibo Chen 2022-12-21  468  
235cd41770bdcb Haibo Chen 2022-12-21  469  	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
235cd41770bdcb Haibo Chen 2022-12-21  470  	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
235cd41770bdcb Haibo Chen 2022-12-21  471  	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
45334ee13858de Haibo Chen 2021-08-18  472  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

