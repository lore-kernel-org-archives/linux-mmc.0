Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11E9C6FD1C
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 15:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjCKP60 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 10:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCKP6Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 10:58:24 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E18F1EBC9
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 07:58:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cy23so32352782edb.12
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 07:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678550301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEY3ZLSWUW7XsIa9CCPgTwpcYQffLbl3wrMRUOgD69k=;
        b=U7zIRT3w4Gv+arQEt90+L156snTB3qQ7nhF7QSJ2KRFlNYZ/PAOH8MeUnXLU924LKc
         ZTASA0Ws0xccVJqD2659J6Tnnk7/lPGpxlotNfnAZSSn/peKEVWUPwYa7za8DIXpygYB
         ew6sBga2mr/bVVHDlTGvInBQSSwSQFDDPKwpgh63nhs4v8MIi8LZl3lqnoxUVL12NB/E
         jrac9V5e90uLJ5OXdVcFStCb3G9ovMYUYN4gNGnkRJ7+8rN/Kk9rWgw/s/z2YLBFowHO
         CYT+GaBxCxWVC1QIRxAP1BqeJiDrsWuj1EHb8mXnVFfSdVDAflWNH9jRAOg2+VQF5Cdr
         Zemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678550301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEY3ZLSWUW7XsIa9CCPgTwpcYQffLbl3wrMRUOgD69k=;
        b=3R1IjBKZVWakdLvFNk569h9WqcaZZetndIZ0UGvUgMUm937hN7oV9Eoab4xQXzlouw
         kZLTf/+SKZ3uWNOEmQp9Zfxsml2m+pNqUyES4fWeBSDanA5Ti1YZMsrsVYKMgj3KIdok
         Qe2yYfGpqoHPGgG6IRUKa9re1BtREUSnlOPNfj3Rsl8JNIuLTTKrqnDFD4e+rGfhZdU/
         7vKdDea/I+eQkIoEtseaYF1JC8zitj4cEL6mULeGmqVfD6BC0ygJ35Iy1XduM6oAhtJg
         DQD5GCLdTPJxmxVSOc7oQyUBTBCms6aErPzPZfdxRvwSPui65wIreWFRmRLA3EoKjtwV
         Nr1A==
X-Gm-Message-State: AO0yUKXfGgUr9m9fzCO3A+8B8R+FMqr3VF4RkaZPar7yCv7+/cJxXgGX
        NUMFA2Thh7v0dzzcmDrphrQjDjeMbfj8cwn8k0M=
X-Google-Smtp-Source: AK7set/rTX6aOjV6jOMdTk7oGqNeQp6gP4Q+ddlQbe8TtUA4b1Cv3eKDysAuVFJnI87ZZwYWwojCAg==
X-Received: by 2002:aa7:ce05:0:b0:4ac:bab1:feee with SMTP id d5-20020aa7ce05000000b004acbab1feeemr23294992edv.24.1678550301639;
        Sat, 11 Mar 2023 07:58:21 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:6927:e94d:fc63:9d6e? ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id h14-20020a50c38e000000b004fa610895b5sm865948edf.7.2023.03.11.07.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 07:58:21 -0800 (PST)
Message-ID: <4b6b7aee-bd20-208f-1743-ff76388feffd@linaro.org>
Date:   Sat, 11 Mar 2023 16:58:20 +0100
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
References: <640c80ff.050a0220.2983.0b8d@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640c80ff.050a0220.2983.0b8d@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/03/2023 13:54, Sergey Lisov wrote:
> ---
>  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml    | 6 ++++++

I received your patches twice, so I already responded to one thread. The
comments apply also here.

Best regards,
Krzysztof

