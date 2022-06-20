Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE63C43334
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jun 2022 12:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiFTMwG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbiFTMwF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2022 08:52:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E93717E12
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2022 05:52:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id um5so5949720ejb.5
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2022 05:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cWoMh6jcYULMxgiCtSM6Nsx9EX6xJ4oFr3v4h1QaeUA=;
        b=Qd97ylwoHz89QA3GuE9aP4ewPd+umV+YmRiMxUlTlj6PtBU/O2AulZTiXwnHK3gshP
         DEqtxCJz7dgzmbKOLIcD8spegNyAhX/dJHU0tK0vUFVcrLJSW2FSglfqEsgiQNEMh60o
         wfFAZPbbb3Wb4dz/EYkuwEGBzqZrWANeO7YIWMEq8CFJaH9g4yDYXYkI8mQrHH1pHph/
         8l3XTnHtsIteSoi6RGHdedWqjMF+52TPtvONU+ywlZQ2QF+40ovduoBZGodbvZEGKJSa
         KcLzQrhG0sV+QfD+Spcmxvb0KBNuCK5OvCK8IjUudWzuG5BCUojEIBJ8b8GF7lxElNlk
         PkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cWoMh6jcYULMxgiCtSM6Nsx9EX6xJ4oFr3v4h1QaeUA=;
        b=iSueSAHb5+HdCWgbIHECFgL4WDRQnSEMxghLbQYs2NK+vw9PvG9Ugsk4i//Dv1bJsy
         M5gOyviLPDDO2M1pDqHXZ1GwCMN64b5h08euMbvugEQrLAMNySF1KN7JLZldLYbtq8F5
         mqCWfU9k491O8L655cVzh12WgLm7SVca5/KPrOwQvVli2YbrEok1Scn1tZeYDrRa0zfU
         vD5//dpuj8UsHoyw/ToRlA4IXN9BOsx0cd5Rz424GN9j9BjSo1ADSjKcowH0thsOWf6K
         y1B0iD9Pdn0E+Cq6U1H0/x8q5ZSFiKAfIoGuMbtq+WpmxceZzP8gCAweI8gHhT6po6nw
         s2Dg==
X-Gm-Message-State: AJIora/RUY/3g0H5pHqFVTDnVS+8etfhmTnUWYuTrLDEwpGmpeu25ofD
        R4kuhiBU68aDZxAJXaEJ9dda1Q==
X-Google-Smtp-Source: AGRyM1tFwJBKpOFL9z95U+Y6J4vmsN+xYfvk7zpnW8VOrvnI5dwPyBXDTvQIxiK8fOk9X6E0BZWtFQ==
X-Received: by 2002:a17:907:3dac:b0:722:dcbe:6848 with SMTP id he44-20020a1709073dac00b00722dcbe6848mr79363ejc.515.1655729521196;
        Mon, 20 Jun 2022 05:52:01 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c19-20020aa7c753000000b004357063bf60sm5653327eds.41.2022.06.20.05.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 05:52:00 -0700 (PDT)
Message-ID: <1c3a29b8-d462-0619-4e7e-41fcdcc3abdc@linaro.org>
Date:   Mon, 20 Jun 2022 14:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 03/15] dt-bindings: spi: cdns: Add compatible for AMD
 Pensando Elba SoC
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, ulf.hansson@linaro.org, will@kernel.org,
        devicetree@vger.kernel.org
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-4-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613195658.5607-4-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/06/2022 21:56, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Document the cadence qspi controller compatible for AMD Pensando
> Elba SoC boards.  The Elba qspi fifo size is 1024.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
