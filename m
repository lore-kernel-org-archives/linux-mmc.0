Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0EC3DA78
	for <linux-mmc@archiver.kernel.org>; Sat, 14 Jan 2023 08:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjANICM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 14 Jan 2023 03:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjANICL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Jan 2023 03:02:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404ED2104;
        Sat, 14 Jan 2023 00:02:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v2so11958404wrw.10;
        Sat, 14 Jan 2023 00:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySUOi8HQVQgZ3gY5yQW/rIsj+8KY7201qmZ9Y2W7p9o=;
        b=lCkbXhy0Jc0SB8JMFHmcuvZQ7fDAQUYkaYSyRbloHOXS+nyzPNSZufuatadEPqbnXS
         baFdUBBpdgFPBTtMag1LqZUE7CBd2fIg+fkwFd0QoM4kBuf7dZSeM1N22ZtcGEP7mmku
         Nhl3soOXTw0PMZRMd0HKDMt2xdjo4HyqELi1fmXAa3cqzkpXl0+pXyukRvCXIwDzaYDE
         zUQJermTdwQ44dTf5PEbosl6FXeUMbmukmXojKOLmLol4YbmH2fV8D+fB5v2T3LKaYs1
         JEa3imrOdSndA1PVLwidYyVlvhwL1e/icxZHHFeg36tkUO/eCQ4AZfx2uX07veNuYAXR
         44Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySUOi8HQVQgZ3gY5yQW/rIsj+8KY7201qmZ9Y2W7p9o=;
        b=oc6Goyr4Kwz8ZMMAcj2SUZTUcIBdTSivI3fGhyrfvcZR8kS6h4MMLpN7VnWvLndDUo
         IU98bcv8OGkJMuxZTCE6Zyl8CNJsEb+CbjSeYLzu3f1TPLvX27QGYlcGJD6JxUodCt/+
         6pUapOWUkAHLuK/kqc5YLIv0TrUYyOUidRgkJG7ffV9qGSKzJIDqNVBi216dLd9Fslom
         KyMM9NXMKM/iN6iYpXRcrKVC/uSPyfWfR7xs29YCRjrYbxLf76Yk/47Mb7sK+AZTshnh
         2Wc3eBozp1ECVlP4gBfCZPZlDKxbbCqq/R5F+bcgNJiTCUFYPBQpbpxRnr2x+Rd1xEg4
         TmSg==
X-Gm-Message-State: AFqh2koLm3HAODexmFqNq4PxnhOtnVIua3cFuG5K766n5vWhL/xTX249
        P49tBteT8Dqq57/u3zBRt/A=
X-Google-Smtp-Source: AMrXdXs5XfBthFdwA04j0BNqT9jCJxgCA6SyreY/jbTi3614mIWhdIZWM4ooIC6l/DEaRl7Mk3l3JA==
X-Received: by 2002:adf:e709:0:b0:2bd:d34e:534d with SMTP id c9-20020adfe709000000b002bdd34e534dmr6150561wrm.27.1673683328588;
        Sat, 14 Jan 2023 00:02:08 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d4091000000b0028965dc7c6bsm20536647wrp.73.2023.01.14.00.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 00:02:08 -0800 (PST)
Date:   Sat, 14 Jan 2023 11:01:54 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Doug Brown <doug@schmorgal.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v4 5/8] mmc: sdhci-pxav2: add optional core clock
Message-ID: <202301140445.zXxR25qN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112022416.8474-6-doug@schmorgal.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Doug,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Doug-Brown/mmc-sdhci-pxav2-add-initial-support-for-PXA168-V1-controller/20230112-102921
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230112022416.8474-6-doug%40schmorgal.com
patch subject: [PATCH v4 5/8] mmc: sdhci-pxav2: add optional core clock
config: riscv-randconfig-m041-20230113
compiler: riscv64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/mmc/host/sdhci-pxav2.c:220 sdhci_pxav2_probe() warn: missing error code 'ret'

vim +/ret +220 drivers/mmc/host/sdhci-pxav2.c

