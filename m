Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00715C6FD1D
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Mar 2023 07:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjCOHuS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Mar 2023 03:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjCOHtn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2023 03:49:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002185DEFF
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 00:49:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w9so1134949edc.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDpWcZg4twEdNBGcq0+KsEzyNCUQHbULyPH+z4NvFWw=;
        b=E7GyIClNRbP5bTFjqGupUc/UTTrxHfn0lgI1lnBYnbsASTCSO6EbrXGZiigl/AwhJc
         IYgOc+O+77v+diPYdhj+c5JzavNdcIOXRWzZEtx+L93RcjqmPFkt9NEG6aRJ9zU7NYfE
         eRTjLzpkoPFRWzg8yd97UqPSMYgZsdLSUnJbtkqyxBTnP5vwOBjHOdqMlEP5ZCONGLyj
         3MrGj2E72v8Tq+tQToGXyVvL3h7BsanIqhI8oez/3+0F4xs16RnL/o1KvypV2xp+SbtW
         vEUaA1gKr2opDT7cvYD2a0cFUmw/jmfeVJmsvVzNBqgupABaryeEGq9KnxpOLVUQXFMi
         P7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDpWcZg4twEdNBGcq0+KsEzyNCUQHbULyPH+z4NvFWw=;
        b=chWwLto579RzF0iRNQKcxFvQ7etYDTTHNeimeZKrxQFTjunyBoRtizKnkKhl3+Emu4
         SdiiOxsG5ZzlB+LJlB5SRDHaL0HXNStKru7s2FFoO5KXtmbCC72UiwZEGrTv4DGT/kCw
         36hMpzcbGYPodrv38O8/YpHi7CGirAUWTz/FYi6aw6B78LUNjqQlUBk9GHAXNwhqcYKt
         lbljjZ8KcsAJuJLWtk+ujuic8tt6FBopabDyELPB6IrnCOqTessZGrOn81Rj8VhM1Gp1
         2R72t+3yZw5b8jmK4vEScY+tA6vX4TEGCr0xPNB516dOUGjL8JpHDZCEKtYXtEfALn51
         0q5g==
X-Gm-Message-State: AO0yUKWsjzIsbtOP33asjv1Fio6OEdc4+sBVPl4NUvalh4ZwP/pMKqp9
        j42iXmPXcRfL7WuoeefwRbQHwA==
X-Google-Smtp-Source: AK7set/RAdM7J4v+2ABv6n/FC+LZMZae511W0v8//or7jIXmB6xIKtXurPebiR686Q25Jb3lZZoaeg==
X-Received: by 2002:a17:906:b28b:b0:8b1:15ab:f4cd with SMTP id q11-20020a170906b28b00b008b115abf4cdmr5418394ejz.53.1678866559506;
        Wed, 15 Mar 2023 00:49:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id qa14-20020a170907868e00b008f702684c51sm2105119ejc.161.2023.03.15.00.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:49:19 -0700 (PDT)
Message-ID: <42cb9de7-0dc7-e2b1-59b1-2c6dec1d1f28@linaro.org>
Date:   Wed, 15 Mar 2023 08:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/6] dt-bindings: thermal: tsens: Add QCM2290
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
 <20230314-topic-2290_compats-v1-6-47e26c3c0365@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-6-47e26c3c0365@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/03/2023 13:53, Konrad Dybcio wrote:
> Add the TSENS v2.x controller found on QCM2290.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

