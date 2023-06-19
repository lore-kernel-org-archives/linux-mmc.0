Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A528AC001B3
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jun 2023 17:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjFSRAt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Jun 2023 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjFSRAe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2023 13:00:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CA811D
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 10:00:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so4273266f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687194030; x=1689786030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9cC6PmdgFB3dmV/UgdM6HFPYJf6kvpGv+r5GF+eElo=;
        b=pyYJ0ecrVQtXpGNU+ZRJZg3+hbL28pf71ya83iW44CI4j0NNoqmbIrbRrlow45S9lA
         vSPJrD2X5CLDvKHSEKLFvN5yR/vVcwXyitzWLhz8tBvhD+yWTdQK6VvH9bp5vpEezzxx
         sCQM4+SCWwbgAV/ZKNdZDhzC78vKAC12Slsi3TkSOJ65PYzE43P1z2q4/b225YCrktze
         vlpBiCKmaS+4Ibssg9zV3Ap9UlzhIpzbXqriPN4hXJi//cKpvXd7PRgfRP/HEwm1Nn1F
         uY8zKHIhkBEPZmxqi3A8zr2DBF8dN89gm5ObqNvmxJ3SsB3jMNeQ8GbvOnaYDrjIakNT
         GAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194030; x=1689786030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9cC6PmdgFB3dmV/UgdM6HFPYJf6kvpGv+r5GF+eElo=;
        b=CcucEPJA2+853ExcXcNupjNviivcRkiS8/j6BJYaiPrKT+qjfNMo881ilkS+2HR+AC
         KK/sqPUK+Xemf7E/9WwECtQ8i/fIsuLKHL12Fo/fzF8sOif8DaWSVEXHWg6wije/chTL
         hwwMcmcy+Uq+zdPn6O+DPr4VE/KmSnI3fX3OWpIjUX8HT0atTXMmRg2JnBFA7DlG47Mj
         reJ0wgZIEN+w53gnnkVg5rfoa1mKBdt/Qqn6uYUOO7HEX5PynbWNl1H6JXPH1W7QP8/t
         EVRzN7aj4/cKlMG1OYX//0lUWc4dGTM4ucD6LqmC0UM9YndQz1X6ZaPqoZ2Ro0P8Zys4
         iWlQ==
X-Gm-Message-State: AC+VfDz0BeP/UbmfzDWFX7dMnkEdA9SichfyEZx+mxlxXVp+tXZMI0WV
        hxC4rCCrEKew1R6SVBDcqshH0Q==
X-Google-Smtp-Source: ACHHUZ57ZuumhzoQNKjArX+8R9YWVwcao74uXIcV2RWHv3gkjItsMeBZphaKz+rx/tzNZrXtw46azw==
X-Received: by 2002:a5d:444b:0:b0:30a:e619:3a71 with SMTP id x11-20020a5d444b000000b0030ae6193a71mr8985866wrr.23.1687194030283;
        Mon, 19 Jun 2023 10:00:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id v4-20020a5d6b04000000b003047dc162f7sm6308wrw.67.2023.06.19.10.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 10:00:29 -0700 (PDT)
Message-ID: <02d1d74a-1476-41c8-6d94-3eb477352309@linaro.org>
Date:   Mon, 19 Jun 2023 19:00:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 7/7] dt-bindings: timer: convert bcm2835-system-timer
 bindings to YAML
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh@kernel.org>
References: <20230617133620.53129-1-stefan.wahren@i2se.com>
 <20230617133620.53129-8-stefan.wahren@i2se.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230617133620.53129-8-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/06/2023 15:36, Stefan Wahren wrote:
> Convert the DT binding document for bcm2835-system-timer from .txt
> to YAML.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../timer/brcm,bcm2835-system-timer.txt       | 22 ---------
>   .../timer/brcm,bcm2835-system-timer.yaml      | 48 +++++++++++++++++++
>   2 files changed, 48 insertions(+), 22 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
>   create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
> deleted file mode 100644
> index 844bd5fbd04c..000000000000
> --- a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt

Appliedp patch #7

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

