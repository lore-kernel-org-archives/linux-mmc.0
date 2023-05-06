Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491C6C7EE2C
	for <linux-mmc@archiver.kernel.org>; Sat,  6 May 2023 06:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjEFGhE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 May 2023 02:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjEFGhD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 May 2023 02:37:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B78212D
        for <linux-mmc@vger.kernel.org>; Fri,  5 May 2023 23:37:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96598a7c5e0so412101866b.3
        for <linux-mmc@vger.kernel.org>; Fri, 05 May 2023 23:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683355020; x=1685947020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZboJ2AcfG2i+m7KR3oj9UG4okF7V9oFRqLJdVeXu00=;
        b=sqbK77gE/K8uGJnG0euiLgrOb+mQ/Qlj5CbLADFYpxePtOAkIMAxoq+w+hbr7Q2sM4
         XkzlWFQAQ7xP/SZAqN7VYSbShQRw7+0p/qP6QopCRolXqABRSnDBpNjCZiWoI0vRVtyB
         Uf3eG/QyBpiafVW1B08egphgKgEdYrPONezlb4u/boLf4A1B9txWBP0Avvag1aEFJtRR
         dOo1mUwIdeFm5QudDdDFHlyWyHoxKpCw9qvq0UWYxOHcTm68zF1FV8POR28jHVBnHmOh
         hWQV9ItVOcI1QDD+sj42uYt20ud75AOro6KjWMYqE8Bxe0gQRCmZjZgo7pgxJA3CR+Uy
         YaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683355020; x=1685947020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZboJ2AcfG2i+m7KR3oj9UG4okF7V9oFRqLJdVeXu00=;
        b=CCV1DRJSeZwHwo3oe935JVnlPHO+qxphedKLVT8eFirOKBUxsPd1vbjEj4TRhArTWx
         5kQS3DE9ZvcMHO/a9vso/mftcqi+zigPeh8fqxT+9GhOwTmQXtoP2kar2yDftoOy+NEI
         buONMUTJ33yulm58uGpor+Lss1A8HpHYPRz1EIolzTdZ7M5jGkdtaxLGo2I3MT3wjIBb
         liDzpSboLN6la4PDVJY0twzn0kezPz/AbLjgz4cWziYfX1E8pH7WrKO6klLU5rpDQS/2
         2DJG1/+U8Tenin6YIFfLv1QPWxuuoRHgkhEbRTglzCsYMcp1a0YCitG/sUj/QTV+NDbz
         6eMg==
X-Gm-Message-State: AC+VfDwdZMsL9TrniERy37PNvRQwR8Wgo8eaZ9jX4WFUxK4E9VDQ5dFM
        MPF58JPTzrVyXRGv3V42bUWOGQ==
X-Google-Smtp-Source: ACHHUZ6qBIwFNcX8Zed88zdfNbAP4yo52ji/k3Ood5s46VKsgf9BnrXEsBtmR9pEExyp9J+3tD07eA==
X-Received: by 2002:a17:907:97ce:b0:94f:80d6:b825 with SMTP id js14-20020a17090797ce00b0094f80d6b825mr3954375ejc.19.1683355020499;
        Fri, 05 May 2023 23:37:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:efe5:7c03:a10a:7a40? ([2a02:810d:15c0:828:efe5:7c03:a10a:7a40])
        by smtp.gmail.com with ESMTPSA id e5-20020a170906844500b0095fd0462695sm1890949ejy.5.2023.05.05.23.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 23:37:00 -0700 (PDT)
Message-ID: <4909ddbf-12bb-c082-7c47-e6607678db6b@linaro.org>
Date:   Sat, 6 May 2023 08:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property
 "fsl,wp-controller"
Content-Language: en-US
To:     Bough Chen <haibo.chen@nxp.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@dh-electronics.com" <kernel@dh-electronics.com>
References: <20230505101246.289278-1-haibo.chen@nxp.com>
 <fe8c1063-b8d4-1707-5434-89b3d1edf1a8@linaro.org>
 <DB7PR04MB401046EF6FFFB367BFE4741090739@DB7PR04MB4010.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DB7PR04MB401046EF6FFFB367BFE4741090739@DB7PR04MB4010.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/05/2023 04:37, Bough Chen wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2023年5月6日 1:48
>> To: Bough Chen <haibo.chen@nxp.com>; adrian.hunter@intel.com;
>> ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
>> s.hauer@pengutronix.de
>> Cc: dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
>> festevam@gmail.com; cniedermaier@dh-electronics.com;
>> devicetree@vger.kernel.org; kernel@dh-electronics.com
>> Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property
>> "fsl,wp-controller"
>>
>> On 05/05/2023 12:12, haibo.chen@nxp.com wrote:
>>> From: Haibo Chen <haibo.chen@nxp.com>
>>>
>>> Driver do not use this property, so remove it here.
>>
>> That's not true, it uses. I got only patch #3 and nothing else.
> 
> This v2 patch only fix a dt-check error, for patch1,2,4, still not get comments, so I do not send out to avoid noise.

So while sending a patchset of 4 patches you skipped 1+2+4? This does
not make sense. Send entire patchset.

The patch by itself, without context, is incorrect and not justified.

Best regards,
Krzysztof

