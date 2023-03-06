Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75709C678D4
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Mar 2023 08:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCFIbc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Mar 2023 03:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCFIba (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Mar 2023 03:31:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F987C157
        for <linux-mmc@vger.kernel.org>; Mon,  6 Mar 2023 00:31:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ay14so31394090edb.11
        for <linux-mmc@vger.kernel.org>; Mon, 06 Mar 2023 00:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678091488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Xaqn3Wtp4TVTPrRcIPaDbpDe95HG3mHsonCqLhjryY=;
        b=lqFE4D5RDxbwQUwRZ8A+URmExaOLLdnsTZBl1ZHWR92w3O33klSZ676ADY2Nljnz4m
         wsju6Ze2VRK0CIdJzzAUUKrYHdOSaGlrEcG4MxnHggSekX7qA3gmNVp1ZddS6kF9eGvI
         Z2TFzkmtUYBpfO6doocDeiJuL3f7s3QiUkDjPZLRLW6JS/N0hSxXRFZu3mU3TfwqlOVk
         cWCw1rPUvh1v46d9ql3EIzZtyowp9bDiTeISG9oeBq16Lsc9WG/YiDORAkK5OMJVrDWo
         BMssytDifvDaUM71bWpgZv/3XF6mNSOQjgIn9+YEpt2hZphf3FjvYgYUVltKouz6s73u
         9hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678091488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xaqn3Wtp4TVTPrRcIPaDbpDe95HG3mHsonCqLhjryY=;
        b=UN7Pi+Np5YP9SzRFwlsj0ma42Avv8Bih8BAn9nbLUUJOIXS1nw/9SqUEuAzd4DkMxa
         hWt3z/sHefiV8FmZRqUhdnk2f8Gk5qUzceRyjMdfAaS2d/doT9CEDHUhJgoehqMV/02g
         mu2yf+wiqxuIANFhGtoM9i0lPhmq2se6WfK3qNi1zGfOEnU12JKLpyf/JZyJHkqjcqgo
         RuqCqKrxkmSxTYGUrui8GFgLKb1mlyXybI1RM+9C/Ynxb/8ybOaDWSwoge9iGYSlvShY
         DTziF6jwDliAhU8VvkFjw7FRZO20K6Ci1EowqEo6KWlyHhUAov2EIu7Uc4yXqW0y3LIl
         Xq3g==
X-Gm-Message-State: AO0yUKUaHzrVxEN4tlKSCSYXIS/Lrs0aTDCVDAfvn9GpdwhuFBQU7Jg6
        q3sKPxV+xFYRXTN3+QaIw8IV2A==
X-Google-Smtp-Source: AK7set/cax5hkkYB7Y6YQ2meozWHhmJVvLlifpdJfjX5Gbu40+9X3wFOrjunz0pSeWuo6UQ2KLuSjQ==
X-Received: by 2002:a17:906:308e:b0:8b1:3ba7:723b with SMTP id 14-20020a170906308e00b008b13ba7723bmr9319991ejv.30.1678091488041;
        Mon, 06 Mar 2023 00:31:28 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id y4-20020a170906524400b008d71e08c78dsm4192265ejm.81.2023.03.06.00.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:31:27 -0800 (PST)
Message-ID: <d54b644e-bdf3-7459-4f23-187dce78344f@linaro.org>
Date:   Mon, 6 Mar 2023 09:31:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230306040739.51488-1-blarson@amd.com>
 <20230306040739.51488-5-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306040739.51488-5-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/03/2023 05:07, Brad Larson wrote:
> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

