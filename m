Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686F2C61D97
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Jan 2023 10:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjA2K7N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Jan 2023 05:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjA2K7M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Jan 2023 05:59:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C726198
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2023 02:59:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l8so6234500wms.3
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2023 02:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+zi+I11015NCUz0N7y9W3Jr+WUdrxDX5W6xHsycXDzg=;
        b=gk6FTivk4VcbuaMCSGe81Shm6BZrMVLoA/c6PNQ8p73ukV1e8JohvkLCIet2jVxVsS
         JRgrsChaBxFOcU12ZvDkpqiOYtYm6eSgPAr4z2NwPjWCQuAR2z97Gz1Vr+GNqF7DM2KS
         uHqvi4cA+E+bJKAo7bPQjJmj8ugcHP2aBlIg5Fyus2uBCLEbTzOPkPl/RDkSPOnBLuz/
         +wuZf3xRdn8qMqj2+Rc2ipNCHwhFHn0mgq42G+iAEkyxFkk/PSvKyXv+WKiVvGbpY4uQ
         9uiN0AcA4n7uFo791Paac1O24+9lxsksbfYd7YsDklQezwB43/JcRVHgPIO5E8ia6Itr
         UJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zi+I11015NCUz0N7y9W3Jr+WUdrxDX5W6xHsycXDzg=;
        b=Sk+VFt9M9rmFg4sckRpuA11bi01eHP/O++d4oXSduGHDVbGb3Kyj2Egm1qx/AmcHu/
         jrqYbSjFhHdfxZRInMUwG0wO7byxMbxjtF/4u+Eqw6H82jFwM8VWwyYWyLv5NsUQX1kO
         mWgPiESTy9j2wwV7qfQRBZtYAv+fv1Fy6dZty5szRs6gAQ3DvSXl2mzvWCo0/wJxiUkk
         6F3+jkswQ++/31HpkHpiPQxGKjrrURHg766250p9aiD/Tz4po0NpgfcSI0OfnvGVSJye
         V8juwSiV8creCsJe7CAxBlbz/IuVY/ms8RKeYYr15ZMEvmtggdgcW96cQe56mu2oKvFk
         3D4g==
X-Gm-Message-State: AFqh2kpsjhL6NkxBSx2H7+fwmv7KEYulPARbLEZtCYHoRhOAv7NUjnGc
        pdtJw8MlMmZ9Hyalsvr3xTIVsg==
X-Google-Smtp-Source: AMrXdXvKeCcJ+95HZDpXVnnwC9DcVbaPjo0HvSb+0omSgwO9b7m6BRzYzDDtVF1EHm+W2nUkVgfyfw==
X-Received: by 2002:a05:600c:4395:b0:3c6:f7ff:6f87 with SMTP id e21-20020a05600c439500b003c6f7ff6f87mr44584001wmn.11.1674989949734;
        Sun, 29 Jan 2023 02:59:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b003dab77aa911sm15240955wms.23.2023.01.29.02.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 02:59:09 -0800 (PST)
Message-ID: <b43f26c9-f76c-c898-aadc-ce3ee7b7823d@linaro.org>
Date:   Sun, 29 Jan 2023 11:58:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: mmc: Add cap-aggressive-pm property
To:     Hermes Zhang <chenhuiz@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230129023630.830764-1-chenhuiz@axis.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230129023630.830764-1-chenhuiz@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/01/2023 03:36, Hermes Zhang wrote:
> This commit add a new property: cap-aggressive-pm to enable the

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> MMC_CAP_AGGRESSIVE_PM feature for (e)MMC/SD power saving.

Why this is a property suitable for DT? IOW, why this isn't enabled always?

> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Best regards,
Krzysztof

