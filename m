Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBCAC6FD19
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 18:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCLS1R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 14:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCLS1D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 14:27:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A8B5099D
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:21:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p4so3152996wre.11
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678645221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJbzQk4TLzSKDEe2jC8259R3RwrclYP4GOKv7WeR0Ww=;
        b=hnS5BzAHVWSdxHwfTJBEnnLR+Hy83W59tv7w8cnDpxjrWkSCVCT7slg+S4EhJSrMbZ
         2UOKeYmBuRi2r/O+al79HjlWu7b0fsD5RUqLwHveGkAVX7NBZu15+dRYteuXER8AfBh0
         KiUVFf4yK89wiZdhPp/EaKgzN9Ffdojs3VkItuwBr554fkB1mZFA4soIpp7QDyo9GcNx
         Q8TOaZwyASUqR160bVdrqq/doaA01UQ8aNalcnIOinh/7mQTqyZo2FbfTR1i+buskYuK
         Zug3vIj+ulNyoj5JRA8imV4lEnbRkDUXG2g+9t51tbLbJOnIwoX1J+PPHBghMtip7ZOn
         jFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678645221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJbzQk4TLzSKDEe2jC8259R3RwrclYP4GOKv7WeR0Ww=;
        b=X1VZ1lW6+oxkXKT88CUG5ADUrK3lQJBKHON0l7kMu4wpWaAUvtC3c2jT5B/YDDkDhE
         olgkNWc9ODiL1K253QlCATj6GTQI5N+APzwHS2P+iIj6Iy9gwDvlSZRXG/2m0P5IiilN
         uRTtE2sd9XueZNM88fbzX+LqlmMxHBP2HFbCVFeN+yJ6mOSynZbdccX6isdOQbJNEeYd
         IjZQd9R/ajlZQrSwveJtk7zMOFHKyPCAb3Noet8LtDZjWBitNVD02P06LM4AIoWiJDGB
         1lojCos5ARR3IQNgIHFhRV1+dWcdQczAswUSLQT8R3jKOgLsD0may/xXy67kZh7lq/06
         HF0g==
X-Gm-Message-State: AO0yUKXi0RNEC+Y51Z1oDGEH1OChR5COYxJfKe0bLjjIYADhpTszfTbg
        meQH2px0fIUqPB5dkzjs5cpREZ9G6QtKIhLZ6f8=
X-Google-Smtp-Source: AK7set9brgC1i/ieyhjxBiLx9HBWqe3Fd1FsMtrCMQZRRFIISTpQPpLIbjDXETPymdO1F2gGMPajNg==
X-Received: by 2002:a17:907:6d1a:b0:8b1:238b:80ac with SMTP id sa26-20020a1709076d1a00b008b1238b80acmr41929936ejc.67.1678644647299;
        Sun, 12 Mar 2023 11:10:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id oq12-20020a170906cc8c00b008d68d018153sm2465874ejb.23.2023.03.12.11.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 11:10:46 -0700 (PDT)
Message-ID: <dd6aa950-b006-9cb6-a03d-a5e54c98ab9b@linaro.org>
Date:   Sun, 12 Mar 2023 19:10:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 0/3] mmc: dw_mmc: fix DW MMC cores with 32-bit bus on
 64-bit Linux systems
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
References: <640e1428.c20a0220.f761b.1a1b@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640e1428.c20a0220.f761b.1a1b@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 18:58, Sergey Lisov wrote:
> DesignWare MMC cores have a configurable data bus width of either 16, 32, or 64
> bytes. It is possible, and some vendors actually do it, to ship a DW MMC core
> configured for 32-bit data bus within a 64-bit SoC. In this case the kernel
> will attempt 64-bit (readq) accesses to certain 64-bit MMIO registers, while
> the core will expect pairs of 32-bit accesses.
> 
> It seems that currently the only register for which the kernel performs 64-bit
> accesses is the FIFO. The symptom is that the DW MMC core never receives a read
> on the second half of the register, does not register the datum as being read,
> and thus not advancing its internal FIFO pointer, breaking further reads. It
> also seems that this FIFO is only used for small (less than 16 bytes)
> transfers, which probably means that only some SDIO cards are affected.
> 
> Changelog:
> 
> v5:
> - rename "samsung,exynos78xx-dw-mshc" to "samsung,exynos7885-dw-mshc"
> - rename "samsung,exynos78xx-dw-mshc" to "samsung,exynos7885-dw-mshc"

So this is fifth version today? You need to wait before resending, to
gather other comments.

Also, something is wrong with your mailing. Threading is gone and all
patches arrive twice with different Message IDs.

Best regards,
Krzysztof

