Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04A6C43334
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Jul 2022 15:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiGDPmm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Jul 2022 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiGDPml (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2022 11:42:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81D311154
        for <linux-mmc@vger.kernel.org>; Mon,  4 Jul 2022 08:42:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r9so11512331ljp.9
        for <linux-mmc@vger.kernel.org>; Mon, 04 Jul 2022 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=jRnTm0+dhArAF8owZ/onzsDSwIYF8pxjVkdj1G3Cz5o=;
        b=srzpyXDfFAOKz9xrgKk3U8OxFpXk5TyzbIYL0NMUfFcRRK04o7SPEVyh801/5rnz5e
         ZL/ta0GZONJpuPnVEAm9/FUUTeQetAIshts9/9l1aj+EFs6zjrFIfjxANrL5/kZ9Fa4b
         DJinEXFYO3FNmqfaDjWbWZyiYJx6GZ+j8oH2mR4GddbcOXVgLan4NDvI79VmezE4eMkl
         LTjxe3a+vtNhWHO8BrUkbx+GOMruKUhZUBwZuBkhMrlZUndDjzrt9m0pMVLOHO/zZTOk
         I+rIIaAVLiUdK6H1LPlnLlZuMN4xoMVlwmfTHQDgO/7BIlglVBBAfENwoA1nmbb99hZB
         FBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jRnTm0+dhArAF8owZ/onzsDSwIYF8pxjVkdj1G3Cz5o=;
        b=6NcM89JQ5O3ad/Ek3inQjMUS8kg7qJZWxDMc3sVhL2vmW4HUmc/mMxZqdOMBdH0OHi
         X0s/N7bLimaHqRXiCELJQhur5yDIWDFvfXVnoUnjcgobxRFJp7Nc4G3r5Yadz+dEOEUc
         GV69/HLkkmuzIXLRDDJSOXzZpmoSqEgcMILQPz8bdXx+QqXhYzdQQjK79w87tv83oUhy
         RSqjRRIQbZLBOHAmDlD9R7nv3aCDb6cAftCLT4SthAo40p1rWsZEBDYYVg7wJnNirfcg
         Y+Y7KnJ5c9GNTv5lkfPjxKaiyV/Uxj5B7B1yjpZendCK0k3G9KvfcYYcDrcN+kgfTpip
         YMKg==
X-Gm-Message-State: AJIora/jub/LTcfB94gAZxQYlMNg09dJKfqI16m8U8VpalbI3aAN+n3D
        PLaBbvSU/kft0R7SZTNN0fn87g==
X-Google-Smtp-Source: AGRyM1vZQoubZwD5PSegPGEQF1WuQ7CzAxwM+FuzlgVx4GryS2HKGicC/YzqczbrBsHc+rbZ34RyDA==
X-Received: by 2002:a2e:4e09:0:b0:25a:8dd7:5c40 with SMTP id c9-20020a2e4e09000000b0025a8dd75c40mr16699694ljb.74.1656949359090;
        Mon, 04 Jul 2022 08:42:39 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id o4-20020a056512050400b004785b66a9a4sm1492621lfb.126.2022.07.04.08.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 08:42:38 -0700 (PDT)
Message-ID: <fc5a5d36-ebaa-3300-287e-fdc2e0c547ce@linaro.org>
Date:   Mon, 4 Jul 2022 17:42:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-msm: document resets
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, bhupesh.sharma@linaro.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20220704143554.1180927-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704143554.1180927-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 04/07/2022 16:35, Robert Marko wrote:
> Commit "mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC" added
> support for utilizing a hardware reset and parsing it from DT, however
> the bindings were not updated along with it.
> 
> So, document the usage of "resets" property with the limit of only one
> item.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
