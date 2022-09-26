Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA54C6FA8E
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Sep 2022 16:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiIZQqs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIZQq3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2022 12:46:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B44796763
        for <linux-mmc@vger.kernel.org>; Mon, 26 Sep 2022 08:36:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o2so11441592lfc.10
        for <linux-mmc@vger.kernel.org>; Mon, 26 Sep 2022 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NdD3ysadw1mQdYPOU4EwS3yTmvQUO98WTNXkaJ5Je4A=;
        b=c6ewr/mFasF3rWZKnZcQ6r5Wj1beFg430Y29bpXQLlUVzZmwo/mCCb6xzvhPGpKhNX
         rlxIsIHnxXLhucskcWJfiPFrI6msIqn3q2EhcU87WUf+joLGBjIL8ORqM9H+nQKERrCk
         QEWY8ca89GkyLWUBog+h1053UjtWqHdijjx3cInf0kLzLO/+j0HzH8IsZiyyCK9QbTqM
         2/1iywv415/Scs3Gni2K09TtMyRNNO6ivc1u7f5KV0WSCxPIVoGkT5igNSUw0c+0uYBd
         45QOn6wGIMKiJkY5JkiPVegrf16OQdSXn2o7u499YffGfzH3i9d+020vRGeZziI34Ro+
         iDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NdD3ysadw1mQdYPOU4EwS3yTmvQUO98WTNXkaJ5Je4A=;
        b=xVeeQNSsy42/rzrLv4cYt3EbdTvFH4bwPM2lWqk6v+L1nzQHQenzDV1RobQoy5ihkA
         IL0LHofp+Wj+kM5w2L2Pexaq7TjqXRw9Bn1O5rlafAbaEI4Wmo3H+GVw/lItautRZ71l
         oFVb/PDeGKk/EXHgZAm4FCnV7cC6CODgzKhyEc3WQjrF9fdL9J05xLhKu7Zbj1wbiQoS
         BgtJFYjGZ73579VIUJQlKzAW2HiJLS1CGL9F/brQHgnNlfjSjt7jcSO02tRtflXlVjQv
         DRUnflNhpYfUKid7pWrliKkg0IFuVtRK5ZD17tx6nICSsbvD/kdc69bAKo7psuOMSSuR
         AdGw==
X-Gm-Message-State: ACrzQf3dqHNKYSN0DyXyLd7CwDlZiU5kw4yRYxM7S2dZk5ayclsl2d+a
        GYa6Z4wiM+KsrVYQMlWhSHRsYg==
X-Google-Smtp-Source: AMsMyM7MjonJ6cIFHspxIEl28Vcd7kw6kwThRCncxLU3jHqMpzHJDsiwIViy/i3AEWg0xCW4sRJ5lA==
X-Received: by 2002:a05:6512:3159:b0:492:d660:4dd7 with SMTP id s25-20020a056512315900b00492d6604dd7mr8317604lfi.204.1664206601036;
        Mon, 26 Sep 2022 08:36:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b004a0526b11ffsm1425030lfs.133.2022.09.26.08.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 08:35:18 -0700 (PDT)
Message-ID: <f4d29a38-c195-43f7-4837-43a6176a0a58@linaro.org>
Date:   Mon, 26 Sep 2022 17:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv3 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220926140932.820050-1-dinguyen@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220926140932.820050-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/09/2022 16:09, Dinh Nguyen wrote:
> +allOf:
> +  - $ref: "synopsys-dw-mshc-common.yaml#"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const:
> +              - altr,socfpga-dw-mshc
> +    then:
> +      required:
> +        - altr,sysmgr-syscon

else:
  properties:
    altr,sysmgr-syscon: false
and then you will probably see the warnings leading to error in syntax
(const is not an array)...

Best regards,
Krzysztof

