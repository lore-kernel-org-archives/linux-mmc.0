Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE29ECAAA1
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Oct 2022 12:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJWM5c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 Oct 2022 08:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiJWM5P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Oct 2022 08:57:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9831B77395
        for <linux-mmc@vger.kernel.org>; Sun, 23 Oct 2022 05:56:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z8so4339613qtv.5
        for <linux-mmc@vger.kernel.org>; Sun, 23 Oct 2022 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2x0RIkIHNiV/gD5lKUt6DCU7+N1In5bYegvTHa5mAM=;
        b=A4x544bGTTDOcgE8nKEE3MPvp/JBN680vHeInD0kJprNfQZ8sL8qfwY8KI74pU0G/T
         Tc4nKvEI04AJ/deay6IzjcJRSQhMHGM4l5EcGihgupMnmruZKxYhi/tHKFyhNiPsrxCO
         wtFerP6eMc2hA6Ndwni/jmnaF6lD85pHQr2uqVly7CvAqo3YaC6Rn++3MVZzJI1EFI7j
         Fd17l/fe6rsspqnvp6sKMhlFy9Q0XExlEndelznx90JonIaWvFR0mwJbuF7sTJfJav/q
         OQP+2+PqJNANV/a17hjyykQeigMQYMZrmOUacnqfShbiGnzyy0FQzsmDieJ0IDdrHDeI
         XYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2x0RIkIHNiV/gD5lKUt6DCU7+N1In5bYegvTHa5mAM=;
        b=SlI41ET+5yguotL6DfVQeKcMBQ0BfMxFK4Q+M/xCeAAQLueHtmQZmCmDA8/l/7MBU+
         j6F4tcd3rIf2ZgoG549aJRgskTyvRE1uN4/TtowHmRIhd0Lo6knnEqy9JGYDj0KBB/BU
         WR/lxwyEdJK2oiOU3zKqXeEeas2T7dP+sDWLtjhTSHKGSHr2FaE1vGpVC2ZjQ/VdHDnw
         2MavdGkBgsX9mJ8J1u0csaJgoswzX3HMROWZ2vVt6SAebZoEjvVxNTX5gF2Na0XH3iQ/
         4fSOMXPhGjcHIMCL0zPfK/eQ50Hbmy16OjlfkW72H5+jamkSMWJNRDDjOdkYxj1zrAup
         galQ==
X-Gm-Message-State: ACrzQf14efQSI+9uv2cIKdURbK2rVa64pwkpnrLGMpkyrFbpe2H0Ix39
        SVFa0IliJ6HkDAlEv7S6l+bpCA==
X-Google-Smtp-Source: AMsMyM5U3MnebxKoLpSHWCnTtqElsimiMyLPyhSCwRSsoqBLRKgmnqhuogrgQU5icn5w2Ue61NKG0A==
X-Received: by 2002:a05:622a:241:b0:39c:e637:48f0 with SMTP id c1-20020a05622a024100b0039ce63748f0mr23486386qtx.323.1666529800542;
        Sun, 23 Oct 2022 05:56:40 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id i23-20020ac84897000000b0039853b7b771sm11162189qtq.80.2022.10.23.05.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 05:56:39 -0700 (PDT)
Message-ID: <67e4c08c-f03c-fcaf-60d2-fffb87a69a9d@linaro.org>
Date:   Sun, 23 Oct 2022 08:56:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/7] dt-bindings: mmc: mtk-sd: Set clocks based on
 compatible
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
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20221023091247.70586-1-linux@fw-web.de>
 <20221023091247.70586-3-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221023091247.70586-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/10/2022 05:12, Frank Wunderlich wrote:
> From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> The binding was describing a single clock list for all platforms, but
> that's not really suitable:
> 
> Most platforms using at least 2 clocks (source, hclk), some of them
> a third "source_cg". Mt2712 requires an extra 'bus_clk' on some of
> its controllers, while mt8192 requires 8 clocks.
> 
> Move the clock definitions inside if blocks that match on the
> compatibles.
> 
> I used Patch from Nícolas F. R. A. Prado and modified it to not using
> "not" statement.
> 
> Fixes: 59a23395d8aa ("dt-bindings: mmc: Add support for MT8192 SoC")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

