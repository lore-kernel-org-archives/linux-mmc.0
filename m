Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFFDC76195
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Mar 2023 07:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjCOHtY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Mar 2023 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjCOHtP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2023 03:49:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC1062FD4
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 00:48:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn21so41751303edb.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iMt5vfS6366Di3F0rCHYJhoOUmHVMakcsWS0XE4JoQ=;
        b=wSb6oL+W8DvC08twM/z9kHWm1iVmnvV8NM2y5B3g0YgmaS1cFb+p07CXvHeL3sWgVz
         2iyfEf13uJESqat34LJDKuTq4eJ/8W2dccXUHUTb2d1LeJ3ZHbVNk0T9NwgEKNQNf+9v
         /ajsqjQ950dDvl+PD5cgnmF72U8H5nO7APZ6nTRGegAg+GMf/Xd7g9+YR7rs1ByCIGxa
         8hLFsd9PNrJXxSJnCjltx7ltscRt/1KPMBn6ymtyOFk2xVNIXu3QMG9wgnVZjdS7tG+d
         z+B0UnSGebT25wn8zrZLZwYoxW1WFp5uyey6ayH/dA02QR1KwQHhzISOgH7ar0y8WsJp
         VkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iMt5vfS6366Di3F0rCHYJhoOUmHVMakcsWS0XE4JoQ=;
        b=RVAk2U7xyggUVH3jYTQ8Hj5h3hu6mcdcJmsQmizxdqtoTTLstBvZU+Bn1VzpyPrCB/
         7zXb8BrWAk1xStPO2fF31cBroqqdIrDqk2eh1BmeEe8Dwz1O/Fm0XbW95feH9J7FjsNp
         A9S26yBIH9BaOts+bXw80gsfatPPhFOAc4YRl2Ocf2D5KenpQNEEdAVf1ZmgCEBmq/eq
         0lkdLwW+2LO8H6K6YY6EEhqk6hgktxAhh4TpFa2JyguGNsro+JQwXK4h7h9iTunHZ4LQ
         b2N7HrmQDQ6sDaEX9GbjEDrETaK/Jm4vNsgRfs/Z0GW89B2/2hskmM/nFlU4QHUb28iJ
         tU8Q==
X-Gm-Message-State: AO0yUKVskoUoOcSRKXNRGU+ykqfnEXsX0GGpXvYXI3ctYjDe3CHgqfFN
        IKkB6J7/ScCMdiAWGRdNQTZlNQ==
X-Google-Smtp-Source: AK7set9pfGPhjrzpxbYlbNLONtnNwMYkwnxBuIRCdPpg7Gr/DFUMd3ygMUOjHlJeoSzhhNT3o3CLVQ==
X-Received: by 2002:a17:907:76b5:b0:8f9:ed75:f962 with SMTP id jw21-20020a17090776b500b008f9ed75f962mr5383507ejc.18.1678866528996;
        Wed, 15 Mar 2023 00:48:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id v20-20020a170906565400b008d427df3245sm2129172ejr.58.2023.03.15.00.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:48:48 -0700 (PDT)
Message-ID: <56f907f7-79c4-94fe-b29f-ff71390615b1@linaro.org>
Date:   Wed, 15 Mar 2023 08:48:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/6] dt-bindings: nvmem: Add compatible for QCM2290
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
 <20230314-topic-2290_compats-v1-3-47e26c3c0365@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-3-47e26c3c0365@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/03/2023 13:52, Konrad Dybcio wrote:
> Docuemnt the QFPROM on QCM2290.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

