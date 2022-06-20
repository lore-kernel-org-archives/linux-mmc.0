Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C70C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jun 2022 12:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbiFTMtC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241625AbiFTMtA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2022 08:49:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07A9A18E
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2022 05:48:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id s12so20911042ejx.3
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2022 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=25MF9bCZg+nfQVclxRAj22UNao3u9KJnaDQNqtN7pPs=;
        b=y/SePXg4BKIZ2rCBvahqjNHAYrm/fPndCXouPWVx21VOCzQasCbuZb3zCrxchlpc6C
         iNLqkwLxOPlBIw0Z3lSudBi3E6/djVe18sB4x7j031BQDualuu3SkuBoLGffP1aJP6Vk
         dLpb83sPdfz0c06+qNqCPQpckLtIppBn1XoFBBk+ydk4ngQhtd0ymBcqHiSGvBkI7C3B
         4dgJcUNJhfzGzr0Hy9JYSkN3oMtvz6UHUJ/fttdDE0oYd4BUTsAlwgOUJJ5Jr5tP6Aam
         uyhxv7iZ6u1aNkjYChtk8ixoil/arL/mZr84aDEj9oAa7Zfqo+B2EgB+SYztE+GhB2mt
         H7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=25MF9bCZg+nfQVclxRAj22UNao3u9KJnaDQNqtN7pPs=;
        b=GIBFK0Ypkv2wQhwlX6X5Kx10qmq/SOsvAaF4oS6pMttZN87QkNqlvk0ukxEl0gSZ7C
         tGExAU7c/BWVZeNrg0aVb8FU8drAXF4az7FwRlnXNZY084TbcxweKFbGcy15DoX4vrbt
         QJQipjDpvDSRIHLRRCeghsG77IUgu5CJC+dmVrIKHL1q8bnkSXlz01GSmqPLibbX565h
         2H6WqHhoHPwrVbD1UvuZA8tOCp+dM3/j2Xw5VOhbuIfadBAi1pE9w73e4RtC2IrCqSHG
         OOXFsqvLHFsoFCEViG3LMiYBDkNg8Ep+VCcwq2F3s2c2PZT7wMRE2yIza6LJFfJdYXGy
         GC+A==
X-Gm-Message-State: AJIora80v9PqdhmuvRNX3c86qNkOak63dZb7AVc6ZHUh/Fb39K3Ta7fy
        7qSjFplDTCpa9NJZE9hgZWaEDA==
X-Google-Smtp-Source: AGRyM1ua+PHdvFVhKnc7bKaPda6LbhC16pScYCj1ebE9gDhAUmRSsupGeC4bFEC3ObLAmRhQDhE/Tg==
X-Received: by 2002:a17:906:4f:b0:712:af2:29d9 with SMTP id 15-20020a170906004f00b007120af229d9mr21303926ejg.751.1655729338197;
        Mon, 20 Jun 2022 05:48:58 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090653c300b006fed93bf71fsm6051568ejo.18.2022.06.20.05.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 05:48:57 -0700 (PDT)
Message-ID: <655c8da3-e4ad-b971-39e7-3d69b4dcd241@linaro.org>
Date:   Mon, 20 Jun 2022 14:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 01/15] dt-bindings: arm: add AMD Pensando boards
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, ulf.hansson@linaro.org, will@kernel.org,
        devicetree@vger.kernel.org
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-2-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613195658.5607-2-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/06/2022 21:56, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Document the compatible for AMD Pensando Elba SoC boards.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
