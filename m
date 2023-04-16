Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25842C77B61
	for <linux-mmc@archiver.kernel.org>; Sun, 16 Apr 2023 07:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDPHgT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 16 Apr 2023 03:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDPHgR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Apr 2023 03:36:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640D189
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 00:36:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so49369266b.0
        for <linux-mmc@vger.kernel.org>; Sun, 16 Apr 2023 00:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681630575; x=1684222575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KT6ds4r+t0E7ayy20d8041ijDjDVcqQYBYne/WH971Q=;
        b=ZUefnxGf3uwiTnwbQHt23i0ynkK3Ie/1dRfIVfuL/Haj85OqjPvhUh4/yySsNsjyYk
         NrGnkGvDUJlehsGN3KdDp8ohqT3pcNw84cH0pnBgjBL9xCqUz4pYqJQP7+YJw/mZ88dU
         i3QL+NfsOE9AqtjAFkBmK6GzQVWgLjpm+2O/PH8X9jgoG/qErLBaowOCv0iH8ZxkJIzD
         Te4gb7n+602eGxt+mZppFpXXKpGEQPZgQvBBxQqIiov2iVs/5gxOqemfjZoK8q+E/BRt
         rTe6nGDQRg8+KpYE37v91yOotTit4tmGIw290XOdbRNaaco7MczRMMLZiJEzWXfIkTht
         TFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681630575; x=1684222575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KT6ds4r+t0E7ayy20d8041ijDjDVcqQYBYne/WH971Q=;
        b=Z/TpiRY694zJX4lTJWsZTpyH7M50B9hvvq8GMXUagZafXhnLlTctPnHDnITbVaGhkK
         7L+AUtbmV4lxeK+T15wVpy+SAJ+ra57v6bDSgjBSL5G7m5oBcbxB2Yc5GyQC6vqWAZA1
         hL5/FBB7GU9JSnx17pNf0YHb44R3Opio+/vvfshEVoCbj3BnGn+Sxts65DED1Hq+m612
         siyaaXGcXijlNmLGT5xFWVhqIHJ+RuLL37TsvKLIJJZ/A5A1/0rDqXNk6hg8xC1UKT+0
         wmpp9GLkKFH5uxDr3rRGKPc50XUDOFOXB1gwdkqXEcGOffYQ8t9Z9ujjJyyeAFnT0KoF
         kg0g==
X-Gm-Message-State: AAQBX9cqkEXamd18Xic+W820JDOXrVBn81HPl/2UhSsTcXEgEalaCSbw
        cMFHhSHnyVLdMojQS4XFaAivsg==
X-Google-Smtp-Source: AKy350Z2aww6ueQ2QXHv9VW/GbvbBi6FPFiYc7YAz5ZKFZ8NlNMWifqWm2wp7e/PC8O1NSVBC0fDYQ==
X-Received: by 2002:aa7:da8f:0:b0:504:9ae7:f73b with SMTP id q15-20020aa7da8f000000b005049ae7f73bmr12695250eds.2.1681630575085;
        Sun, 16 Apr 2023 00:36:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id p25-20020a17090635d900b0094e75d3ba1bsm4756890ejb.131.2023.04.16.00.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 00:36:14 -0700 (PDT)
Message-ID: <05fbaaf6-3e0d-5d42-0645-587d8555065a@linaro.org>
Date:   Sun, 16 Apr 2023 09:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v2 3/3] binding: mmc: hi3798cv200-dw-mshc: convert to
 YAML and rename to histb-dw-mshc, add compatible of hi3798mv200
Content-Language: en-US
To:     forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v2-0-1d274f9b71da@outlook.com>
 <20230415-mmc-hi3798mv200-v2-3-1d274f9b71da@outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415-mmc-hi3798mv200-v2-3-1d274f9b71da@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/04/2023 19:13, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Hi3798MV200 has an extra clock, also document it here.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/mmc/hi3798cv200-dw-mshc.txt           | 40 ----------

I got multiple, unthreaded patches from you, so I don't know which one
is correct. Anyway, I responded to one of them. Entire feedback applies
here as well.

Best regards,
Krzysztof

