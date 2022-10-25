Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3A2C38A2D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiJYNvp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiJYNvn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 09:51:43 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565EF111BA7
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 06:51:40 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 8so8061151qka.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hiXTBIxGK2t5txUBusQYuhQcGX4TmO1rhGy37Hdf2JA=;
        b=Sy75r9oaFQDWQ861B3wpDbhx48jsZ91GQwb1V9jtLdb0fJPBRF9sWKv/vUqoZRIRt/
         ZoTLEFflqwJGrqwjgdI3rQAALaUUqOU0Cmf8YNyCgrLdAoOr6iGAv22dol71RNj9y4MO
         C4YuV+0/1Z3xBU1pTrXP/hO+odmt2uyRsupbUWkTlnN7rCZ/kBQ5u9XmM7vYG9n3Ha/a
         BhOVqqOy3heRCb4cs/aW//nd4C3f4g2y/7+kZObxeSCmvB72s3P0oTHRvxd39Ojaf44C
         InKVAZ3F16xPJA9ICpDgeEukM74I4JiovMI6QB5upqcfS2TGZt6ZypXS/MTwkWSGQ1ta
         wO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiXTBIxGK2t5txUBusQYuhQcGX4TmO1rhGy37Hdf2JA=;
        b=JR0jmAXu12kShUHPRVH1UBKJKvBco+PrwfsYw2p6jWsk7VFsQShCx5WMU9vRNMBldj
         JOs2S+TChHXxXPopf5IcoQSKCemJtRPP2gnUDC9PFqWc+o7jNOxCqWI+qapZF8ErH/H9
         PePRwYbL3gN0Iw5wW8NyPDCUYFrYVDOXiWECk4jtXbf1wQJ3JdLHnHWUtAg8P/wMTsfl
         OFvhNIAxy4RiQIgLIi/HgnKBNCPGSMXQkKYzl3H1G1zGZZuUBx6tx5XdFzuLjwbg5Hi3
         rlPzhthFepQcIYfkdIjJSW9oKz3vBEzPu73Mfl4/dG9CELZEmMBI6ouwEE2G6R0pDGRB
         Z9RQ==
X-Gm-Message-State: ACrzQf3hzybxplrz+MHJDdlxWVt5Jf0ekuzRzcP2S/S+Lhx3uA0lxX1J
        BeKjwIY/Wt+G0Ha76jLBtrld9w==
X-Google-Smtp-Source: AMsMyM7Es2ToCl7355XkI7mwGX8iRulCB/ilcwJ+dOH/F3DEcOMkvtbZTVso1pxl4RvSr/chaakG7A==
X-Received: by 2002:a05:620a:4245:b0:6d7:6d51:f66e with SMTP id w5-20020a05620a424500b006d76d51f66emr26370218qko.617.1666705899534;
        Tue, 25 Oct 2022 06:51:39 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id u7-20020ac80507000000b0039cc47752casm1609741qtg.77.2022.10.25.06.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:51:38 -0700 (PDT)
Message-ID: <0a9a8833-f664-d3b0-7194-069845512ea5@linaro.org>
Date:   Tue, 25 Oct 2022 09:51:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 2/6] dt-bindings: mmc: Add support for Mediatek MT7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>
References: <20221025132953.81286-1-linux@fw-web.de>
 <20221025132953.81286-3-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025132953.81286-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/10/2022 09:29, Frank Wunderlich wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This commit adds dt-binding documentation of mmc for Mediatek MT7986 SoC
> Platform.
> Add SoC specific section for defining clock configuration.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v3:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

