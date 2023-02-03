Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40FFC05027
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Feb 2023 23:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjBCXus (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Feb 2023 18:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjBCXur (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2023 18:50:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EF7627AA
        for <linux-mmc@vger.kernel.org>; Fri,  3 Feb 2023 15:50:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id d26so6275858eds.12
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2023 15:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Hulx9pXue02GHwO2JZRcbOSksJK7xhjVlzgJbdprMo=;
        b=HtLWD2pGgETEXzzwA+UPcEI32tBTWDv3NuORBdQoVE7jeJ+7O6X73RzHTk1pVA4rTy
         Lm9P3/7CM6F1MXbsXaWpWN1+pNRMV3nUL1nOJRhE99NUq7cMwEyvqY7DusEdE/Gt9zfE
         Ol/9AD7Opcqu0WyICPgcPE1+bzIyuqKTkPjPdZDyFy90Ac6VUF2gKHxk/tpbpe/NXPLV
         5dugzD4guMz9eIHe1faSXkXc2VYj2z5fycmcf84dX4SeqFDMbjy7LKUyGjT4vkpZf7W2
         UhPBMocODOdEkzzXLoRi0o1sX+NOb34r+JifAj9JDcVyx00RAdP2vJ3UtawvLsnTp/uB
         3Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Hulx9pXue02GHwO2JZRcbOSksJK7xhjVlzgJbdprMo=;
        b=24EXri+HTf7atH1UDw4SZgHXd4IPNHZi7X8mWr68K+7UBIdRoxaioDrREjArwhvbim
         sGAcHkpK4xsAzJTwfmCzfry18xH4+958ZeKqB7DPZlcB0q/sfaRbm26CZttCw7vUyFyN
         Cz6LFqAsN/jHdpMBacrEdRF7ydqOsCVDFLNtpHHUJ4GGC1Ft50D2KcCStzePgYhikX9V
         GHT/VjbscjOZz2Q0UPrpIDkvO7XxQBNqj7tbBwqh7AhdwmtNuhrsd/+HCazjGQKyYAJM
         AlCL3kQJAJquVYi6UpNl87lvZDggCLNUWm7NWrhKn9eRMbS+glMnbAWg3+KHiqqA5nds
         DKOQ==
X-Gm-Message-State: AO0yUKVzqC+HnsX8sJ5CvhMDzuspEtgAHHUGMLeC4ZNsqZ/maqbtX3im
        hDZXDfM5oXF0Hi7/fFtFxusC7oYQQCo=
X-Google-Smtp-Source: AK7set+EgMNZDU2u9B68XyLLnrn177SltCeKS5lWLaZK+Pt2BOaof72K67+fLYohCBVOXofWKgDNXA==
X-Received: by 2002:a05:6402:1cbc:b0:4a2:54ff:aa81 with SMTP id cz28-20020a0564021cbc00b004a254ffaa81mr11543566edb.34.1675468244515;
        Fri, 03 Feb 2023 15:50:44 -0800 (PST)
Received: from ?IPV6:2a01:c23:b81c:5800:95fd:ccbf:6c44:23f7? (dynamic-2a01-0c23-b81c-5800-95fd-ccbf-6c44-23f7.c23.pool.telefonica.de. [2a01:c23:b81c:5800:95fd:ccbf:6c44:23f7])
        by smtp.googlemail.com with ESMTPSA id ee8-20020a056402290800b00482e0c55e2bsm1765949edb.93.2023.02.03.15.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 15:50:44 -0800 (PST)
Message-ID: <e7880df5-43ab-d6b5-0ac3-440adfb12808@gmail.com>
Date:   Sat, 4 Feb 2023 00:50:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] mmc: add and use devm_mmc_alloc_host
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add and use a device-managed version of mmc_alloc_host.

Heiner Kallweit (2):
  mmc: core: add devm_mmc_alloc_host
  mmc: meson-gx: use devm_mmc_alloc_host

 drivers/mmc/core/host.c         | 26 +++++++++++++++++
 drivers/mmc/host/meson-gx-mmc.c | 52 +++++++++++----------------------
 include/linux/mmc/host.h        |  1 +
 3 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.39.1

