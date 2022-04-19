Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376FAC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Apr 2022 07:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349478AbiDSHl6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Apr 2022 03:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbiDSHl4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2022 03:41:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C8A2315E
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 00:39:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u15so31055442ejf.11
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 00:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VLisSl5U+vKxlHEi2jsM/uSr3AGr/yP0sJybyysl56g=;
        b=yhRa2r+h7pBhcGnBWVIHpJG0E/SOWXoqFnTw3vVkDbqAu2k06J9tva1bu9Gzy8svwt
         RDDOtKw6Ax76s6d+eUgDVvNOJts+MrTULL2DFF1sVFbCO14c9JuYFZlE+tQ6OaWWj4rJ
         MDh/hhm3ARFz9nSIV+ApMaBnQGHNzRCs8RpWSwS5opbK18cvqlOusgki1VmUAbAAGtP/
         uNywTFQym1ZSuYElrz3xe9L+S11YOIR08iBK8Ys7gyMCv9pTP3l0RVEEOaRzP1nyDusP
         TYNKOb5jFi2s31EkaE4C2CywX/eqzb/G0IkYH5t+A7zydquSQYhsnbvwVyPWT3JvBkE3
         fi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VLisSl5U+vKxlHEi2jsM/uSr3AGr/yP0sJybyysl56g=;
        b=fAYdU9bjcaYzwjGDZB1HxH+jyPFh/zEWqrNzr2j/PsXUaVaQ1Tmjwq3LH1eSnInsmN
         GV+QyrGGFFlY+5IrQqh/30y6jjBUbELBrDE+P9a0xNzVTm3F4QtsaRkjNfwLNY0s5OYT
         Gx1gXC0a9cy1bsl8CXxq0fBbWGB0luzUz6S5zmzgfmabD+mufuJMcMBhwlVBHn58LvO1
         a5mTIbPxqLcYuWtbyykpBxObFJURb8uFkDRmq8/Z4A1+l4hrJarkkSjA1C6Iai0EGHKD
         anc0EecL9Uoyh+JUSsP8e6BPttONQpcR5+oL0C2/p+Zf5stpKbM85T/bzIYYOUoCiu5h
         H0og==
X-Gm-Message-State: AOAM533Q64njm//0LoU7QGZxI02Tw+AePaS+Gdib7MoZmH4RFMbtVm2N
        dX0bZywdNPnANodU0B3nv/OMFA==
X-Google-Smtp-Source: ABdhPJxYJtMgm7zv2VVxzftlKaF5M9cx1/oldQIn65xu7uNBz/9QCwQqmCMMn0/X58ekbNYbUVX2rg==
X-Received: by 2002:a17:906:5d11:b0:6ef:7bdf:e976 with SMTP id g17-20020a1709065d1100b006ef7bdfe976mr10374713ejt.743.1650353952960;
        Tue, 19 Apr 2022 00:39:12 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090622ce00b006e898c912e5sm5352866eja.217.2022.04.19.00.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:39:12 -0700 (PDT)
Message-ID: <59cda570-2a78-0d7f-091e-02e837fe9ec5@linaro.org>
Date:   Tue, 19 Apr 2022 09:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] dt-bindings: mmc: convert sdhci-dove to JSON
 schema
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, adrian.hunter@intel.com,
        nico@fluxnic.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
 <20220419024611.1327525-5-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419024611.1327525-5-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/04/2022 04:46, Chris Packham wrote:
> Convert the sdhci-dove binding to JSON schema. The optional clocks
> property was not in the original binding document but has been in the
> dove.dtsi since commit 5b03df9ace68 ("ARM: dove: switch to DT clock
> providers").
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
