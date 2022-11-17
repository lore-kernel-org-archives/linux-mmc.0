Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E792CC4167D
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Nov 2022 14:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbiKQO7O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Nov 2022 09:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbiKQO66 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 09:58:58 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D5474A84
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 06:58:53 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id l12so3209395lfp.6
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 06:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSnIdJlrSu1RqwxbrwymcRNJoSgT34DNNQH025cvo20=;
        b=Ur9szg1DKJvl3ubQjvlChH09oAO12tYaDGESWoJRFs5nbTcgL70iq6Rk6jcbyh2eSV
         5sIr6XHiZbOMcG5vg6LYzpKXTZagjOTTXivxVfplX5GAD0O1/9QIYKFbd0XkOcolglVT
         VrJu0CgFgUecUmcpa3we0bBiZQmSB6sCWxEucrm8wK9mxNNpZRyq2THIgu40f2wTK8zo
         2iE5ibWayllqwdjGN++kkVQdW9OgLgRj0+rBH5OvzcLsoNEByi9LNspb+2B+W5wqkM41
         Rwzp9Tu2wWCQ3oQ9fSXsHYYSxRuw8yfwAEchPTid10LtcwGqSDyeXQdG7IyHwjOChaWM
         86bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSnIdJlrSu1RqwxbrwymcRNJoSgT34DNNQH025cvo20=;
        b=wLragwezRm/N/sEO5OpMs09C8rdXmgjOAuUDz08t1F5/QZ0WZzr2QHHXP3+tbfw8KI
         g6m30KrGzWvRCTjFCELPyh1OGB1nI/UlDCwCY64Lds5LdSoxhtCVKOWcoK6wxXDHO01y
         hoP9wwtBHbl5HMzbi3NAoRuIlUC4J3Jnl728Ak676P6JU2P7BFFSlqdH39eztTV1rm2Y
         k8TKlLQRK9/KmDgm+8PSq2d2CCdtzOSIWT7Zlb2pvgIv9m9vSpTnOtL8EiMxStALVRiM
         GYsZOxFOHkpTsmSo6L3Jl8Q/rK3yssFh85KL3GF5QKdJC8OXEy8De9+YhHOmnBU28uyp
         +d0Q==
X-Gm-Message-State: ANoB5pmltG6yFH/C+yh+43LI+jENuBtrjU+a6pJJBOJ3DLGo53FsgnXx
        /1IyHinkRspZqnluYECrNoRhuQ==
X-Google-Smtp-Source: AA0mqf4/hs47bXqsUk4ZLu/jQ1Wna1nuVovn6G3NWi6j/M3148XUWs2V/ZZa76pyYbEsKXo3MQAsvg==
X-Received: by 2002:ac2:4a69:0:b0:4ac:d080:e1bd with SMTP id q9-20020ac24a69000000b004acd080e1bdmr1120397lfp.318.1668697131665;
        Thu, 17 Nov 2022 06:58:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r8-20020ac24d08000000b00492dfcc0e58sm186892lfi.53.2022.11.17.06.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 06:58:51 -0800 (PST)
Message-ID: <2f35b9aa-1385-9c2b-ed60-721a835645dc@linaro.org>
Date:   Thu, 17 Nov 2022 15:58:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 1/9] dt-bindings: drop redundant part of title of
 shared bindings
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-watchdog@vger.kernel.org
References: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
 <20221117123850.368213-2-krzysztof.kozlowski@linaro.org>
 <Y3Y1xjOjijBsQLZA@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3Y1xjOjijBsQLZA@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/11/2022 14:23, Andrew Lunn wrote:
>>  allOf:
>> -  - $ref: "dma-common.yaml#"
>> +  - $ref: dma-common.yaml#
>>  
>>  
>>  allOf:
>> -  - $ref: "dma-common.yaml#"
>> +  - $ref: dma-common.yaml#
> 
> Looks like some other automated change made its way into this patch.

I forgot to mention in commit msg, but maybe better to drop it to reduce
noise.

Best regards,
Krzysztof

