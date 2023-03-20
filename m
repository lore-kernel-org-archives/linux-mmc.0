Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07628C7619A
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Mar 2023 15:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjCTPgn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Mar 2023 11:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjCTPgV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2023 11:36:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46A51C7D7
        for <linux-mmc@vger.kernel.org>; Mon, 20 Mar 2023 08:28:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ek18so48289783edb.6
        for <linux-mmc@vger.kernel.org>; Mon, 20 Mar 2023 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679326095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvbqjlcL+bcFddHkzakeQEvxE0WZLFtin/eJNP/6Jds=;
        b=FEOyk0ch5NcBUPDFJ9vRXINT4BtRWlDouCCJ816Aj6tFvs26zQZo6D+GNErhheVAid
         kW5KwvupeDkpX+3TgwMAO0w/zysHZyZamDsRnY3p8nkDJjTLBzO1QOqFgi3eZML2VcKn
         17q0N9QM2F0z41UQWbsuFDkOckccgC6yMMDZLZHEbUiycUDMJZDbFIfw/MlzEUaZL45K
         JKK/bCU6IWlkF0imhDntDV+OZFOBrH7kuKxmED/oRLB0P5/8UZTfxqPvk7OY4mMkrrU7
         mWqS0l2zgAcqy1m9l+0uS+8Ut6UimND9YNXyyAWvhz3/xAeSJje/H26bU7CeOVB53nc/
         2Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvbqjlcL+bcFddHkzakeQEvxE0WZLFtin/eJNP/6Jds=;
        b=4vpsIv+MVERQzOLxyMcjkZNQFpB1CI/NOsl3gsy2IFEFkXUON36aNfDtLdm1OebmC5
         hK5pepjkn18FCUWP31jdJ6WOKBzywhjQX5YvIwrxWTbxYmDYgeNanwGG/aETj2S21tWe
         LMTsix3WS9NDCUbuPas/ph73+wDKEBTONoGs1FveCQjzolOJZxe88wQPPf8Vtep3fZnq
         ng+7cT6KX7iAgKeCbu8gpiPZHGCKXLCZhhSmbUefljXmrz3XoTU3jz4VQoGRzzeKG5ob
         OUF6BWJxnp1fyvLWty5Sc1o/aaMxeABmgL7lHoml50fVOdJpf8AISl6JCrapj3ms/hTR
         QPxQ==
X-Gm-Message-State: AO0yUKUmScC4Ug/zFm+ByZUtgPROoMyt5O34zoUpnyDa10UU3RxvuCx6
        j/VBw+RHb0gkmRokJrw9c67kyQ==
X-Google-Smtp-Source: AK7set9o5/mI7mPNEgdgSeUp6yCydHUMivwcHSQX/kXIVqElEKWBRdss2+/J/gJTgoRLEs+1lYT3ww==
X-Received: by 2002:a17:907:779a:b0:8fc:c566:dc67 with SMTP id ky26-20020a170907779a00b008fcc566dc67mr10735529ejc.64.1679326095219;
        Mon, 20 Mar 2023 08:28:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id v4-20020a509544000000b004fb402a2a37sm5084567eda.33.2023.03.20.08.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:28:14 -0700 (PDT)
Message-ID: <2b86ecc8-bc02-dc0b-cc80-51bcc018e4e0@linaro.org>
Date:   Mon, 20 Mar 2023 16:28:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] dt-bindings: mmc: fujitsu: Add Socionext Synquacer
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230319173006.30455-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230319173006.30455-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/03/2023 18:30, Rob Herring wrote:
> Add support for Socionext Synquacer SDHCI. This binding has been in use for
> some time.
> 
> The interrupts were not documented. The driver only uses the first
> interrupt, but the DT and example have 2 interrupts. The 2nd one is
> unknown. "dma-coherent" was also not documented, but is used on Synquacer.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

