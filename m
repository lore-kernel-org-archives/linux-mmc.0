Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FABC4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 14:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiKIOfB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiKIOe7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 09:34:59 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923A51261D
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 06:34:58 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b9so26064781ljr.5
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 06:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZx04SasLwqf9ldsbI3VPQRqwyw8Z+v7jFzXUXT/Qrk=;
        b=e/YNifEm6OOdJN1uo9vjMAfEYEwXuDqJI1RrWqXrnhUw3evyiKD0XWQvBMzEKnukK9
         dZsehmTY7c4A2rfwLSJfR7SrRAMTHZLrQwrzhpS5DkJb/CIM+cxzVrUlyI1zWvdYlWni
         FA+Odi1FWqwTckjIAyfG0Nyyxnhbsm7bTCmRU4U9cnGmJfNiZ0k1OWhO9q/OWwCJQ2cB
         D1PtgrAC3lqX6LWC0SC6sU/zo0uxnL00CbyTWGqCJLxkdjhIYwk66O/2LFWoiyUJBfS2
         E/0AExbznOJ/bVZem/EoVeRNPJckFoPY3s8vJ/TSKMteBRPm7S4LrV6UygCGQA/YO23m
         oKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZx04SasLwqf9ldsbI3VPQRqwyw8Z+v7jFzXUXT/Qrk=;
        b=GlXNf9pSy9fVv+JPJ/iAM/Kk2dzUFxnldJhrwS5zqyzJGk0ZYYvDWB1WmYLHQApcIS
         TTgmk0zb12EAyF/MfeYsb+ZrPrFZmCJKFStx77m7Ck4ZDpCd+PsrsOIwecF6EPxK479e
         fpI7QwSKuRU/o4S7vpMqUCLSmp1LzmWT7iiSkkFc+3E7V4EFRRFuN2kz5as+2JpuldvU
         nKhs1/znp6WCL/XF+eMqbReaZ78T4PwWDkUYL5A24zr6oLhVmmPKA4NZu57aVTXDr3S7
         L947CT6ejHN09/w4G5hI9cuQuQNsx3Y4Rkb5+V9sflS7/RBdMuL+l2pHY3xI3Y2Myfd+
         dypQ==
X-Gm-Message-State: ACrzQf2OJLcnDnpVBWPIzgVbhnL3Bj6kGHeBFq8Ua9fWJ6yr9Th5e8G/
        BUD5p7AyyegtKfgc49AOQw9Kig==
X-Google-Smtp-Source: AMsMyM4AD345kQHxbb29mwZgIXzAJUVPAIIuQlNzTJmQbHVxyVpmlXcw4YovKLJWDOUZOKFrOOfcnQ==
X-Received: by 2002:a05:651c:1073:b0:277:35ca:5eef with SMTP id y19-20020a05651c107300b0027735ca5eefmr20592048ljm.150.1668004496937;
        Wed, 09 Nov 2022 06:34:56 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id f14-20020ac2508e000000b0049478cc4eb9sm2246056lfm.230.2022.11.09.06.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 06:34:56 -0800 (PST)
Message-ID: <7254aaa7-c235-aa4f-1706-be68e49f2244@linaro.org>
Date:   Wed, 9 Nov 2022 15:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-msm: Document the SM6375
 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221109142623.53052-1-konrad.dybcio@linaro.org>
 <20221109142623.53052-2-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109142623.53052-2-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 09/11/2022 15:26, Konrad Dybcio wrote:
> Document the compatible for SDHCI on SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

