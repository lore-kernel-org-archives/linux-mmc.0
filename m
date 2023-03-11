Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0136CC61DA4
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 18:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCKSIm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 13:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCKSIk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 13:08:40 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F532DE61
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 10:08:38 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o12so33218476edb.9
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 10:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678558117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=px7FGPYfIZ94nlU1UqelVqsR2o/IJ1tQkvyb1RAfYos=;
        b=JATAngTG2WAcY9tmjNNxLSb/WOmJ0TMUJtpLjWrgt9RK8LedCE5gxHAYo47KJq0yYp
         Fxcn9cXJC0RUENvptu3z+Z1QSYyNWGUJq9rXYv8PBRliua2yS7yEc6B9dyYP/22gAYAX
         86JWAzGxHM+VMCLqTULniJr6O15i0lnXc3qMz/mieTz3QEENmpvdArCPrCKCPHUDzEfY
         DihVpUBQt/eTCe4BGrs79dtAT6HhK+tYhya4TQLzFcS3m42hi5zPKOWC88rRtQo+hRwL
         3KiIV13GuJfuOhg9oFR8MtguMOzldRYL5lZ8TwMoU2+otOU/+XuE1JtA3gvQn9Wtx8GM
         ACZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678558117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=px7FGPYfIZ94nlU1UqelVqsR2o/IJ1tQkvyb1RAfYos=;
        b=S4gtycXJ9s+OYuczNpaVX8s1hTDV0b/R45sYpF3YXJ41Nf2SpQkIbQOGwkqKcl1SRL
         pfs0acvHOq8khAAH34AXL1WMEudo7BNwuwKhYpyBaUulRbRxtZLAwV+1E2OqBTBJo+Fq
         oS331lOuLipKR41XLiVCsvnNbe326OWrFIz24z9y0rBpXCeqtx2NT1hEIgq9ZiJ1itFi
         4wgsySGWRnZ6d8eEZLCBPKXiyqCYZpD2wIOk16mP/c6KYAerk0rCtkrNDfhFFsoOh8HB
         UotTry1n7RbQ+DDxsTqd6/93unvFavHRM87BUY10gLLTHThdSyIBrJzsESIb4Qf2PdKa
         Q/AA==
X-Gm-Message-State: AO0yUKXGddYhhy1U0uTmSpEInQDSMyeRCInBViTAJnlV70QE8boT9z+J
        M60K22+89d/51mr9zc6mZph7wQ==
X-Google-Smtp-Source: AK7set9OXOzqJIG07Dth/sljXDOnOfsuxMi1VLwWpjHdi47/1I5/6sZWv2qa3oiqUaRnZrduNtl/Dw==
X-Received: by 2002:a17:906:d9c8:b0:8e1:cc38:6ab0 with SMTP id qk8-20020a170906d9c800b008e1cc386ab0mr25990433ejb.16.1678558116822;
        Sat, 11 Mar 2023 10:08:36 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:6927:e94d:fc63:9d6e? ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id s13-20020a170906354d00b008caaae1f1e1sm1312972eja.110.2023.03.11.10.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 10:08:36 -0800 (PST)
Message-ID: <f14e1e9d-5265-355f-943b-3b0ed96dca46@linaro.org>
Date:   Sat, 11 Mar 2023 19:08:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] devicetree: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <640cc323.050a0220.8e83b.0e60@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640cc323.050a0220.8e83b.0e60@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/03/2023 18:57, Sergey Lisov wrote:
>> Why did you remove the subject? Please keep the mailing process matching
>> mailing lists. It messes with mailboxes, filters and reading process.
> 
> Sorry about this, I just wanted to get rid of those X-Something headers and
> accidentially deleted this one.
> 
>> Yeah, Rob acked it so I will let him to judge this. To me it looks like
>> unnecessary fragmentation - this looks like compatible specific, not
>> board. Anyway you need to resend to fix all the mailing mess.
>>
>> Best regards,
>> Krzysztof
> 
> Should I resend the whole patchset from scratch, as if nothing happened?

No, sorry, I was not specific. You need anyway v2 with all the fixes I
pointed already. Lack of commit msg is a no-go.

Best regards,
Krzysztof

