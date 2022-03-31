Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB6EC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 31 Mar 2022 09:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiCaJkM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiCaJkH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2022 05:40:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CABB2182D
        for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2022 02:38:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a17so27480166edm.9
        for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2022 02:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=UCC75knalYGf1Q05cm9FuhkiW0Xs+WxJ5xH2vJmJaW0=;
        b=DFNRt3TXZmQA3QwVuMf3QzdsrbODG7CPRt2CDkUf6ZaIn3+avsosj9vJY0ePDiwmzI
         2VjGFevuXHFaCGP2sWEyPhs4Dax9F6noubihKjTFYfRQrr0uOYr9RdhyXSCtiYz2n/zg
         vMsTu5fwIeFA39mXgnGgn1xLjEuJqBb7Rzo+DNR8WVqbJO+TrtprG4a1wtKrgYJtVamp
         ylnGjTDA7b5Mqdn9sncEGDMhHyzSVHGGJQUkb6tUg0r1Fq8BzeF7lslGFveaD/rKSXQk
         TvkOqIXiCnW17ub/GS+4yGGhSrHrizEk7Q47Epth/3Z5rtnQRy/yCHbaMaTGn04I+U5P
         mEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=UCC75knalYGf1Q05cm9FuhkiW0Xs+WxJ5xH2vJmJaW0=;
        b=Yb01UGIs2WNP3YJv0S7LzSaqf3gf3C6mk7qL9kNbWjAzKrxXuFTbOq6A6KzfyDqcVx
         cTBv0H9+GQ2jJF4KTsVDaQVi7i54sg3Fte7gEur+xOfuyVP9nIdVveEZm6bMZyl0fHI6
         qj/aIfQ714T2q9lPAD5UitQl/XCibTUdB1iTk06xRjgeevdB4L7++nFA7JPW3EvjFYLa
         tgRdn2ii4aHDLGGk6lvFVqIpqyPE1CWPVPFpKUST1rxlcREdcHIMQxB8Ruo9xXIVRTqZ
         HjTYl7IHj5jmgOAXR51kmjubrM82Sjl5TQZbpGn31+zQIaAUb900vE4oEPXAW3D+Sl/8
         HN2w==
X-Gm-Message-State: AOAM533k4rmF1dHswDbXwNGv0VdL4uEcf4BJvYA9BbaBtZuGEz6eJBed
        lwHezy581wjkEGbxQwD9Et9r2w==
X-Google-Smtp-Source: ABdhPJy6mFYew0T0h5pUb+fhZ0Oecmvx8z0GwMXb+IYI5LGeFXXy5EqTpEJ9+txFsFhrL5oZO94rGQ==
X-Received: by 2002:a05:6402:5215:b0:419:4c82:8f06 with SMTP id s21-20020a056402521500b004194c828f06mr15725638edd.275.1648719498039;
        Thu, 31 Mar 2022 02:38:18 -0700 (PDT)
Received: from [192.168.0.166] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id by4-20020a0564021b0400b00418fc410299sm10791232edb.62.2022.03.31.02.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 02:38:17 -0700 (PDT)
Message-ID: <5dea78a0-83ed-c016-35c6-637c8a445005@linaro.org>
Date:   Thu, 31 Mar 2022 11:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/2] dt-bindings: mmc: xenon: Convert to JSON schema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        huziji@marvell.com, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220329220544.2132135-1-chris.packham@alliedtelesis.co.nz>
 <20220329220544.2132135-3-chris.packham@alliedtelesis.co.nz>
 <ad213f38-f0a2-6420-cfa0-a9ba7cb362d5@linaro.org>
In-Reply-To: <ad213f38-f0a2-6420-cfa0-a9ba7cb362d5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/03/2022 09:20, Krzysztof Kozlowski wrote:
> On 30/03/2022 00:05, Chris Packham wrote:
>> Convert the marvell,xenon-sdhci binding to JSON schema. Currently the
>> in-tree dts files don't validate because they use sdhci@ instead of mmc@
>> as required by the generic mmc-controller schema.
>>
>> The compatible "marvell,sdhci-xenon" was not documented in the old
>> binding but it accompanies the of "marvell,armada-3700-sdhci" in the
>> armada-37xx SoC dtsi so this combination is added to the new binding
>> document.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>
>> Notes:
>>     Changes in v5:
>>     - Fix silly error in examples
>>     Changes in v4:
>>     - Add review from Krzysztof
>>     - Squash in addition of marvell,sdhci-xenon with an explanation in the
>>       commit message
>>     Changes in v3:
>>     - Don't accept ap807 without ap806
>>     - Add ref: string for pad-type
>>     Changes in v2:
>>     - Update MAINTAINERS entry
>>     - Incorporate feedback from Krzysztof
>>
>>  .../bindings/mmc/marvell,xenon-sdhci.txt      | 173 -----------
>>  .../bindings/mmc/marvell,xenon-sdhci.yaml     | 275 ++++++++++++++++++
>>  MAINTAINERS                                   |   2 +-
>>  3 files changed, 276 insertions(+), 174 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Oh, this should be only one review tag. Preferably @linaro.org. Sorry
for the noise.

Best regards,
Krzysztof
