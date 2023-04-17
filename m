Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BF9C77B76
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 17:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDQRJm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDQRJl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 13:09:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389AC7EEB
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 10:09:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fw30so13263860ejc.5
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681751349; x=1684343349;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XweE64Zl/46f6L2SuHt55NuqLtzHxIBbAUN9fGMnwCU=;
        b=KfEfP6epKCNhsWeM5eKs9iD6bkpUo1BSxuZC+CKvIeza0OlGKaF7OnY3PBbuz/sX8Q
         u+gilEKj77/DKTYii79bgOYkEZYvqyAYql/jj8868J1mwZmY+xphtUz+f+PJkz736T1o
         UEbo/poM0QW2pk8cdRYJEk5CWl7PLv7eVYE1HN5SEjUIxBAgRBLxLngvyU3Zo9czhMhT
         7AJnnO8IGsk+TZoDSb9aByg7upUi3lCxGNpSAkUSZNujxqq3s3NNwSW0gYhitn2+CjNI
         FEOn/N6+g8JMN3kitx9dCy9/RGguuhQv3Fpoo0GRjkC4trVl6fO2B/5PTVsVPMihOQRY
         7Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681751349; x=1684343349;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XweE64Zl/46f6L2SuHt55NuqLtzHxIBbAUN9fGMnwCU=;
        b=MAQIcMLPdR7JpAiUdjaabuqsMCrDndmg9uyZXmZlYFEtX2t//InKP3rsVJ1xxEm4U4
         9hFq0Bu19CavLdUhlalGNqFvxYmwZdlFGidyzUsOdx6ONDBtrseEv2Flyn1meM8yPkyS
         X+TEZ+n2tTEEHHZfcKVbu5aRJoahpdvYYt2ZGg+3v3c1hP8nBTspxaxXiG/a1hyyBOIo
         MvM8F49VrY1Xx5ensJEk3mBorsdTWOMVEpmtdXiHzMgOujrwL82SF0I/TQur+V5y/XLz
         Ne4TAsjbMLq5Nchdil+dCVgSKBgakDiLPArup1M0lbvLY5OFzYj6jhKl16YfGwdm50n7
         PHGA==
X-Gm-Message-State: AAQBX9eBEqDNdY8iMcIY386rTaOP7IdDCTaSRmHRath5XLosqyrGDGr9
        NvuABez5HOxhaz+wimI5K1aWVlANLnKgaLOJjB2aYw==
X-Google-Smtp-Source: AKy350aQzFoq6KoINmUM6LrdMkGW6Nc0TbczRW3/dDZKPyEEcBkKaQAVRBwqW0dh68VrWD3e3s8s6A==
X-Received: by 2002:a17:906:a93:b0:94f:9cd:464b with SMTP id y19-20020a1709060a9300b0094f09cd464bmr7931157ejf.15.1681751348992;
        Mon, 17 Apr 2023 10:09:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:96aa:60eb:e021:6511? ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id xg12-20020a170907320c00b0094ee99eeb01sm5177994ejb.150.2023.04.17.10.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 10:09:08 -0700 (PDT)
Message-ID: <56a72d99-46fc-67c5-e754-4148c4984f2f@linaro.org>
Date:   Mon, 17 Apr 2023 19:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 3/4] dt-binding: mmc: hi3798cv200-dw-mshc: convert
 to YAML and rename to histb-dw-mshc
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v4-0-44096e187f53@outlook.com>
 <20230415-mmc-hi3798mv200-v4-3-44096e187f53@outlook.com>
 <1ff86f70-8e8d-5689-13f5-8f04a72cb600@linaro.org>
In-Reply-To: <1ff86f70-8e8d-5689-13f5-8f04a72cb600@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/04/2023 13:17, Krzysztof Kozlowski wrote:
> On 16/04/2023 11:19, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> The renaming is due to the fact that it is now supporting SoCs other
>> than Hi3798CV200.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Eh, as Rob pointed out, this was not tested, so un-reviewed.

Best regards,
Krzysztof

