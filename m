Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742CCC6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 20:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjCLU5l (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjCLU5k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 16:57:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7859D2884D
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 13:57:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g10so12166900eda.1
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678654657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PoQt8tnkXKFkle2nsFjlv+Leq1xO12xTC7tQfURtys=;
        b=AmTW0ByObVvtm5bZWY8jIKiocqRWWVwhjzjEpZ/ZrwMrj8Ee6O0/RrYRDSpHu/IrOz
         UVv8mCknuVLmmqubBs6xcWTJMYCULiopzlOUSRa+vDz56p01QgkpQdepr3asfrIyZs8X
         vG6Bw5PTA6pymZtmwPa74+clo0/hgGwQjvUgaGUj7f4g786n+nxkWxgOuNo+s2Vy6XUP
         xOe0XlLCDUeqjeb1Yzwz7rpzCgs8L7B5onCoB7jo+PdMNcGeQAjUFuIIjLMO2UzrsDeZ
         agno+TquSgpED8zDFQZUCJ2lB1M6eGhbShEeJwoOKafNrwxNR6lE0IC10d3zvdTaJTNv
         JFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678654657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PoQt8tnkXKFkle2nsFjlv+Leq1xO12xTC7tQfURtys=;
        b=uNu2tE3a7tSGUpOYRzMZpLbZf3kMEl1qxobSjRuqNhdOIpNepbxz0mcPltc9auDVKa
         xRDaDdo4rwoimTD8hCpkippFTrzEsjx6ZWeIH5uXZdS7yOQxG+xMgJPR/u8kfbLpiIRB
         eh2FFkX1oNyFffgddkLPqyVcKBSZk9v67pZPLvJsbn6tZT6uHJjSW9ZujE4pA8p+xQ01
         63K4+V3vGn5tWKdbOl3S9SVKEQIIgKdyGaFmapXUdf8xFGcopwdytLiR/rrRheP/F3Bx
         f3yZymmuEE4rG+o2+Dble2mh+1R3Ra3XfdFg0ft3WepG8HkRa+K5u2RE6Ct+SC0fqa4/
         gBHg==
X-Gm-Message-State: AO0yUKW+uHaXsBcM630GwInRg8bTEMzskUrFZrh3NuhsZyQd3POgolwk
        lMrrLhfxCCa8fi6Xs4/FKj4UXGq7uq9wImyFvlQ=
X-Google-Smtp-Source: AK7set8Mh3dR0JfMQ5uQ0962ETnZOJomBpmSYK2P/lCcIeZjkKxhLtxE20WjEmRovBwoA3j93hnYjg==
X-Received: by 2002:a17:906:2b99:b0:8b1:fc59:a22b with SMTP id m25-20020a1709062b9900b008b1fc59a22bmr30784083ejg.34.1678654657019;
        Sun, 12 Mar 2023 13:57:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id jg16-20020a170907971000b0092a59ee224csm181341ejc.185.2023.03.12.13.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 13:57:36 -0700 (PDT)
Message-ID: <0e612225-c821-4c7b-dd88-0ab7c88639ad@linaro.org>
Date:   Sun, 12 Mar 2023 21:57:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 03/15] dt-bindings: spi: cdns: Add compatible for AMD
 Pensando Elba SoC
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
References: <20230312004445.15913-1-blarson@amd.com>
 <20230312004445.15913-4-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312004445.15913-4-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 01:44, Brad Larson wrote:
> Document the cadence qspi controller compatible for AMD Pensando
> Elba SoC boards.  The Elba qspi fifo size is 1024.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

