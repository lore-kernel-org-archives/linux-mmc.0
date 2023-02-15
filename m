Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A8DC636CC
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Feb 2023 20:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBOUOK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Feb 2023 15:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOUOJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 15:14:09 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854682597E
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:14:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso2560498wms.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=siyoi7tU1TEBf7AYDT4w7kUxYaQu0QMTjP5CxbvyWqE=;
        b=CJLkviqFRgeoVuDuTiLnXH5xRKQExPdNkt1xBaPfByUFpxZRlY/kgN5E5C4jxKqNvV
         lR3p+tiLM1ho7YRWjiJ52LhoQOCLj54zw4HpOO3J7mDxFZJb1xzZHm00guMMvP9VOVfl
         Id452drWf/XPhv7mgc5PfK8o3SzlvCYhBfqe3lKLT+Xgak44UQSMQ7si8FQqJ4M05R9U
         DYSHYQzd/cPHxHGc4tPEOCrjtJM0Nw0iFw7MgYmnpzZa6DFg9vmFL1Pz+iGDpQz+dX3T
         Heev7X/Dkv90/yv/uN6aZec+4dFyfUQJ8X48EM9gmTjUyifUb6O175rOP9pFKOhI0wdJ
         4pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=siyoi7tU1TEBf7AYDT4w7kUxYaQu0QMTjP5CxbvyWqE=;
        b=hAX80FkeW1cs980tLVRhy9VCJIpvhxxAsz1BCW7rY8FgA/Jcg+52mi7RVxtrmwhYCM
         w60H/tbEu7Txumw4/kRE5lxtat9ZGAplU8TPhdJHWL5ynzzRb1lCgthDNpNdkbS8PWZb
         WFNZJ/n3ITtwUnlLIvdsfaT7VBjUT8ddMXla6wNTPlYJLDCe9tEn/OjFQ9TVNt/n0uA7
         vHPprA02nmDHWP39iQTvReNigjLfnYzJNtlbEDrhnC3EHYDDAUdhFwby/xHyUOjOcCiF
         idUt2TLhkEBqQTnFvIHJ6fLj6qPHGoP6iJLBimaMpNignHQyGo6f+oyH/6qOCYbHNDpW
         t1gQ==
X-Gm-Message-State: AO0yUKVrOZUt8SiQnqqZhqQHbOim1QZTWMwXhkStnyhWyM4PeTZ2KJFz
        flBo/HAxqVHVxjkZRb3uKGo=
X-Google-Smtp-Source: AK7set+UKuZeKxGuRmLzI8d3TbmzZ3f4l+W8PzPkj5Fd8UVTrvg/F7EoydLauGzXbji1xI30KPbGvg==
X-Received: by 2002:a05:600c:44c4:b0:3dc:eaef:c1bb with SMTP id f4-20020a05600c44c400b003dceaefc1bbmr3077358wmo.35.1676492046934;
        Wed, 15 Feb 2023 12:14:06 -0800 (PST)
Received: from ?IPV6:2a01:c23:b9d5:9700:ccee:9a0d:2992:c73? (dynamic-2a01-0c23-b9d5-9700-ccee-9a0d-2992-0c73.c23.pool.telefonica.de. [2a01:c23:b9d5:9700:ccee:9a0d:2992:c73])
        by smtp.googlemail.com with ESMTPSA id ay1-20020a05600c1e0100b003e1fee8baacsm2994527wmb.25.2023.02.15.12.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:14:06 -0800 (PST)
Message-ID: <2553f3bc-b1e6-4af2-fb6c-def486dd99a3@gmail.com>
Date:   Wed, 15 Feb 2023 21:11:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH 1/2] mmc: core: add helpers mmc_regulator_set_ocr_vmmc_up/off
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <02b46550-e0b5-4251-8156-56eb0f690d89@gmail.com>
In-Reply-To: <02b46550-e0b5-4251-8156-56eb0f690d89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A lot of drivers use this code, therefore let's factor it out to
helpers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/mmc/host.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 812e6b583..f93fb8c7d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -597,6 +597,23 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 }
 #endif
 
+static inline int mmc_regulator_set_ocr_vmmc_up(struct mmc_host *mmc,
+						struct mmc_ios *ios)
+{
+	if (IS_ERR(mmc->supply.vmmc))
+		return 0;
+
+	return mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+}
+
+static inline int mmc_regulator_set_ocr_vmmc_off(struct mmc_host *mmc)
+{
+	if (IS_ERR(mmc->supply.vmmc))
+		return 0;
+
+	return mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+}
+
 int mmc_regulator_get_supply(struct mmc_host *mmc);
 
 static inline int mmc_card_is_removable(struct mmc_host *host)
-- 
2.39.1


