Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0D7C7EE2E
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jun 2023 07:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjFAHA4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jun 2023 03:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjFAHAZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jun 2023 03:00:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98BC186
        for <linux-mmc@vger.kernel.org>; Thu,  1 Jun 2023 00:00:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96fab30d1e1so127069266b.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Jun 2023 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685602808; x=1688194808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZDlrGzZznfoRh38IZ4BuhQJoDgfvEZtOrnmqrwUyyQ=;
        b=ttZtbkT8BFN3nOIpl9ofTPk8v+Lt44fZo5uLadVUPBGWgA+x9LsdD42oeKoIE7R1vf
         44aKBiwmeXDGrKsA65f8N7wvFT7bpRZV7Z2wopeH1jY3E8sKyg+sgBxb2anr1WQ51E8o
         HHan2Ug0EP8LLF5yrYbFUprG4n5ZhnOSfacBYJtHID8jbq8yKhHZANzLMvFT7sZgxWRq
         flj35ew+CxQjJFpXWQgzmXXxPYCj1eUImlMEFy2kaTWPTjpOEro3fv6QtkVuyi6Nbr1X
         Ok/RDMX3/53noGbrXl6CtHAG/1Z8aSyxyfgT1GlCYBNQbVGJyePYc78jiVD9oZpCbQ2M
         A1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685602808; x=1688194808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZDlrGzZznfoRh38IZ4BuhQJoDgfvEZtOrnmqrwUyyQ=;
        b=OeiN2fdGXJqIoO9wstetjP4SoORw4XTAeJ8JCsym1sssJ7OB13qa1+hQgMzKsDofCm
         iCXs7XY0vMgvz13cbjH7wNnaBK9ljw6pt0DXq9gB8hQovW8nk9ituXMg3m0BzoDwukK3
         3dCLwVeoQ++JiXvV4mL06MaVQkVeJljZjFY9s6BdO05eZuJhJ0OKlWxBPXRSihckXwDt
         tNYOLboFEijo9CzZayWFcqFYhpqck90IvBqUJuLikxKMBGIPa06127is8FcXuKUKGGM1
         RHsx93RBpe2nC88cx/MbC9yx1YVZZhgTEkcY61kAi8JZ7ATMHOgWar7jCbZwQgTHLN9J
         PT8g==
X-Gm-Message-State: AC+VfDz/Oo1NW3+t6UUZyNsM7TJh7RLq6RQY3msYn6ocy1Kfm1ARl1nJ
        HDIJiD57ep3U+GdkoTBJfGXd/w==
X-Google-Smtp-Source: ACHHUZ4mh5gVUd0k89XyvS9Bk4MnVaXyEnyBLY0aoruOI8MoHI/h3NUE4U1qUwOiXUadHjPQ7cLlLw==
X-Received: by 2002:a17:907:7d89:b0:96a:1ee9:4b0 with SMTP id oz9-20020a1709077d8900b0096a1ee904b0mr760202ejc.33.1685602808456;
        Thu, 01 Jun 2023 00:00:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id dv22-20020a170906b81600b0096f78953b77sm10125944ejb.147.2023.06.01.00.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:00:07 -0700 (PDT)
Message-ID: <96f40b17-ad7a-ede2-dcbc-a35b6b7df1d2@linaro.org>
Date:   Thu, 1 Jun 2023 09:00:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: qdu1000: Add SDHCI pin
 configuration to DTSI
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601065805.18079-1-quic_kbajaj@quicinc.com>
 <20230601065805.18079-4-quic_kbajaj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601065805.18079-4-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01/06/2023 08:58, Komal Bajaj wrote:
> Add required pins for SDHCI, so that the interface can work reliably.
> 

This is not a separate commit. The pin configuration by itself does not
make sense and we don't need it. It's part of adding SDHCI, so squash it.

Best regards,
Krzysztof

