Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F19DC636CC
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Feb 2023 20:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBOUIq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Feb 2023 15:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBOUIq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 15:08:46 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DB9A27C
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:08:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o36so14224407wms.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTcViWHxxxQk0Ikb/2jiLPf39pJe7Rrz+3yNL21eKyk=;
        b=WPADfSvT+az/YRrKSdAqlMDjZIbGLJRLRCTOlR5eMR5UiPOhaoArLS2nCL2Nqcv7nL
         DUkRqBbEQmsevCpMwHwZFhJRgIeQ0mr5qP3yaGLuu8Gl40oOaPndRYVfE5dhTT1JAQvV
         RKC39FDHEAXcQwNl0yobMv2+cFlF4zRfD5CyrLu29IrUQlyKdo4IeJI00pBQF2wtTzmn
         jZANz0ldVfapSeZnV/oZkOGVSocdJlKZ/xqBEkuY2d1LpMSWZGiYfzvVVdh2EN0w6Rt5
         mmpSqZuEzPQ3+/T4sLHrpFU6Yh141BpX8T3JlZwXUjItaPe4cQaCYkMDHhodVwNx+ruG
         HYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BTcViWHxxxQk0Ikb/2jiLPf39pJe7Rrz+3yNL21eKyk=;
        b=o3plhue/J/QcWs2qILw/t3Rm0A+QA44uD1vMCnLT6PFOslCGre+sKDDL0geUFt9Wbm
         d3IZ7M5roeRwmuMTrPHDfihcqJnK7nn+k/hGaMZeQezWfhpKxzmxuCYP5vOJ322q+Ekj
         chbRt2lTjZJo27iI2wabAOaC58yV3J6w61tgBA6xidEE4X077pPg/4x/fbnXRQxA7t7I
         kCTo86WNqE3EkgcKvFsNy6gvxuO66luev+wWc3u52E3S8PLml2AMcFnVNKwcZg8YuGBq
         VSLrRpprXCh+foOzOi4XrU6IGEtVBJKN36TnX/jzi/ECwkH8yPXxBqcgMHc3uFQeHLDV
         3sLg==
X-Gm-Message-State: AO0yUKUZohoYbv83iFDaarfmEGX1e7tDmElDiCDPVxxf69+utyb/vUDg
        qmFQqHRb/c+RIjDmK0aYC/A=
X-Google-Smtp-Source: AK7set+uyTa0QX7BTiAZ+mo+ojgMBoXjYVRLYsF8uAgXuUr1HeM/o7rq6uNikq/UEFt9malAcOHLvw==
X-Received: by 2002:a05:600c:244e:b0:3df:57aa:db52 with SMTP id 14-20020a05600c244e00b003df57aadb52mr3105098wmr.4.1676491723495;
        Wed, 15 Feb 2023 12:08:43 -0800 (PST)
Received: from ?IPV6:2a01:c23:b9d5:9700:ccee:9a0d:2992:c73? (dynamic-2a01-0c23-b9d5-9700-ccee-9a0d-2992-0c73.c23.pool.telefonica.de. [2a01:c23:b9d5:9700:ccee:9a0d:2992:c73])
        by smtp.googlemail.com with ESMTPSA id m9-20020a7bca49000000b003c6bbe910fdsm3154779wml.9.2023.02.15.12.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:08:43 -0800 (PST)
Message-ID: <02b46550-e0b5-4251-8156-56eb0f690d89@gmail.com>
Date:   Wed, 15 Feb 2023 21:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] mmc: add helpers mmc_regulator_set_ocr_vmmc_up/off
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A lot of drivers use this code, therefore let's factor it out to
helpers.

Heiner Kallweit (2):
  mmc: core: add helpers mmc_regulator_set_ocr_vmmc_up/off
  mmc: meson-gx: use new helpers mmc_regulator_set_ocr_vmmc_off/up

 drivers/mmc/host/meson-gx-mmc.c |  6 ++----
 include/linux/mmc/host.h        | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.39.1

