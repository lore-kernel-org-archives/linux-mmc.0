Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA4CC64EC7
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Feb 2023 13:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjBTNtN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Feb 2023 08:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjBTNtM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2023 08:49:12 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218441E2B2
        for <linux-mmc@vger.kernel.org>; Mon, 20 Feb 2023 05:49:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cq23so4656024edb.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Feb 2023 05:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49HWWb3cc/HZxywIb9uNzaTa/ku4Ssf3WpC18ssUqdM=;
        b=ASOr3MPofKHL4lTrFztPVZ8pYYkUihrtwv+jTcH3fIcIeAs8ABsKBTzL8f9ngHjeUb
         U6gCplTJOBDvXMTwk1lzJbAFFKEX2f3Pb56QFVyZ+ZEjZIa01FcuDR/2vVITDMjN08Ft
         Rg2lR00FSUpJTiBsnspJeDkinc25kFMmonYuKV3gTWOBO6qy4GDW1uLeoR9Qarnex70A
         plYYTdiATA4MgHqjb9TbXQb/Y36XejAZdjecpHxMZfl/0qRu+tmeR7QzrX9iU9sm9prk
         m5CNw0zF72qan+4DRUvJOWVnuV1E4wZdmYCE6RtutFBoEwKscppIpxmDDDv5YNmNBYgY
         yrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49HWWb3cc/HZxywIb9uNzaTa/ku4Ssf3WpC18ssUqdM=;
        b=vUKg3bi7I5PO7EUyjxuA0OCXAVLdBFvnH92e53ExEXrcybva09l25z7v8JZCJ+Xnwr
         Un/w9QIhEYMcBSF834+HqE35EcuOuC5mo5wuH1XlGos9ps8j5+Xu9NyM2pwm8ZH3KZ9a
         awArOKQBqFfZM+56hqUuDWYfDDVWpRmRCmjdmPRiSIuY7o13hE98XtqYh8xoBYT+HDwb
         IDZkApNFSz88XphF9TPXS58NOYd4R8dn6H4bQNJc1Rz5FIMKVdPbN1EdwMwG1dTE44n6
         cyxYgBTu4evL5BdFLJVCOqJhjSmcD9m7XS/EYgDOChZzKfdQyBPu604+MSe/1TsfyxaN
         2RkQ==
X-Gm-Message-State: AO0yUKWbqvstZ6cInTjkQRRQxfz1p3+gP5tss6DovjhzjP3WtDwYNBLy
        pMgLpLmgmZxeLPGFWUF7ZfiZMA==
X-Google-Smtp-Source: AK7set8oqq9/YhAz+OGjQTF/zubGQ1QoCjgs2EU78K7J4oztgSo+kTDoPZezNu1KMlJmBBXskLceXw==
X-Received: by 2002:a17:906:ad82:b0:8b1:7eb4:6bea with SMTP id la2-20020a170906ad8200b008b17eb46beamr10504743ejb.38.1676900939396;
        Mon, 20 Feb 2023 05:48:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t18-20020a170906949200b008bfe95c46c3sm3124624ejx.220.2023.02.20.05.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 05:48:59 -0800 (PST)
Message-ID: <1d8b225e-19ed-f828-91b0-0cbc0a9e53a3@linaro.org>
Date:   Mon, 20 Feb 2023 14:48:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/5] dt-bindings: mmc: sdhci-cadence: SD6 support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        jannadurai@marvell.com, cchavva@marvell.com
References: <20230123192735.21136-1-pmalgujar@marvell.com>
 <20230123192735.21136-5-pmalgujar@marvell.com>
 <d05161ed-eb30-2d4d-e9bc-4b40e8ae09e7@linaro.org>
 <20230220132214.GA24729@Dell2s-9>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220132214.GA24729@Dell2s-9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/02/2023 14:22, Piyush Malgujar wrote:

>>> +
>>> +  cdns,read-dqs-cmd-delay:
>>> +    description: Command delay used in HS200 tuning
>>
>> What are the units?
>>
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32"
>>
>> Drop quotes (everywhere)
>>
>>> +
>>> +  cdns,tune-val-start:
>>> +    description: Staring value of data delay used in HS200 tuning
>>
>> Same problem - missing units.
>>
> 
> These are integer values, will add in the description that these units are integer used
> in tuning. Also, will remove the $ref.

All units are integer values. We don't talk about this. Delay is usually
in time, thus I would assume here proper unit suffix.


Best regards,
Krzysztof

