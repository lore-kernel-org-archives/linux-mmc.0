Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BBAC636D6
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Feb 2023 09:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjBCJAb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Feb 2023 04:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjBCJAZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2023 04:00:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF486928E8
        for <linux-mmc@vger.kernel.org>; Fri,  3 Feb 2023 01:00:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n13so3309700wmr.4
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2023 01:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXoAdHhN/nXWyLyZPUiTv4Q4XmY1KdAGzUzsHG/Rk/4=;
        b=EQ75a+A2a/ajqx8kGm+he/MG5JqJRScsCs7zePqdvT18OKGHTuLnVCDHxC+mDWrDZG
         OhTQEQto6HF0AgYT4Avbgk/mQ65mHW52eY9ahBiurEBaJThzk8t/O38jeGsVQRWClp6s
         KHsYlkOwGaAKKTaHgKAE1E8arVdP+OD0tkAnJbahzPvSZqpqIwgb+nGudQe4bDkV7Aix
         zKqp9xm6nnThzNeQ9tw7xERnlLBPPmOF7KhlqhOCT/HW5te9PdcJNyjHCOKsNyP1HYGP
         DaEZwgiTY2cI/iuquNk0hUomjalP7z+V2eNFdExLL2DQcbjz4XJQr8w3lIdWqxzKo8tC
         Ycag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXoAdHhN/nXWyLyZPUiTv4Q4XmY1KdAGzUzsHG/Rk/4=;
        b=W3cJ6OMygKnNX2uOB3udc4oZ56eHy3tn/pMX/w7PMUTiR0fKv90IwobazpLrlkGd9j
         W/Hl2V7KZtUX+WaCClBqhYV4vEWLS0Q4cTQ+878y37gBGIf4hfyhmrdg3mLYTcbeXc3a
         0HMZkZfZiH7gKyb8gx1550v9javcsdBJNW8rootJcVmm4ZmJWaJVR4uYp+ZOerDKaWdL
         TmfXrtD7+0f378CLIqx8gV0DLPuwq/3qHVg+uyn2058AMU1fFGTF08v6WcLZI9llhzXT
         6puWrc6gfCRGC0Zqul+JOtD9tFI838Osn3pCq/CI8sIjgP5i6PR4EDG8/CiPVmAkEj/f
         ZJMA==
X-Gm-Message-State: AO0yUKXzXdwzAz7ZMb67rO+wtJ5YtoMj1YBcYzyB9NJ/ArL6eEwK3HWb
        fxFbabBitoeC65yyb47fZ4rBEw==
X-Google-Smtp-Source: AK7set9UG7Ud3p7osiXX4INl9ByMEzwhEn6pf64Y4FQLsiE5MeXOWMKgknfwGwLF5zdgnCno4AhqXg==
X-Received: by 2002:a05:600c:3acb:b0:3db:f0a:8707 with SMTP id d11-20020a05600c3acb00b003db0f0a8707mr9116756wms.40.1675414822412;
        Fri, 03 Feb 2023 01:00:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c205100b003dd1bd0b915sm4170806wmg.22.2023.02.03.01.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:00:21 -0800 (PST)
Message-ID: <5de1f657-2632-9165-b6ed-96327fab1de4@linaro.org>
Date:   Fri, 3 Feb 2023 10:00:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: Add StarFive MMC module
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
 <20230203081913.81968-2-william.qiu@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203081913.81968-2-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 03/02/2023 09:19, William Qiu wrote:
> Add documentation to describe StarFive designware mobile storage
> host controller driver.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../bindings/mmc/starfive,jh7110-mmc.yaml     | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

