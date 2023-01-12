Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5241C54EBC
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Jan 2023 02:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbjALCYn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjALCYl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2023 21:24:41 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C0544C4A
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:24:39 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso19286199pjo.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2023 18:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TE7kbIUfLw4QNwKVfaDIb623jjzBhxkI7pLuP+JvOJg=;
        b=dOtugIkA5UJhz53YKfDcLVgP+SjKMA9ITkwkJq5qLX6TLn924yt7A0K+LTxP80M41X
         NF+Vl0zx2ia6+Md5wvIn5DldbaOFbcn2lWZ++iBxz6Yrmvv+FA8RUotLjnRqZ8edKKjW
         3fcTGmerhsZmQ0zUt5wl7QYCVI0PyXLMegjHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TE7kbIUfLw4QNwKVfaDIb623jjzBhxkI7pLuP+JvOJg=;
        b=jZRTDlw5yzJdg6x6O2oh8V6U+4FZ2yvrnkjZKCjng4N2fMD9N9rp/G06OpjMxF6w0v
         4xPZLZekRd04ntzGz0jyqiqk7zA0bf2oBio5Jo3iPc1i0X1yGgETLsAjR5Uv51KHLUZD
         aRarOohT6jvE1Lg/VIoARwHlRF9I2iCnJqF1jxxENRY9mva7noTEW/WqcBNc352/+15l
         k7DgGnu3u4D/R55BBrCVBBx+EbYcPgpC2pVS+4nMVqwwjwTT8hsWhgzBRDG4Y7yEJ1xb
         /xUGV0aMdKdTC49XFwtD30nh65DaUtQn+x+Fx/ozTS1LULsq6z/ChP/D94Em1iqQd1IJ
         oqOg==
X-Gm-Message-State: AFqh2koEcDbR3ENelTeeACF2qxiviQMAXGA+8OlGilkAia9XGhWv5A+y
        o7PFDv52FlM/y6NOLV3Px9UMcw==
X-Google-Smtp-Source: AMrXdXv5UyWCp8nNPm5viIGGhUVoFwP23LTrdnq2ydx6WSjiJebtmwV5yrlSzULSsWjEq8p2dr8IoA==
X-Received: by 2002:a17:902:6acc:b0:193:11df:670 with SMTP id i12-20020a1709026acc00b0019311df0670mr20042128plt.20.1673490278999;
        Wed, 11 Jan 2023 18:24:38 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b00193020e8a90sm10759135pln.294.2023.01.11.18.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:24:37 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v4 0/8] mmc: sdhci-pxav2: Add support for PXA168
Date:   Wed, 11 Jan 2023 18:24:08 -0800
Message-Id: <20230112022416.8474-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a revival of an earlier patch series from 2013 to add support
for the PXA168 SDHC controller, with an additional SDIO IRQ errata fix.
It also cleans up the clock naming to be consistent with the existing DT
schema shared with the pxav3 driver (in a backwards-compatible way).

Here is the original patch series this is based on:
https://lore.kernel.org/linux-mmc/1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com/

Note that I left out the platform_specific_completion and clock gating
changes from the original patches. They both seemed controversial, and
don't seem necessary based on my testing. I've been running this code on
a PXA168 for months without any issues.

Changes in v4:
- Rebase on latest mmc/next to fix conflict with DT binding

Changes in v3:
- Use OF match data rather than of_match_device and of_device_is_compatible
- Simplify some instances of pdev->dev that could have just been "dev"
- Handle EPROBE_DEFER when getting the clock
- Use devm_clk_get_optional_enabled for the core clock (it's simpler)
- Clear sdio_mrq before calling mmc_request_done
- Small tweaks to devicetree binding requested by Krzysztof

Changes in v2:
- Fix mistakes in devicetree binding
- Use cleaner code for pxav1_readw suggested by Adrian
- Switch to request_done() and irq() for SDIO workaround CMD0 handling

Doug Brown (8):
  mmc: sdhci-pxav2: add initial support for PXA168 V1 controller
  mmc: sdhci-pxav2: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
  mmc: sdhci-pxav2: add register workaround for PXA168 silicon bug
  mmc: sdhci-pxav2: change clock name to match DT bindings
  mmc: sdhci-pxav2: add optional core clock
  mmc: sdhci-pxav2: add SDIO card IRQ workaround for PXA168 V1
    controller
  mmc: sdhci-pxav2: add optional pinctrl for SDIO IRQ workaround
  dt-bindings: mmc: sdhci-pxa: add pxav1

 .../devicetree/bindings/mmc/sdhci-pxa.yaml    |  19 ++-
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/sdhci-pxav2.c                | 153 ++++++++++++++++--
 3 files changed, 159 insertions(+), 14 deletions(-)

-- 
2.34.1

