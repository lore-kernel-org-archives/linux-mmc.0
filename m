Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E69C43334
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jul 2022 20:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbiGNUnV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jul 2022 16:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240777AbiGNUnU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2022 16:43:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711494B4AA;
        Thu, 14 Jul 2022 13:43:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w185so2898258pfb.4;
        Thu, 14 Jul 2022 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=arr2UrZq3UNXQzLci/KP881Nin0tggEZNpMwrQSQ3Sk=;
        b=g7z2doQqLe6iH8wS/NuwjMbvkUb/htOWUN+rVlui8asossxZ4Ce2nFZzkIN3ko6Hnl
         TxHAqULX0dN0yjF8v/cCaPJOzpYSL/uV+9qBFQvl0PFZM1/dJDcioEmaz+DyntVDoSoj
         Edy+jcL1IVUSnOeQqjChV8vZ/87ojmE0fykyh+eTMYwAKg25hZuggIrZkJC5JOudyKzx
         ETn84weMjR/6F1p/idzmjwQ/igvrFkcj/75YFfNQca3dT56FuzTsPot8MrAGjeC+hUis
         qLo2Au5yxu4UvqFBPxxqU7jBfblHkKCcBCFtfZzT34HZZZ8VICp2J1jW536cRsaAmgSP
         fnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=arr2UrZq3UNXQzLci/KP881Nin0tggEZNpMwrQSQ3Sk=;
        b=II90e3562zevRZ0KmixmuSrexbp2mrWaj5Ujzz0w8sEK/dchRVeb8mdMEDwhVt+S+Y
         //9kw071RoV89KEVRRzrur0CBXcMy3kOLmaZ7g5Lmj4u1BclVmLqVS5x1JMmfl6FvOIR
         GNB2IuMH5q8rEQUkXXOMnF/antNSWQUsB/R9HCQbFlfA2HhWmHnuM5OT/QZHwNq7dYKJ
         FNtTXtkICtA5ZBSGzcceGys3fImvMuPyfPEWIT7ndS4JkzOMQ1rvoNtQg70GA3sedzbt
         vbd7M4lTOjfUj8R6NnldT7hwkBf566F472Suh3BMT1J0f9hFL35ex3pbMRrLNEag6zAN
         XqNg==
X-Gm-Message-State: AJIora+ahyThD/+WnJCKn5TLfal9pXxN+oCTJsens6QnSJE9RItgyVcZ
        QAplkr/3GY7+sqHqmSMnVgI=
X-Google-Smtp-Source: AGRyM1scd9xjyyn8+ktl7wLcfz05TjOearwg7OfKyKKDdC8P2UKLcyGuRzX63284jdgV35zhzipSXQ==
X-Received: by 2002:a05:6a00:8cb:b0:510:9ec4:8f85 with SMTP id s11-20020a056a0008cb00b005109ec48f85mr9834389pfu.24.1657831396922;
        Thu, 14 Jul 2022 13:43:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mi9-20020a17090b4b4900b001ec84b0f199sm10506871pjb.1.2022.07.14.13.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 13:43:16 -0700 (PDT)
Message-ID: <d0a3fdc9-ffee-0dc8-5352-e64290803456@gmail.com>
Date:   Thu, 14 Jul 2022 13:43:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mmc: sdhci-brcmstb: use clk_get_rate(base_clk) in PM
 resume
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220714174132.18541-1-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220714174132.18541-1-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/14/22 10:41, Kamal Dasu wrote:
> Use clk_get_rate for base_clk on resume before setting new rate.
> This change ensures that the clock api returns current rate
> and sets the clock to the desired rate and honors CLK_GET_NO_CACHE
> attribute used by clock api.
> 
> Fixes: 97904a59855c (mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0)
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
