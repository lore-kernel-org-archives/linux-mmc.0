Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACC4C25B0C
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Aug 2022 09:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiHHJS7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Aug 2022 05:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241504AbiHHJS6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Aug 2022 05:18:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF1313F41
        for <linux-mmc@vger.kernel.org>; Mon,  8 Aug 2022 02:18:56 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s9so9153972ljs.6
        for <linux-mmc@vger.kernel.org>; Mon, 08 Aug 2022 02:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kgXxmrAF+Qnsh3G9vJiLHv3StfM+xchFUzG/QuzHdIs=;
        b=hWOntp3Okx/AnzV9tzyG85H0qr1WUkBlFJjZRr3Vf78wLlyO3b/Oo5EE9OEacwDI3F
         EFfmqE0aEEnnYkSr50Iw647ujQ5T10nOiHO2Idig2cGPB5GjM9H9lF0GHNbpQF+19G26
         mAD9q5Z94iZSYo+an8vSolD7gXmzudOxjre22t2ppnSyVzyWTNthtt+RmYHtK2qT7+Mu
         UjrnIsqxPh1hFXygP12oDs8WB9TKv7dbDSVy40jGNjsW2WqZ/tzamKgHxRoxz4VbVLnt
         A8gquSpnKVERnbRHdVbieiyH3KA/0KhiHJu0BOqZrmfYeAKhwuM3ShOJNwWZxcED9OLh
         tZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kgXxmrAF+Qnsh3G9vJiLHv3StfM+xchFUzG/QuzHdIs=;
        b=nq1xu0EfS1CCiHex8cJw8MzzssPYcFZHZu8jaGs+VncGLxY6dEiSAqfDUEbjSbornY
         VsyXuvrEF7S1EzS/PY/5UvpqSayRiipZ4Abx1C9KcnO2Z8+Q7C3rgUAbESHFXt4W8eug
         XKMCHrLJewST5o4QdqHZ2Ss3iGGO67qTKxFkWg4BenHsGYxGIEkAAF9d2xyjxBje7hK2
         JHTElsUzcSLogu9tT1ny2R60IaWzMRDIQU8gYVVh4+WQ14SQ+VKnf2idjofDbHGVbtm9
         uP51HUUbH62in6NusXI4uWCidjUOWub59JXfz+MkBrCdcewxo4CFBTGQyJy6BstMYWYC
         XUcA==
X-Gm-Message-State: ACgBeo0GHYjMIl+yHU2AjDMnpsc3WgRgJokiyieKn7dVyyjvNDx2AXOF
        Q1a4jucI3HMSZ0+4P3FOzrdEKA==
X-Google-Smtp-Source: AA6agR6YVF6CbHdahMcx9zQ+eRS778ipAhFVIIKo01J1CFpDRepShWjIyUnmpuNlXa56p0tx61QsrQ==
X-Received: by 2002:a05:651c:210c:b0:25e:6a39:23ed with SMTP id a12-20020a05651c210c00b0025e6a3923edmr5353015ljq.43.1659950335288;
        Mon, 08 Aug 2022 02:18:55 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id p26-20020ac246da000000b0048a9d0242afsm1361541lfo.32.2022.08.08.02.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:18:53 -0700 (PDT)
Message-ID: <33f5b621-af3b-b6a2-5e3d-c01fe40eb5be@linaro.org>
Date:   Mon, 8 Aug 2022 12:18:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: mmc: xenon: Add compatible string for
 Xenon SDHCI on AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>
References: <20220806085818.9873-1-vadym.kochan@plvision.eu>
 <20220806085818.9873-2-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220806085818.9873-2-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/08/2022 11:58, Vadym Kochan wrote:
> It indicates the Xenon SDHCI on AC5 SoC so the driver will try to fixup
> the 2G address space limitation issue.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index 3ee758886558..17cda847e0a3 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -34,6 +34,9 @@ properties:
>            - const: marvell,armada-3700-sdhci
>            - const: marvell,sdhci-xenon
>  
> +      - items:
> +          - const: marvell,ac5-sdhci

These are not items. Should be part of existing enum.

You missed updating allOf:if:then.

Best regards,
Krzysztof
