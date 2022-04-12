Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFE7C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 12:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347572AbiDLMkT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354883AbiDLMio (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 08:38:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA416351D
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 04:59:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bv19so13825614ejb.6
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WaJAMSrJDoo9/Hssj5JitI09tEE075kukXq21wu/5L0=;
        b=nhcJ8zGYc/klHu9Y8GsxATSJikwbOFEWekXMlCmX5sxb9li4oSg9PGeeUbXZGFy8Nc
         IXF5LFi7P0i3sbGcyqTvlFaWkyCfUMMmV/v91H3n5Hu+RZY7L5gwySHmiar1TezMG0dA
         PNMJMjqsuVe9EzVY1D7+Oboem+blu2muLkNlfajeYd5kD1SMJnhKX/RsWGsQq+wGma65
         X/shOW3/nET3zNJ2Rg1QlOEeSAe6DcHQyQStm4D0XuYkN6yN7vot6ngbuLu99m6XKXbk
         Pz26pbFrolE9LlRnkGAHyePGw6JGBezdYLs0FYzZaEI5H+6ffUb7F4PP8Y0YUwstuYwL
         P5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WaJAMSrJDoo9/Hssj5JitI09tEE075kukXq21wu/5L0=;
        b=xc28xVFlNovJpa6oqnS4qEzb2MPmS7lE/cOHzOv3tBYmD0jHwl2uXENA49C2XOa9/k
         Jvd8gsTB8REiWLRN49pSCaj5Lvd+i52WbVTKMEewkrIxX124oOErNtFiP3PZKrsu60qs
         ISK5Voh2CqB45q7HDWhyL8DiuWeWswUA8JinBXZE1gjAfvnwj8ojbq7aiItkPSVaT0pR
         q4nYb5XzB+7VOC2pFUY+ir3S0Hw/02cNglVgzzRSKiKMVHieAuVoB6qIilOW3qXhhBgM
         X+UtWc6PMnF9g1VvKRzHMNxDFU053jTx6MYMMEHnDli1sZLaUaqEmk90S/Gj4lZtCSsO
         w+9Q==
X-Gm-Message-State: AOAM5325cWAR5Y3wxV7/Qn4dN0oAyVJetUv5wGRFdMlB/QJE2LY4OP19
        9K/YHk11JibHCvyHrdIhUaKnLQ==
X-Google-Smtp-Source: ABdhPJziQxoyCTOQu+uWYcATEWIVf2W413EKsvJ+OhevBIrRejTHf3dVPmpga24MDq56YcGwUd2kmA==
X-Received: by 2002:a17:906:af7b:b0:6e8:8123:78ab with SMTP id os27-20020a170906af7b00b006e8812378abmr10912595ejb.434.1649764741569;
        Tue, 12 Apr 2022 04:59:01 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id w6-20020a170906d20600b006ca00cb99e0sm12989864ejz.34.2022.04.12.04.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 04:59:01 -0700 (PDT)
Message-ID: <e278c563-d333-5b79-04b8-406d845ae165@linaro.org>
Date:   Tue, 12 Apr 2022 13:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 1/2] dt-bindings: mmc: sdhci-msm: Add gcc resets
 strings
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com
References: <1649759528-15125-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1649759528-15125-2-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1649759528-15125-2-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/04/2022 12:32, Shaik Sajida Bhanu wrote:
> Add gcc hardware reset supported strings for qcom-sdhci controller.
> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
