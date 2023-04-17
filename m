Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062CBC77B72
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 06:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDQGW0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 02:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjDQGWZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 02:22:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2348E3593
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 23:22:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a5so4690652ejb.6
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 23:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681712542; x=1684304542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4Yco67CZ5Wiqh6xlkC+dk0EOaH8oJH2a8u5ODA10rk=;
        b=m7XhJaTu913AC9IRLUZQvKowNigNYtCgKjL8oKu8LXsNadzdKuwz7yPMhIsar8uYRU
         wP2pfdVXjtO6IVi3DOvx7ziMB6yR7gM+XAwhUvWzYpdGtrX+/IbWRUqkeoj4WspxbFZi
         7t1DL0zMX13uLi/wxkXntZAGyFZyW3lyqQr8v3RmLmS+DkMclQ8A7DlgsR+x1qcZDYgo
         /IF+Hyy7Wzu08mc1VbDPI5y5HMxfVz2IOZQoRc8aVmrAJBw//wFMMFQ9NWW905ZeRLp6
         myjZQay3qMzpbopuUZM9ZteXb8rcXbz/vwMVWHqR4phhNuOnuf5n67c1U8LdsxulslAC
         iIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681712542; x=1684304542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4Yco67CZ5Wiqh6xlkC+dk0EOaH8oJH2a8u5ODA10rk=;
        b=k6O692AeCjfO+G3+JaHbi/VqiCHlfTskQO0QQzqt7WOTM6kNQ5prYjJ7TebCB9cftF
         fPMWBApedbVMumYpGU8LVOH/k+OmoUsSPf9mvYLyER28w5kOq8JychQA/4kHR0uhsCnh
         Tyz39PV8Y6oB1RxTTtNEC0KjS0iXWbmC7baxAKnlHuOyEzC2p+RFcMHRBS09Cyp//Hxs
         dxGTk7NRdjGiqzQjoDGWeo8tL/cBur9wvdxPKiE/gZ8a2ew60RXYgzJj0ejJxqNeC/1E
         Ooud9jh+1FEcAxac+umIDZAdca0K+y7i1kbNhDpFzfe8je0z6Z/5EH2uLMBMbNjBjKOu
         s98Q==
X-Gm-Message-State: AAQBX9dcB8XyjRHkn5x4ETrQsvwrCtK6y5rRIjMBFHu0q4oRfb4RA2WJ
        E2jsOV2NaIXXeJ2+2QrioqojWg==
X-Google-Smtp-Source: AKy350Yr+G7OTiYUxQowTuWQvBnT6MkVGR0h+w9EiaAjTU+EhgXnVhXOHwb7DZ31iU18wbhuaVvHmA==
X-Received: by 2002:a17:907:7b07:b0:94f:21e0:7e5a with SMTP id mn7-20020a1709077b0700b0094f21e07e5amr5384920ejc.8.1681712542665;
        Sun, 16 Apr 2023 23:22:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b0ac:4d3b:966c:b33d? ([2a02:810d:15c0:828:b0ac:4d3b:966c:b33d])
        by smtp.gmail.com with ESMTPSA id wj7-20020a170907050700b0094f3d700868sm2295464ejb.80.2023.04.16.23.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 23:22:22 -0700 (PDT)
Message-ID: <5d4d02ec-f8e7-c931-aebe-6255209fbde0@linaro.org>
Date:   Mon, 17 Apr 2023 08:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 3/9] dt-bindings: pinctrl: qcom: Add support for
 ipq5018
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-4-git-send-email-quic_srichara@quicinc.com>
 <536ed00f-e252-c8d3-e3ae-9bb9bb79babe@linaro.org>
 <9e977da8-902a-74d2-7cce-74669b127c30@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9e977da8-902a-74d2-7cce-74669b127c30@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/04/2023 08:13, Sricharan Ramabadhran wrote:
>>> +    tlmm: pinctrl@1000000 {
>>> +        compatible = "qcom,ipq5018-tlmm";
>>> +        reg = <0x01000000 0x300000>;
>>> +        gpio-controller;
>>> +        #gpio-cells = <2>;
>>> +        gpio-ranges = <&tlmm 0 0 47>;
>>> +        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>>> +        interrupt-controller;
>>> +        #interrupt-cells = <2>;
>>> +
>>> +        uart2-state {
>>> +            pins = "gpio34", "gpio35";
>>> +            function = "blsp2_uart";
>>
>> Does not look like you tested the bindings. Please run `make
>> dt_binding_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> 
>    I ran it against the TOT, will run it this time on nxt and post V4.

I don't know what is TOT, but this would fail in every case on every tree.


Best regards,
Krzysztof

