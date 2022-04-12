Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A84C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 12:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347434AbiDLMgI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350978AbiDLMf6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 08:35:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE48F32076
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 04:54:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ks6so12179611ejb.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 04:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6udN7p84mQQbGIPlPrTSL/PLuG+dh1guReUObCKNXP8=;
        b=DpJ5xce5z1oKLNoQI5H77n+qFkrR2trfG6eiMK3QQPicwsTlh1LbOMYrgQK2Jwkdwj
         LK4vOsQSTqEtifdm6tfTeWzv5O6laFEG0jqXYJI8aqW9qc8WznM4Wh4ljvA2WY057Y2X
         BOGQY5uI3BLeoeBOdfi3C/KNrD9lwiHjVqr88X5WIDgjNizuqzL4SvOf5YrNCrawGh8A
         sXIlPr21fu2tSAT5DJoGwj0mpoVZPaVDZ20xJ6aJQ94w8uMTA94CkuyR12nglFQ5Ks7w
         RaEhnkEIVS+j23IO68YdoptMq+MMdR6wiU1zJDTfHdQgmNoaxVKVcknvT8kKsjeHBk2v
         d0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6udN7p84mQQbGIPlPrTSL/PLuG+dh1guReUObCKNXP8=;
        b=2p3KkZzJ059Z/3OwWkAxaITKdlr2Lb8PFfMP8NppG+g0YX420rXToc9xXnHtu0Sc+q
         39vVGvYxOhHcORaq3wbG2k6d0gJ2zy9eAc/t/3OgAInkrFuazkiFGVPa2gwXNXqVTnrb
         eUFDgpmffEJvB3wr1D0hoJpAYEwzfq3EYqZ1nhg1meDcVhPg7gAluZIWrIHXRj4FY+K7
         ZmMG6qLinB1EmEZFe3CgKIIBinKg8Se+1GCn1cQiZvdB5RZQvcV1TZoAWJr5wSD4oF8J
         GpyCMn3FfLJv8xAW3j6VjwlMgR7AqibUU0gdi2SNZgCz6+ArSeNkmHP0tDRDBbbuKq1m
         7lJA==
X-Gm-Message-State: AOAM532XnWudnXs/4rzcXcZyhTM31UA3PnyMpJMto/d84A6DA72i5Br6
        jMg/fKsVPjiWKNkE5CeSnzpSMQ==
X-Google-Smtp-Source: ABdhPJyJhJm8ZVPk7tw6VD+la4hCwdTsmQiQ9k85Y+ogd6oPi0J+6g0dtxAMCcJdiZDIn+K32a4jtw==
X-Received: by 2002:a17:907:1b1b:b0:6e4:7fac:6ce0 with SMTP id mp27-20020a1709071b1b00b006e47fac6ce0mr34100414ejc.617.1649764485066;
        Tue, 12 Apr 2022 04:54:45 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm16632865edt.70.2022.04.12.04.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 04:54:44 -0700 (PDT)
Message-ID: <1b0c00bd-de0e-3096-556d-4d944e5d9b00@linaro.org>
Date:   Tue, 12 Apr 2022 13:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/7] dt-bindings: arm-smmu: Add binding for SDX65 SMMU
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649670615-21268-5-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1649670615-21268-5-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/04/2022 11:50, Rohit Agarwal wrote:
> Add devicetree binding for Qualcomm SDX65 SMMU.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
