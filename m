Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA518C6FD19
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 18:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjCLScW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 14:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCLScI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 14:32:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB6A2057B
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:28:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r15so13018957edq.11
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678645630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uklOMUJVS+u74q2lNQ2L3Oa76MwPD6cKkPZXD0PzvOk=;
        b=VIfbhuOiC55FZDLYcPfjNZsPqWscHGe2nVlxhOJuMQf4q7XKnVlx6DMB5748VIYjI8
         6HgcY4aXvll5wLHtsSxw0/pvMXZKZuuggFVG+B1Ua6JJbr/7Ry5RmT7fPiCotTBEYYic
         iA2rrQ946ZJUFTG3K782eMKqOfcz6539HL74wxOriYtVRIqY564Cb56J7GcmejZTqDIA
         oj+744qKgJwOxXmTF9qBUmv+GFsqpUDGvcxigMxksqxRkkFJIoogJkK7XhCBzgWbhDws
         tejqrXGkK8qMmiZVQOtJTTN9Wo/i0nEKgaQV9IyV+1rDRjpcg4tQ1UI8UL1684v0SfNQ
         B8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678645630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uklOMUJVS+u74q2lNQ2L3Oa76MwPD6cKkPZXD0PzvOk=;
        b=LbSsq/dtw4Jqasn7KTWEUc6/6jeL3l8X3GqP/MINuhGwLWGXoonPkDlJ/SrL8PFyCb
         gmagKxwNEZpt3/RR50Nsa0ZUO7YjDFh2KhyR4ckRP17cqFIXJtvVEMXNZuhToJOKERC5
         +25yLJb0JysehfVY7E2ll33qxJzYGMR3/aG6rSYMqEv/GUcj5xo4606dVC0TEQUWACJG
         R1P0TRAY7+sowUv35uzJOfCZ903+57Ehex0ehkEyk3wpXQdEvHM36WCybteLhXYoLj5i
         rHx02bDV7KsHeBjfo3rXLsUmcGjfibe6eu7knFH1ipvsqXrlqHY5Edrmk8hyyyh0bY1i
         zT5g==
X-Gm-Message-State: AO0yUKXfKq4WJ/mnWGqtq7z25KS7Jxc40LzrhCf5pj2VURw69vd4N4e3
        KqfSDfi1o89PMzmr5m5OlTVXQPiOZOjsq9GYdME=
X-Google-Smtp-Source: AK7set+wLPwfiYTBJKHeb6798JXdZToZ1wN8CLYiuEE03LcKlvgRWrhC81BlP33K3TpRYzt56OBfGQ==
X-Received: by 2002:a17:906:1604:b0:8af:7b80:82ba with SMTP id m4-20020a170906160400b008af7b8082bamr30601317ejd.20.1678644712043;
        Sun, 12 Mar 2023 11:11:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id b18-20020a17090636d200b008d0dbf15b8bsm2441348ejc.212.2023.03.12.11.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 11:11:51 -0700 (PDT)
Message-ID: <f0f6d714-f35c-fa53-f9bf-44cd4baa4aea@linaro.org>
Date:   Sun, 12 Mar 2023 19:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/3] dt-bindings: exynos-dw-mshc-common: add exynos7885
 variants
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1678644516.665314-1-sleirsgoevy@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678644516.665314-1-sleirsgoevy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 18:58, Sergey Lisov wrote:
> Some Samsung Exynos boards using the arm64 architecture have DW MMC
> controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
> systems the 64-bit FIFO registers must be accessed in two 32-bit halves.
> 
> Add two new compatible strings, "samsung,exynos7885-dw-mshc" and
> "samsung,exynos7885-dw-mshc-smu" respectively, to denote exynos7885
> boards that need this quirk. But it's very possible that all
> "samsung,exynos7-dw-mshc" boards are actually affected.

And now this is third copy of the same email. This is not acceptable.

Best regards,
Krzysztof

