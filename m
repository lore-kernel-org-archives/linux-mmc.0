Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A1AC7618B
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 22:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCKWiT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 17:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCKWiS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 17:38:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B47F14989
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 14:38:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso8512132wmb.0
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 14:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678574295;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PyX46c8+7Cr0fGEfOckr2DJoe9m6ovd2AZsHWGL+dA=;
        b=WWoNc9KSUi7qyAWhE72X2HRgpUI2VuCTj/ih4zBT/epabQWJV30QRCs0nHu4AZhtIS
         8YvwMF0L7P0qb+7bQwk+2gB61pgNoT5RMPDajBRXeIzsUZA4WngAzs+tm9g0tQ7RMHqi
         5E8VFig5ZfQ/2D61B5zha4sPyn7457JWUgxl6jLBdwCBnfrvUDv8NoQigfehK5KLl/K0
         cvFKY0tXlj9O8cAGArXsSL1Cbv3hPj1x5FgZQlObvFfUJN79cPsjmNy9/5RiDutQhKJn
         sfPEG5nP3Ep8E/h5fbPt+l3ewUU+z09A43D2MRZah3Uz6/5Qj5MoyTuPOwceEW/0Qx3k
         rZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678574295;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1PyX46c8+7Cr0fGEfOckr2DJoe9m6ovd2AZsHWGL+dA=;
        b=b3+o1lQVK0Q8OMbGdn+lpgOxyg7Krel+07LLge5ySHn3MXwp4IyETlcqQtIp4LmFYS
         1Eb6MQLLupo+IB7wgJ2nhYYJO+MbiSFqHFF5BelOpLhP73I5CKmwTIMK0nerXVsIzBmx
         kljPLuxeRj399N+6mAzYpAwINTixbAyhbKfnbYW2KhVrrfBYXiX/vllyRc0jb2yEDpdL
         alEge2S6TmViM1yC7VyUecnK8VGyrkZHpy4LXl97MeuDcVcBR3PyPxjpIcJRCYMMJA6s
         BORscQTBGj4fe8566LS1gS+0lak4f8I+DIVPYTSCZ22ZoAbdGBRArhernH1ZJp6FfhXK
         6NXQ==
X-Gm-Message-State: AO0yUKUOKqXPUcBrai0NMmD0wExg73HO3rZkojHeqMRYYf9fzrOP/k8O
        aEloAQQrZt1o/fElVsRQZzU=
X-Google-Smtp-Source: AK7set8XvvE2tksbLnhLn+bbJxVX9sO0fGdELYMtRuB0j3MerVBdi6JLLSg2PyJFh6rp946rneWoOg==
X-Received: by 2002:a05:600c:3b87:b0:3e2:66b:e90e with SMTP id n7-20020a05600c3b8700b003e2066be90emr6799186wms.10.1678574295534;
        Sat, 11 Mar 2023 14:38:15 -0800 (PST)
Received: from ?IPV6:2a01:c22:7697:7600:79dc:4e28:a7d7:a00c? (dynamic-2a01-0c22-7697-7600-79dc-4e28-a7d7-a00c.c22.pool.telefonica.de. [2a01:c22:7697:7600:79dc:4e28:a7d7:a00c])
        by smtp.googlemail.com with ESMTPSA id l5-20020a5d4105000000b002ce92af57b2sm3450141wrp.42.2023.03.11.14.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 14:38:15 -0800 (PST)
Message-ID: <9ae6f90e-e1ea-d088-cdae-7dd8a541f00f@gmail.com>
Date:   Sat, 11 Mar 2023 23:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] mmc: add and use helpers
 mmc_regulator_enable/disable_vqmmc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There's a number of drivers (e.g. dw_mmc, meson-gx, mmci, sunxi) using
the same mechanism and a private flag vqmmc_enabled to deal with
enabling/disabling the vqmmc regulator.

Move this to the core and create new helpers mmc_regulator_enable_vqmmc
and mmc_regulator_disable_vqmmc. Make meson-gx the first user of the
new helpers.

Heiner Kallweit (2):
  mmc: core: add helpers mmc_regulator_enable/disable_vqmmc
  mmc: meson-gx: use new helpers mmc_regulator_enable/disable_vqmmc

 drivers/mmc/core/regulator.c    | 41 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/meson-gx-mmc.c | 18 ++-------------
 include/linux/mmc/host.h        |  3 +++
 3 files changed, 46 insertions(+), 16 deletions(-)

-- 
2.39.2

