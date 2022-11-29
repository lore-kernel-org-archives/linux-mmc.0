Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B8FC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 03:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiK2Dou (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Nov 2022 22:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiK2Dot (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2022 22:44:49 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53736B4A0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 19:44:48 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y17so4283531plp.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 19:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc6YZeu86MLhbPIXSljwWJJn8NbPxcgy7OA0BHwk7uA=;
        b=SCAOlPPooD/APYwTsXkzkioVUSqcnKSOk7t5hrhs4bXxb1EVMcpXSZPyWGyliWZKWe
         Z9GzpWLVYalirAQ0qRzfbOPdl1ZJTz/vkX5kO9G0NfmnRHABxGldcQAZElikf+5iKI3z
         U70mS8vv46YAjv7ZK8/CF+afnJcgWYs82qMeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc6YZeu86MLhbPIXSljwWJJn8NbPxcgy7OA0BHwk7uA=;
        b=mDIyKW5LCzIpmPKPEYzOGyV+uL1lIG/Y28237FMtql/lh6C28KVRGuj5uaMJeyq3YI
         RlX2b4nV+EbYkYAGbhm3zoWrBM967BL4yYcd76cVzOUI7Z/fi4Tzs4EU6rBY4Povlu20
         D3p6nDy+D6hb+AtGSihoWwkFKASYKRM5LkZTr38CF652c1k7AnMnPiH7MUUQkQCoF3H2
         +PG6TBvGqnoNHPTe+Il4pEBAMhYmq3OD82oqhyhKFBbHWcfpFijtPASWYunOtilfc7ji
         ry2CLud4tqYpcXXQAzTAJi+5BmFXUziCtq0kyKNa8jicQ5KJbQWWUyvthbJKTNKUP6j0
         u99Q==
X-Gm-Message-State: ANoB5pmxgaXegMTLYUhcTRskJfUKCwhVKmjy/HXwUJpPTYENoIcoQiqA
        yMMChoxsaUEAfPL/nG/nUBkWEA==
X-Google-Smtp-Source: AA0mqf6VE44fM8ZN+/MCjrsKz/vmsa3nEc9iyrgxnJbdY7NRiouCGIfiNOXJtaStWUulWRyZ3CGHBQ==
X-Received: by 2002:a17:90a:9908:b0:213:b6c7:53e1 with SMTP id b8-20020a17090a990800b00213b6c753e1mr64739389pjp.35.1669693487748;
        Mon, 28 Nov 2022 19:44:47 -0800 (PST)
Received: from [192.168.1.33] ([192.183.212.197])
        by smtp.googlemail.com with ESMTPSA id b194-20020a621bcb000000b00574898527c8sm8781165pfb.74.2022.11.28.19.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 19:44:47 -0800 (PST)
Message-ID: <08abea27-a751-d861-c526-80b41dd72ff2@schmorgal.com>
Date:   Mon, 28 Nov 2022 19:44:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20221128024407.224393-1-doug@schmorgal.com>
 <20221128024407.224393-9-doug@schmorgal.com>
 <263b5e29-f0b4-27b4-a753-592153edc3c3@linaro.org>
From:   Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH 8/8] dt-bindings: mmc: sdhci-pxa: add pxav1
In-Reply-To: <263b5e29-f0b4-27b4-a753-592153edc3c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Krzysztof and Rob,

On 11/28/2022 12:58 AM, Krzysztof Kozlowski wrote:

> No need for minItems.
> 
> Start with capital letter if this is a sentence with full stop. It's
> anyway looking different then the rest of the file, right?
> 
> Why maxItems: 1? What if one wants to add here more entries? Drop maxItems.
> 
> Ditto

Thanks for the fast review. Will fix this all in V2 after I receive
feedback on the other patches. I was trying to follow the pattern from
another similar schema and didn't fully understand.

On 11/28/2022 4:20 AM, Rob Herring wrote:

> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13)
Well this is embarrassing! I forgot to run dt_binding_check. Sorry about
that.

Doug