c3be1efd41a97f Bill Pemberton        2012-11-19  185  static int sdhci_pxav2_probe(struct platform_device *pdev)
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  186  {
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  187  	struct sdhci_pltfm_host *pltfm_host;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  188  	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  189  	struct device *dev = &pdev->dev;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  190  	struct sdhci_host *host = NULL;
568536d7eb1969 Doug Brown            2023-01-11  191  	const struct sdhci_pxa_variant *variant;
b650352dd3df36 Chris Ball            2012-04-10  192  
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  193  	int ret;
d8981da5ec7505 Doug Brown            2023-01-11  194  	struct clk *clk, *clk_core;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  195  
0e748234293f5f Christian Daudt       2013-05-29  196  	host = sdhci_pltfm_init(pdev, NULL, 0);
6a686c31324c9e Sebastian Hesselbarth 2014-10-21  197  	if (IS_ERR(host))
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  198  		return PTR_ERR(host);
6a686c31324c9e Sebastian Hesselbarth 2014-10-21  199  
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  200  	pltfm_host = sdhci_priv(host);
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  201  
edf4ccd94bbef1 Doug Brown            2023-01-11  202  	clk = devm_clk_get(dev, "io");
edf4ccd94bbef1 Doug Brown            2023-01-11  203  	if (IS_ERR(clk) && PTR_ERR(clk) != -EPROBE_DEFER)
edf4ccd94bbef1 Doug Brown            2023-01-11  204  		clk = devm_clk_get(dev, NULL);
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  205  	if (IS_ERR(clk)) {
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  206  		ret = PTR_ERR(clk);
edf4ccd94bbef1 Doug Brown            2023-01-11  207  		dev_err_probe(dev, ret, "failed to get io clock\n");
3fd1d86f03cbcc Masahiro Yamada       2017-08-23  208  		goto free;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  209  	}
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  210  	pltfm_host->clk = clk;
21b22284619bbb Alexey Khoroshilov    2017-02-11  211  	ret = clk_prepare_enable(clk);
21b22284619bbb Alexey Khoroshilov    2017-02-11  212  	if (ret) {
edf4ccd94bbef1 Doug Brown            2023-01-11  213  		dev_err(dev, "failed to enable io clock\n");
3fd1d86f03cbcc Masahiro Yamada       2017-08-23  214  		goto free;
21b22284619bbb Alexey Khoroshilov    2017-02-11  215  	}
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  216  
d8981da5ec7505 Doug Brown            2023-01-11  217  	clk_core = devm_clk_get_optional_enabled(dev, "core");
d8981da5ec7505 Doug Brown            2023-01-11  218  	if (IS_ERR(clk_core)) {
d8981da5ec7505 Doug Brown            2023-01-11  219  		dev_err_probe(dev, PTR_ERR(clk_core), "failed to enable core clock\n");
d8981da5ec7505 Doug Brown            2023-01-11 @220  		goto disable_clk;

ret = PTR_ERR(clk_core);

d8981da5ec7505 Doug Brown            2023-01-11  221  	}
d8981da5ec7505 Doug Brown            2023-01-11  222  
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  223  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  224  		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  225  		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  226  
568536d7eb1969 Doug Brown            2023-01-11  227  	variant = of_device_get_match_data(dev);
568536d7eb1969 Doug Brown            2023-01-11  228  	if (variant)
b650352dd3df36 Chris Ball            2012-04-10  229  		pdata = pxav2_get_mmc_pdata(dev);
568536d7eb1969 Doug Brown            2023-01-11  230  	else
568536d7eb1969 Doug Brown            2023-01-11  231  		variant = &pxav2_variant;
568536d7eb1969 Doug Brown            2023-01-11  232  
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  233  	if (pdata) {
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  234  		if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  235  			/* on-chip device */
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  236  			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  237  			host->mmc->caps |= MMC_CAP_NONREMOVABLE;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  238  		}
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  239  
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  240  		/* If slot design supports 8 bit data, indicate this to MMC. */
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  241  		if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  242  			host->mmc->caps |= MMC_CAP_8_BIT_DATA;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  243  
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  244  		if (pdata->quirks)
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  245  			host->quirks |= pdata->quirks;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  246  		if (pdata->host_caps)
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  247  			host->mmc->caps |= pdata->host_caps;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  248  		if (pdata->pm_caps)
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  249  			host->mmc->pm_caps |= pdata->pm_caps;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  250  	}
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  251  
568536d7eb1969 Doug Brown            2023-01-11  252  	host->quirks |= variant->extra_quirks;
568536d7eb1969 Doug Brown            2023-01-11  253  	host->ops = variant->ops;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  254  
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  255  	ret = sdhci_add_host(host);
fb8617e1ee4d40 Jisheng Zhang         2018-05-25  256  	if (ret)
3fd1d86f03cbcc Masahiro Yamada       2017-08-23  257  		goto disable_clk;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  258  
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  259  	return 0;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  260  
3fd1d86f03cbcc Masahiro Yamada       2017-08-23  261  disable_clk:
164378efe7612a Chao Xie              2012-07-31  262  	clk_disable_unprepare(clk);
3fd1d86f03cbcc Masahiro Yamada       2017-08-23  263  free:
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  264  	sdhci_pltfm_free(pdev);
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  265  	return ret;
9f5d71e4a78a02 Zhangfei Gao          2011-06-08  266  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

