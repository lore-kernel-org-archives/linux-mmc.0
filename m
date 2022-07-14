Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7798FC43334
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jul 2022 12:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbiGNMg5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jul 2022 08:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239406AbiGNMg5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2022 08:36:57 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B5A5C9EA
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 05:36:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a10so2015882ljj.5
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BiNLu6xnGV9ZsmOkKtRu8GiJpJaUEre3r3pnPbEbxjM=;
        b=FHdgMunntPsutX4pz+6aGsb6vcE7Ixf2ZYUFoPTGHrEFejrLnyjAlfCD0ywMiGyRDk
         UfEhXQxQP0ZuNp/Z3UGCb5Q/138+hHJbn65GnZcA413gKMKOWlQsvHtuqC4VEAN+MXl4
         CBO9h4pCl2qqbpu2Jwulr+X0VkSinEp6hUW6PcfB4NIeAnab+OFrMAeOB+Fd63cvd2Ty
         y0a6XkU6jcb9YDWJ2EIDhVhhIlvrnWDCpUja06ZdC7BDBr5OJY3rhVES6GA/hk0r62Yc
         DZoNyyE3jzlCFZD3Dw8EIXi1hxmYPzzJicSNAP6YnxNW8AQ/l8Q8//SWZvLU8YKajMSl
         /ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BiNLu6xnGV9ZsmOkKtRu8GiJpJaUEre3r3pnPbEbxjM=;
        b=fBGyuwK6FCak0JuHSKWiJFTZLzAvXf9FHsUhbAjqT9FkPHSZEi7abMjBYbAXcSzkxx
         2aMiPly/GkWf4BS9ADFjLBEe7UZy+plZXEoXIAgj8uObI4MTL2+Rmkb0ukhB3pHuwI2W
         MksqwCnhOhCVVlTrxgYI5sLV/hXG8oTf+lhXM83p4dQGZOFh+q7K8OlS6QPl5dhI63lI
         2JgjiWZxoWEc0IwJNr2BpibQ7s227b/Uq3ge0THE1feP1WZ3gnp7bdo+3C7V3sTycEVR
         8ZZ8Xrub1+SWCOktua4WAxTauiw3R2m8FLnvMtHJ5Rz2M/LCebqNbYgKRYw8eSBRF6XF
         LOLA==
X-Gm-Message-State: AJIora/pCteGggqfeUY/uxj6nx7pYlzbmh8Lspgeun9dJGt5W/9hd5pf
        6k9VnHotQ6aCyGZ5ZH2e1BwDVLW3QPzP8w==
X-Google-Smtp-Source: AGRyM1ufjQDkB4prXpgXK1PHUIK0jMqKORD8LAVpBkL75jwLGc06XPfOU+ozWIva+N7ub5TXsI558g==
X-Received: by 2002:a2e:a3d2:0:b0:25d:4834:aa0a with SMTP id w18-20020a2ea3d2000000b0025d4834aa0amr4658241lje.272.1657802207546;
        Thu, 14 Jul 2022 05:36:47 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id j16-20020a05651231d000b00489c924497asm339568lfe.202.2022.07.14.05.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 05:36:46 -0700 (PDT)
Message-ID: <727e71b7-9f80-d715-7761-0c56af1cf1e1@linaro.org>
Date:   Thu, 14 Jul 2022 14:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/5] dt-bindings: mmc: sdhci-msm: Document the SM8450
 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220714123406.1919836-1-konrad.dybcio@somainline.org>
 <20220714123406.1919836-2-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714123406.1919836-2-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/07/2022 14:34, Konrad Dybcio wrote:
> Document the compatible for SDHCI on SM8450.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> * Add this forgotten snowflake
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
