Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32812C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Oct 2021 15:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1579A610FC
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Oct 2021 15:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhJDPDQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Oct 2021 11:03:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59306
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235492AbhJDPBX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Oct 2021 11:01:23 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C2C3E3F32F
        for <linux-mmc@vger.kernel.org>; Mon,  4 Oct 2021 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633359573;
        bh=mjXPISoqrzvv6T8eWckfoa+w/l3lHuMX4ztP7/j2C4I=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=HoJS/zS5gvpT6LYtIIHzkLUctpg2rjGIGAa0SfyuG9ylM4fCgfgY/NVWXjXNRyv3a
         G95LkjvFPTSP+VCjWfviUQcgHJzU6GWYSo8LlecJh94oer84rgb/KPLUQ+L+Rw1+g8
         BXoA+T6E1soL05EA5mkD04KqkFRzPLjEfwT3dINcX0RbsQCO6ZuM7cqnXv9W/zTONY
         cqyWSYA8kMWUimZwmEBJlG1uNm3ILsS+vQt9vH1lChQBDiozpj6m0z1PLhR66+JBQ0
         GS8kmp0K6SlgWQVikHAtKkbHWqnScbgh1tX2VtHN9O3BQ4vvxL2/fnCCgnp1yTDA6E
         g0jVbJoEUz5/g==
Received: by mail-lf1-f71.google.com with SMTP id n22-20020a0565120ad600b003fcc09af59fso14473235lfu.21
        for <linux-mmc@vger.kernel.org>; Mon, 04 Oct 2021 07:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mjXPISoqrzvv6T8eWckfoa+w/l3lHuMX4ztP7/j2C4I=;
        b=r0REqe4KNOuJ/Z67XRRQsxVLSdyufb8vRmS7VQ8E58ZpHKAGXFyjbNsuKelK12Kd8b
         Rbdc/REftZn08sv32tdLxXymjE3vuAPAD38QbFSSIxsvnDGHcDxSwutJuxvaVpgfLq+9
         mCNbCBufQEXH0fJHvO4vmdv1rJScbMdsvXJmtr0FZyWzESrvXvQbIRS4lRLZakic34XY
         kTehfa0Lh19GN2r6W7HTPGThekce09jbBy1cPlPd3ZSn/CaG1PGIhX15JG73cXJYr15P
         2j7cmEFdLBEQEwGO3mOkWrjOKFqpp5MRxpXujJOlem1gdo8bISRpIatDsEIf3PzkPhtk
         v2dA==
X-Gm-Message-State: AOAM533scsanFz0ebWXw6dAyzTPShzj96iI2le4ZjuCFa0+UadAM7BRI
        El3wavnXK6BmSH+uXff8I8/n1PzPy1gdwNFpnctSQzItK352KaH7w+uA6BzL0ZYxcD7Wc7KI3yG
        ZmINutZjwr30/fp7QWK0ciMx10JXz5tEb6GoPiQ==
X-Received: by 2002:a2e:575d:: with SMTP id r29mr16342110ljd.284.1633359573250;
        Mon, 04 Oct 2021 07:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOo+lB6RcMLwBXgkySBQ4vL0Yv8gDCQD9CBhd0v3DB/P0euRpRs8FczKlBWRUn5Il77PI8dQ==
X-Received: by 2002:a2e:575d:: with SMTP id r29mr16342096ljd.284.1633359573085;
        Mon, 04 Oct 2021 07:59:33 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id h21sm817340lfc.30.2021.10.04.07.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 07:59:32 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: mmc: arasan,sdci: drop unneeded clock-cells
 dependency
To:     Rob Herring <robh@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210928082346.22398-1-krzysztof.kozlowski@canonical.com>
 <YVsWDaC0TOSOrrxW@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ba5cfb69-1d79-d1cf-5f15-46b4dca2fa9f@canonical.com>
Date:   Mon, 4 Oct 2021 16:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVsWDaC0TOSOrrxW@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 04/10/2021 16:56, Rob Herring wrote:
> On Tue, Sep 28, 2021 at 10:23:46AM +0200, Krzysztof Kozlowski wrote:
>> The meta-schema already defines dependency between clock-cells and
> 
> You mean the schema already does.

Yes.

> 
>> clock-output-names.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>> index 23abb7e8b9d8..dd70431df0b7 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>> @@ -158,10 +158,6 @@ properties:
>>      description:
>>        The MIO bank number in which the command and data lines are configured.
>>  
>> -dependencies:
>> -  clock-output-names: [ '#clock-cells' ]
> 
> The schema defines this.
> 
>> -  '#clock-cells': [ clock-output-names ]
> 
> But not this. That's because in the common case, clock-output-names is 
> optional. But here it is required when '#clock-cells' is present.

You are right, somehow I missed that part...


Best regards,
Krzysztof
