Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347A6CCA47C
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jun 2022 06:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiFGGek (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 02:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbiFGGei (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 02:34:38 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A83326E4
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jun 2022 23:34:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id me5so32588510ejb.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2022 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BS02hl5lG0fU1teehsFBTzwy9idYtqKSriIvuXGDAVw=;
        b=a7CXUgo1LhI6a6Wn7l3MjaqsS2nWFcnVUfB+fpGL3Su3s8vvd+hexirjTkuKfqfJku
         tpNMIqWEqQEc2ykTutSqnsatSkZguMPoVRX3zgp44CcWRwEfmM1O1H6YW+PdMuDF7l1h
         GQ6t7rKl0oPrV2wyje3dJJlB8t/G+d+oEPBjgNvSx5jNjOGBUUFO1INCvt51Z5vD9upr
         zpEb/NvfB8O/xEMwCpBTttttkHN5KejGkpvAyS3ebegD2zJBG1dA9Qz1ci0llYeESeo+
         JMbAguBqPVrXMBWFpgVz6EOSHE3P+6K+R88uzWCgJV4Flf2vyjRbzalZP0Jxm4TrIWS4
         iuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BS02hl5lG0fU1teehsFBTzwy9idYtqKSriIvuXGDAVw=;
        b=e3yDvDMyFO3oKpk+q8cR0bWLDnDdIdW8W/TcuNcN4ms4pHHYIoMUMaYcAj+U3oaFF6
         Hm4C5boI34jIYWndw4OaOqQ0a42w8M6rpw5LNyvfAH0VDLuhSXeNitLhqzQPLARDBlJb
         gEf9HKHb0hky/ozCyuNI/tzPUO8jgCFU/Dlr6sfOc3S89NWeCWF+GwE7IFdz3S6vpq8u
         5UDimNVJBDLyGFHNpMJRCZLGUXy2lpWPWT6b/JSX2BALu1ngw1hp8adISnbqJlTFhm5s
         FvxTzhMhIqLoIpNMcBkOTTlN9mL0utcyFqjG+YMheG8kUziJ1luokAA0rZviAiOEmOqa
         +9Ug==
X-Gm-Message-State: AOAM531G/ztZoYSYirRA4mN1axgHEk9+nKB0/B3DnMew1KSJ1KfLylNb
        dHFFY1Jj35ACTvdr5OHwn7/fQg==
X-Google-Smtp-Source: ABdhPJxeChl1qKeEil8PnLVpGZrlHOFtfAIS6W5eozpO3H9ZCDC+R/hedgSwKsMBni0ziaZVCtATcQ==
X-Received: by 2002:a17:907:7e8b:b0:711:e5e6:6694 with SMTP id qb11-20020a1709077e8b00b00711e5e66694mr150753ejc.35.1654583673038;
        Mon, 06 Jun 2022 23:34:33 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id me3-20020a170906aec300b006ff01fbb7ccsm7153425ejb.40.2022.06.06.23.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 23:34:32 -0700 (PDT)
Message-ID: <717eb4d5-f547-4763-1670-51e90cbe0803@linaro.org>
Date:   Tue, 7 Jun 2022 08:34:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: Drop more redundant 'maxItems/minItems' in
 if/then schemas
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220606225137.1536010-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220606225137.1536010-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/06/2022 00:51, Rob Herring wrote:
> Another round from new cases in 5.19-rc of removing redundant
> minItems/maxItems when 'items' list is specified. This time it is in
> if/then schemas as the meta-schema was failing to check this case.
> 
> If a property has an 'items' list, then a 'minItems' or 'maxItems' with the
> same size as the list is redundant and can be dropped. Note that is DT
> schema specific behavior and not standard json-schema behavior. The tooling
> will fixup the final schema adding any unspecified minItems/maxItems.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
