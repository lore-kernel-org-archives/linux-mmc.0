Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95186C77B6D
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Mar 2023 08:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjCaIuR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 31 Mar 2023 04:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjCaIuO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2023 04:50:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497881BF4B
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 01:50:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q14so22270596ljm.11
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680252606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hm2hIAzlWIlh/HN1Ebjpq4RGvB1b+HCsUGt69FXJxjo=;
        b=OZzN3gG9tUFUcxAB3ktfT4IXwzPS+VV7TL07b1QYgQ4YiHiWCKfi+cQJMLeoKR7Bzs
         sjhISVj/7gm/tgojJyvLUSlOQrCN6xWk4Qez5mTfkvlO0kNy77xNbUIBQ+3EN8OKBIzD
         CL+QZG3i33RjSa14dyrobfjtJPlUyRRkfK/T/E9f7/JpBxQs94h8s1RGrVTPq/sMxj2T
         i925RhEbmaPPxIR5ciVNZGfvOKyr2RqNMYnfoDaz5gxixNXjJ8kxozn7V4DES7VUfw7Z
         I7alN4mpWXVMm3HA5WLzfMu/KvAVVHbnDUXPYmn4W1e1RkwO67R/ShCjqC1t/lcb4vhP
         wJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680252606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm2hIAzlWIlh/HN1Ebjpq4RGvB1b+HCsUGt69FXJxjo=;
        b=3+lC6AYKdvMubzssJGbHbqpFPTKATPzbJ9wemC/8mePw79DyGNm8UlSmfsava4cw28
         zAFypL0/IF2S8DOZGtyyiKCh4bnbA57mcFnFx0Gi3mm6WWBCZN52iBSEEKQeLHcw4YW9
         3G3X1fwrjLgQGRXQhWZebgFxZkWCsncsu6ckP74iIT6zswzITyop7FEbdm/M+FTIOoMy
         qFy6gY7e5S2vfEh9TQhErfz9lTWTJH6Wp6olLu2FlHeEBgUTMPtdmUycuGPdZ3yTqhy4
         C8I+o8uB9FVEvfNI9PLZ3QFpKecUoUcO+zdrfoo+OPuHNhloiv/tCRmCLfunsMf40iA0
         fHqQ==
X-Gm-Message-State: AAQBX9fCXPWrpyRK4IjQ7/t6eHh1TyVryA23i2eTYq+tIPN0FqrQF8y7
        fEzKLQvA7nNsau0v6p1zWbVP1A==
X-Google-Smtp-Source: AKy350b5BwrspfmaEhSZ5j4TtCdA7YCIHmTX5EQVjnvSnXoOPLRYU9gWB7YN5bhQTMIGSMGEAsyNlg==
X-Received: by 2002:a2e:b548:0:b0:295:9ba2:8a78 with SMTP id a8-20020a2eb548000000b002959ba28a78mr2608023ljn.17.1680252606400;
        Fri, 31 Mar 2023 01:50:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p23-20020a2ea417000000b002934abfb109sm270261ljn.45.2023.03.31.01.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 01:50:06 -0700 (PDT)
Message-ID: <ae7bdc73-3836-fd28-f253-123ab27b7418@linaro.org>
Date:   Fri, 31 Mar 2023 10:50:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal
 Net compatible
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, saikrishna12468@gmail.com
References: <20230330065240.3532010-1-sai.krishna.potthuri@amd.com>
 <20230330065240.3532010-2-sai.krishna.potthuri@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330065240.3532010-2-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/03/2023 08:52, Sai Krishna Potthuri wrote:
> Add Xilinx Versal Net compatible to support eMMC 5.1 PHY.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

