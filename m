Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63307C6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 11:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCLLfV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 07:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjCLLfQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 07:35:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB83B1D92B
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 04:34:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r15so10803434edq.11
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678620867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGAGgYNdE6Pd2X6RBk1rI1o424GOh4uqi1Rdj97RA5U=;
        b=WGzbJVbbiux67OAymm0FAyqyIpewzK50jKPRHmsc2oj7+Rd+/3sGFhkM5PTqSHAf3V
         HV57exi/IoVOZzXbQzMCF1xWL2uFSn07S6uoRAvfnpOQUC2u2RO8kngM0nyNFs4ZjcJG
         2/aW8XBhH91umkIG1GrwsZeIKxi13K6pfuCdXQlkoQaxW0TlXz0oLEBdrFN+poqsiy5H
         FddT8EMgCbdjVTWAaW7JdlSmxGC2iBlTqfO1IE/UgFbz63Vw4u/Y4B48cv7InaQdMSuv
         7gXGhJFLf5eJNHEKYSZk6BwzJs5Qvky0Q63Rpuv+TY7AU29/JxajT7qR6wgNLW/pErrF
         gQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678620867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGAGgYNdE6Pd2X6RBk1rI1o424GOh4uqi1Rdj97RA5U=;
        b=PxVT+C/GUcr6q50PkZ+SsjP1EJ4QqYPKlvJWXX8jKOySmV93KphFLc8NfE/8BsdREi
         e8TLkZsorv0xLGT5+XGL2vjFhp+24X2kKTpuOyWfU2IashVWlDBrhFZ5sb20NZUME7us
         dlfu7GvCf5WqA7uibYefJRXlds0ScH0analmEUxkws9bbj6JHgOAhrX9MKk/JbTlXCX3
         CpU3HaN2rBZcsFRi4PtRkcBSd1iEV7xuzQUmlHPwKAyvdlK4/81zef6zWgC0yJcPX+tD
         vWNALxtUVnrknvdGgJx5qICPDM4Z5slE3EuEqwZl7chGQZnBgLABl0eMi3YQySbA9N38
         0gkA==
X-Gm-Message-State: AO0yUKXfT4f8Kum+ya/Y0R5ABI7hekh7qL80oGfycJLxsHGNxscaVCUW
        dcj4B1FDZrzE+nmFiQY5I7SKtg==
X-Google-Smtp-Source: AK7set+rQR/TdHRnzgr3x3hfLsnoGtW+bJ0oFdDa1SCVGt2GQP//drZfE7QpY4BGi1h/ByHibY/Vjw==
X-Received: by 2002:a05:6402:1a52:b0:4fb:3ab9:fe81 with SMTP id bf18-20020a0564021a5200b004fb3ab9fe81mr2552339edb.30.1678620867559;
        Sun, 12 Mar 2023 04:34:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id u18-20020a50c052000000b004fa794ac0d0sm1575303edd.54.2023.03.12.04.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 04:34:27 -0700 (PDT)
Message-ID: <951dec3a-1a3e-6d17-20fb-9e5915606c40@linaro.org>
Date:   Sun, 12 Mar 2023 12:34:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <640db6ef.2e0a0220.9d4ba.1500@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640db6ef.2e0a0220.9d4ba.1500@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 12:26, Sergey Lisov wrote:
>> There is no way this is board specific. This is SoC specific. I
>> mentioned it last time.
> 
> The same compatible string ("samsung,exynos7-dw-mshc{,-smu}") is used by
> several devices on different Exynos SoCs.

... and should not be. It should come with a specific compatible
followed by this fallback. The specific compatible then will define
32-bit access.

> And I was only able to find
> a vendor kernel fork for one of them (exynos7885-jackpotlte, it has the
> workaround, but it depends on a configuration option and I don't have the
> config file for that device).

Vendor kernel have configs, I think that's requirement of GPL.

See jackpotlte_00_defconfig in my
samsung/galaxy-a8-2018-jackpotlte-sm-a530f-exynos7885-dump branch of
vendor-backup repo.

Best regards,
Krzysztof

