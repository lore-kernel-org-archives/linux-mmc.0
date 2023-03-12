Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD411C6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 10:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCLKms (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 06:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCLKmr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 06:42:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB4B3A86D
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 03:42:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so8290833edo.2
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678617765;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfveJSvxtF5CnplYNA0fTkHPZzTAq5ne7Bok/0BiFNE=;
        b=t6bjoPKyiiz3d0pvJdWobd6snOKUJNTrA08WBkRylhxxJqxTW2G7Gh0tsxLZW/QhCA
         pR8BQQiKfAJOgDdTaIK1614xCoVmPgs3OsrRPYVLx2wyx5KbLccL/ohgW7k4B1NJ4+iP
         jPg9RJcRsofqF42KKp4P8tuqa/uDsWlU7JFTMhKaDr3O7sUkcPvZbGufe5QU/XD8nSSA
         l1lRTZuDg+aSPTLSfpSnj7UCR4G46TApxNNaZ8JSKMAHgDaJHID5rHzjDHOojKOHiBfx
         BLlUNCPvzFwsyPxxUHaoV+TbH3DjX8A1pE/A+zWO4kO49jmgxXHhYb2W7FiHJhPKFZs8
         useQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678617765;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfveJSvxtF5CnplYNA0fTkHPZzTAq5ne7Bok/0BiFNE=;
        b=p8LjzwEs4qrcuaylk4vZ67h+bxvL6e3UDwQDXnbrpoRq1IV0Lr45qAHTMx+AuolnVz
         9wt5pioN32xDiFoSaycoW0SCUwiwlQnrXR1L05vePDzZEObQzG6veblF5+ZHyKb9Omco
         95Q7kWmtZB06N3ubs2RYiOBuNn6fFyNego2UE4xmsqfJlLnNQTVwodcyDDuKDC2/JFZI
         zaaATWpCqSEkebY3mGQ7Sl0XVIpV0R1HNOSMuTXIZbZT6K0EsPyUOG5nIatiZf1z7vl2
         8SGnK95jxzD+UlPIF20l6v4C/uMQUsVB5dAJQmUROW9NXYGqn47uHQvpMGWbtEW2n1h3
         l1aA==
X-Gm-Message-State: AO0yUKX+Leu4BMGWK7kOhfHMqCAKpON/KDTW5Bet1SQauPFfmAZa9RNw
        N0vcfgdvPmBAc8VnxW+1BSkTn2fk9pbQCL/pG+s=
X-Google-Smtp-Source: AK7set+qeZ4bULgnLA+0O/+hrgXfk//CriH/OguEIP5t6ccRDm09zzk4vwsKMJRnB1etv+ucRt7t3Q==
X-Received: by 2002:a17:906:fd8c:b0:8f7:d5c0:c71d with SMTP id xa12-20020a170906fd8c00b008f7d5c0c71dmr39669625ejb.60.1678617765062;
        Sun, 12 Mar 2023 03:42:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id ox29-20020a170907101d00b008e53874f8d8sm2072527ejb.180.2023.03.12.03.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:42:44 -0700 (PDT)
Message-ID: <aa142690-d534-a7aa-208a-84a3e324573a@linaro.org>
Date:   Sun, 12 Mar 2023 11:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1678558770.495747-1-sleirsgoevy@gmail.com>
 <2edea81f-9ea1-5ede-8539-6aac88621670@linaro.org>
In-Reply-To: <2edea81f-9ea1-5ede-8539-6aac88621670@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 11:18, Krzysztof Kozlowski wrote:
> On 11/03/2023 19:15, Sergey Lisov wrote:
>> Some Samsung Exynos boards using the arm64 architecture have DW MMC
>> controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
>> systems the 64-bit FIFO registers must be accessed in two 32-bit halves.
>> ---
>>  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml   | 7 +++++++
>>  1 file changed, 7 insertions(+)
> 
> Missing changelog (I did not get cover letter, so no changelog there
> either).

Correction: I see the cover letter, but anyway without changelog :)


Best regards,
Krzysztof

