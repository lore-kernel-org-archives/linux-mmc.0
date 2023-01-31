Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26933C636D3
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Jan 2023 16:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjAaQ5W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAaQ5V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2023 11:57:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD731D904
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2023 08:57:19 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y1so14853844wru.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2023 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRIRICEmrabbDC+z0qM+J82wcNj3dmfUYUXd7QSBt1w=;
        b=dy5A3IWNvdGGhkzZ4Hj/Cfw51B8qkHkcMUzU3/PlUeCci5HdMHsIC1yFgUpWlENTQT
         O5t+pLbzM/gY0Pf8v407BzziOP0eiV1/aW2wxhteWADN1oGKiE2NO3C2kX8YnzB6NjVJ
         AC7rtWjy01xrw/iCU9vOwsKQI9/ESEkwBSUNluB/+Xzx7mrz0dUNYCYulr+jvHz1QpFd
         GW+Hle5B6VXl1UVMpjO/uo96iZLVLXNlcgvRhpJjWU0qARNkD5W/+gagohEizqgCGJ0K
         O5CGmYfNn8mnZPjJIhH1Iy0lMQY9Ky2PEspg4/DhK9FN6eL3gSj7dH6tsikCwdyGDQbe
         DLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRIRICEmrabbDC+z0qM+J82wcNj3dmfUYUXd7QSBt1w=;
        b=NbkdjqNs0+3brJzWIbGB1lpLrRTGd0OYPmeurz3eL82l3kCV37I9DzdAIZRS5Y1BFB
         YqDRfPppVIsRtYdC17mxp62K4p5OEnpce84wi0U2rYUg3kX1MjSyAeOWxarCJffqALRU
         fg96We622wSGo3qqncFrwHz7avdMdOa3ycfiBvW5RU2cWV9FbqPOo4GvJ8DXeapfGg5/
         FW5fIIJNHLiliH8izI5Yso/NFKtm+ke11S5E7VSphuQCRv54wMy/OaNwR1HSgKNqKyv7
         Iu79JpBKajElmjLIeBrg2p46Tr6v6ohUGisOZS807g2ZTza7geZUwjwZfhKTTYhsqktH
         THoQ==
X-Gm-Message-State: AO0yUKWjdqEX2NboE/mUX6Iz5b4OIQymvII/ZpwrpKHXy6Bi6bFjc848
        9KVV1VarK9EEZQKCpCrKxdFmCg==
X-Google-Smtp-Source: AK7set+3+ztKUDCKlgPVjR+GgF5ntUTYGyYRvo//VfdzWE0w1Fddd6HXGe9FrQc6VumDHMX9cCqrwQ==
X-Received: by 2002:a5d:62cb:0:b0:2bf:bdbd:25c0 with SMTP id o11-20020a5d62cb000000b002bfbdbd25c0mr18271625wrv.15.1675184238576;
        Tue, 31 Jan 2023 08:57:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i6-20020adff306000000b002425be3c9e2sm15364628wro.60.2023.01.31.08.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 08:57:18 -0800 (PST)
Message-ID: <a1d2ac4c-0763-5c92-be21-22820c376438@linaro.org>
Date:   Tue, 31 Jan 2023 17:57:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: mmc: Add cap-aggressive-pm property
Content-Language: en-US
To:     Hermes Zhang <chenhuiz@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230129023630.830764-1-chenhuiz@axis.com>
 <b43f26c9-f76c-c898-aadc-ce3ee7b7823d@linaro.org>
 <b125f25d-94c7-dd5b-28d3-3948c36ef4e0@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b125f25d-94c7-dd5b-28d3-3948c36ef4e0@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/01/2023 07:54, Hermes Zhang wrote:
> On 2023/1/29 18:58, Krzysztof Kozlowski wrote:
>> On 29/01/2023 03:36, Hermes Zhang wrote:
>>> This commit add a new property: cap-aggressive-pm to enable the
>> Do not use "This commit/patch".
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> Done
> 
>>> MMC_CAP_AGGRESSIVE_PM feature for (e)MMC/SD power saving.
>> Why this is a property suitable for DT? IOW, why this isn't enabled always?
> 
> This property will benfit for the power consumption, but it also may 
> degradation in performance as it will prevent the
> 
> the card from executing internal house-keeping operations in idle mode. 
> So it's better to config it from DT.

Why? DT is not for policy. How you described it, this is policy or
system tuning choice thus the job for Linux (OS), not for DT. So I will
repeat - why this property fits the purpose of DT (describe the hardware).

Best regards,
Krzysztof

